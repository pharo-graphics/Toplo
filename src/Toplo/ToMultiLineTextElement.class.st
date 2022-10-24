Class {
	#name : #ToMultiLineTextElement,
	#superclass : #BlElement,
	#traits : 'TObservable + TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TObservable classTrait + TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'#lines',
		'#text => ObservableSlot'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #accessing }
ToMultiLineTextElement >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToMultiLineTextElement >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #initialization }
ToMultiLineTextElement >> initialize [

	self class initializeSlots: self.
	super initialize.
	self fitContent.
	self layout: BlLinearLayout vertical.
	lines := OrderedCollection new.
	self onTextReplacedDo: [ :t | self textChanged ]
]

{ #category : #'private - text splitting' }
ToMultiLineTextElement >> newLineElement [

	^ AlbTextEditorSegmentElement new
		  layout: BlFlowLayout new;
		  constraintsDo: [ :c | 
			  c horizontal fitContent.
			  c vertical fitContent ];
		  beInSeparateCompositionLayer;
		  yourself
]

{ #category : #'slot - change hook' }
ToMultiLineTextElement >> onTextReplacedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]

{ #category : #'private - text splitting' }
ToMultiLineTextElement >> splitText [

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
ToMultiLineTextElement >> text [

	^ text 
]

{ #category : #accessing }
ToMultiLineTextElement >> text: aBlText [

	text = aBlText ifTrue: [ ^ self ].
	text := aBlText
]

{ #category : #'event handling' }
ToMultiLineTextElement >> textChanged [

	self removeChildren.
	lines := self splitText.
	self addChildren: lines.
]

{ #category : #accessing }
ToMultiLineTextElement >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToMultiLineTextElement >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]
