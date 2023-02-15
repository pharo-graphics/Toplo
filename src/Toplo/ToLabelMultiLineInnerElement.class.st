Class {
	#name : #ToLabelMultiLineInnerElement,
	#superclass : #BlElement,
	#traits : 'TToLabelInnerElement + TObservable + TOBlLayoutResizable',
	#classTraits : 'TToLabelInnerElement classTrait + TObservable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'#lines',
		'#text => ObservableSlot'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #'api - editor' }
ToLabelMultiLineInnerElement >> editorShortcutsIn: aLabel [

	^ { 
		  (BlShortcutWithAction new
			   combination: (BlKeyCombination primaryReturn or: BlKeyCombination primaryS);
			   action: [ 
				   aLabel text: aLabel editor text.
				   aLabel removeEditor ];
			   description: 'Accept the edited text';
			   name: 'Accept';
			   yourself).
		  (BlShortcutWithAction new
			   combination: (BlKeyCombination escape or: BlKeyCombination primaryL);
			   action: [ aLabel removeEditor ];
			   description: 'Escape from text editing';
			   name: 'Escape';
			   yourself) }
]

{ #category : #initialization }
ToLabelMultiLineInnerElement >> initialize [

	self class initializeSlots: self.
	super initialize.
	self fitContent.
	self layout: BlLinearLayout vertical.
	lines := OrderedCollection new.
	self whenTextReplacedDo: [ :t | self textReplaced ].
	self preventMouseEvents 
]

{ #category : #'api - editor' }
ToLabelMultiLineInnerElement >> newEditorIn: aLabel [

	| ed |
	ed := ToAlbum new dresser: (ToLabelEditorDresser label: aLabel).
	(self editorShortcutsIn: aLabel) do: [ :s | ed editor addEditorShortcut: s ].
	^ ed
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> newLineElement [

	^ AlbTextEditorSegmentElement new
		  layout: BlFlowLayout new;
		  constraintsDo: [ :c | 
			  c horizontal fitContent.
			  c vertical fitContent ];
		  yourself
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> splitText [

	^ Array streamContents: [ :stream | 
		  | itor lineElement |
		  text
			  ifEmpty: [
				  lineElement := self newLineElement
					                 addChild: ('' asRopedText attributes: text iterator attributes) asElement labelMeasurement;
					                 yourself.
				  stream nextPut: lineElement ]
			  ifNotEmpty: [ 
				  itor := text iterator.
				  [ itor hasNext ] whileTrue: [ 
					  itor nextLineIndicesDo: [ :aLineStart :aLineEnd :aLineDelimiterEnd | 
						  | sub cutted |
						  sub := text from: aLineStart to: aLineEnd.
						  cutted := ToTextScissor new cut: sub.
						  cutted ifEmpty: [ cutted := Array with: (BlText empty attributes: sub iterator attributes) ].
						  lineElement := self newLineElement
							                 addChildren: (cutted collect: [ :w | w asElement labelMeasurement ]);
							                 yourself.
						  stream nextPut: lineElement ] ] ] ]
]

{ #category : #accessing }
ToLabelMultiLineInnerElement >> text [

	^ text 
]

{ #category : #accessing }
ToLabelMultiLineInnerElement >> text: aBlText [

	text = aBlText ifTrue: [ ^ self ].
	text := aBlText
]

{ #category : #'event handling' }
ToLabelMultiLineInnerElement >> textReplaced [

	self removeChildren.
	lines := self splitText.
	self addChildren: lines.
	self dispatchEvent: (ToTextReplacedEvent new text: self text)

]

{ #category : #'slot - change hook' }
ToLabelMultiLineInnerElement >> whenTextReplacedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]
