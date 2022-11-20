Class {
	#name : #ToLabelMultiLineInnerElement,
	#superclass : #BlElement,
	#traits : 'TToLabelInnerElement + TToObservable + TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TToLabelInnerElement classTrait + TToObservable classTrait + TBlAlignable classTrait + TOBlLayoutResizable classTrait',
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

{ #category : #accessing }
ToLabelMultiLineInnerElement >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToLabelMultiLineInnerElement >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #initialization }
ToLabelMultiLineInnerElement >> initialize [

	self class initializeSlots: self.
	super initialize.
	self fitContent.
	self layout: BlLinearLayout vertical.
	lines := OrderedCollection new.
	self whenTextReplacedDo: [ :t | self textReplaced ]
]

{ #category : #'api - editor' }
ToLabelMultiLineInnerElement >> newEditorIn: aLabel [

	| ed |
	ed := ToAlbum new dresser: ToLabelEditorBasicDresser new.
	(self editorShortcutsIn: aLabel) do: [ :s | ed innerElement editor addEditorShortcut: s ].
	self flag: 'ed matchParent here leads to a Pharo crash'.
	"ed vFitContent.
	ed hMatchParent."
	^ ed
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> newLineElement [

	^ AlbTextEditorSegmentElement new
		  layout: BlFlowLayout new;
		  constraintsDo: [ :c | 
			  c horizontal fitContent.
			  c vertical fitContent ];
		  beInSeparateCompositionLayer;
		  yourself
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> splitText [

	^ Array streamContents: [ :stream | 
		  | itor lineElement |
		  text
			  ifEmpty: [
				  lineElement := self newLineElement
					                 addChild: ('' asRopedText attributes: text iterator attributes) asElement editorMeasurement;
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
							                 addChildren: (cutted collect: [ :w | w asElement editorMeasurement ]);
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

{ #category : #accessing }
ToLabelMultiLineInnerElement >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToLabelMultiLineInnerElement >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]

{ #category : #'slot - change hook' }
ToLabelMultiLineInnerElement >> whenTextReplacedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]
