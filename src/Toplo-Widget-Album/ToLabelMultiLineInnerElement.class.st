Class {
	#name : #ToLabelMultiLineInnerElement,
	#superclass : #ToElement,
	#traits : 'TToLabelInnerElement + TObservable',
	#classTraits : 'TToLabelInnerElement classTrait + TObservable classTrait',
	#instVars : [
		'#lines',
		'#text => ObservableSlot'
	],
	#category : 'Toplo-Widget-Album-Label'
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

	super initialize.
	self class initializeSlots: self.
	
	lines := OrderedCollection new.
	self fitContent.
	self layout: BlLinearLayout vertical.
	self whenTextReplacedDo: [ :t | self textReplaced ].
	self preventMouseEvents.
	self withoutSkin.
]

{ #category : #'api - editor' }
ToLabelMultiLineInnerElement >> newEditorIn: aLabel [

	| ed handler |
	handler := ToLabelEditorEventHandler new label: aLabel.
	ed := ToAlbum new.
	ed fitContent.
	ed next fitContent.
	ed infinite fitContent.
	ed next background: Color transparent.
	ed next padding: aLabel padding.
	ed next margin: aLabel margin.
	ed addEventHandler: handler.
	
	self flag: 'Why this selection handler ?'.
	"ed addEventHandler: (AlbTextEditorSelectionHandler new element: ed infinite)."
	"ed addEventHandler: (AlbTextEditorMouseHandler new element: ed infinite )."
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
ToLabelMultiLineInnerElement >> newTextElement [

	^ BlAttributedTextElement new labelMeasurement
]

{ #category : #layout }
ToLabelMultiLineInnerElement >> requestLayout [ 
	lines ifNotNil: [ 
		lines do: [:l | l childrenDo: #requestLayout] ].
	super requestLayout
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> splitText [

	^ Array streamContents: [ :stream | 
		  | itor lineElement |
		  text
			  ifEmpty: [ | textElement |
					textElement := self newTextElement.
					textElement text: ('' asRopedText attributes: text iterator attributes).
				 	lineElement := self newLineElement addChild: textElement ;                 yourself.
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
							                 addChildren: (cutted collect: [ :w | | textElement |
				textElement := self newTextElement.
				textElement text: w.
				textElement]);
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
	text := aBlText.
	self textChanged.
	self forceLocalLayout
]

{ #category : #'event handling' }
ToLabelMultiLineInnerElement >> textChanged [

	self textReplaced
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
