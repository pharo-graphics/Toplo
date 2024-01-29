Class {
	#name : #ToLabelMultiLineInnerElement,
	#superclass : #BlElement,
	#traits : 'TToLabelInnerElement',
	#classTraits : 'TToLabelInnerElement classTrait',
	#instVars : [
		'lines',
		'text'
	],
	#category : #'Toplo-Widget-Album-Label'
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

	lines := OrderedCollection new.
	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent ].
	self layout: BlLinearLayout vertical.
	self preventMouseEvents
]

{ #category : #'api - editor' }
ToLabelMultiLineInnerElement >> newEditorIn: aLabel [

	| ed |
	ed := ToTextField new.
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

	^ BlTextElement new labelMeasurement
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
			  ifEmpty: [
				  | textElement |
				  textElement := self newTextElement.
				  textElement text:
					  ('' asRopedText attributes: text iterator attributes).
				  lineElement := self newLineElement
					                 addChild: textElement;
					                 yourself.
				  stream nextPut: lineElement ]
			  ifNotEmpty: [
				  itor := text iterator.
				  [ itor hasNext ] whileTrue: [
					  itor nextLineIndicesDo: [ :aLineStart :aLineEnd :aLineDelimiterEnd |
						  | sub cutted |
						  sub := text from: aLineStart to: aLineEnd.
						  cutted := ToTextScissor new cut: sub.
						  cutted ifEmpty: [
							  cutted := Array with:
								            (BlText empty attributes: sub iterator attributes) ].
						  lineElement := self newLineElement
							                 addChildren: (cutted collect: [ :w |
										                  | textElement |
										                  textElement := self newTextElement.
										                  textElement text: w.
										                  textElement ]);
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

	self removeChildren.
	lines := self splitText.
	self addChildren: lines
]
