Class {
	#name : #ToMultiLineTextElement,
	#superclass : #BlElement,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#lines',
		'#text => ObservableSlot'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #initialization }
ToMultiLineTextElement >> initialize [

	self class initializeSlots: self.
	super initialize.
	self
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ];
		layout: BlLinearLayout vertical.
	lines := OrderedCollection new.
	self whenTextChangedDo: [ :t | self textChanged ]
]

{ #category : #'private - text splitting' }
ToMultiLineTextElement >> splitText [

	^ Array streamContents: [ :stream | 
		  | itor |
		  itor := text iterator.

		  [ itor hasNext ] whileTrue: [ 
			  itor nextLineIndicesDo: [ :aLineStart :aLineEnd :aLineDelimiterEnd | 
				  | sub cutted lineElement |
				  sub := text from: aLineStart to: aLineEnd.
				  cutted := ToTextScissor new cut: sub.
				  cutted ifEmpty: [ cutted := Array with: (BlText empty attributes: sub iterator attributes) ].
				  lineElement := BlElement new
					                 layout: AlbLineFlowLayout new;
					                 constraintsDo: [ :c | 
						                 c horizontal matchParent.
						                 c vertical fitContent ];
					                 addChildren: (cutted collect: [ :w | w asElement editorMeasurement ]).
				  stream nextPut: lineElement ] ] ]
]

{ #category : #accessing }
ToMultiLineTextElement >> text: aBlText [

	text = aBlText ifTrue: [ ^ self ].
	text := aBlText
]

{ #category : #'event handling' }
ToMultiLineTextElement >> textChanged [

	lines := self splitText.
	self addChildren: lines.
]

{ #category : #'slot - change hook' }
ToMultiLineTextElement >> whenTextChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]
