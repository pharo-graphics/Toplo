Class {
	#name : #ToLabel,
	#superclass : #ToBasicWidget,
	#traits : 'TBlTextStyleable + TToAlignable',
	#classTraits : 'TBlTextStyleable classTrait + TToAlignable classTrait',
	#instVars : [
		'#textElement',
		'#text => ObservableSlot'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #'accessing-alignment' }
ToLabel >> alignmentTarget [

	^ self textElement
]

{ #category : #accessing }
ToLabel >> attributesBuilder [

	<return: #BlTextAttributesBuilder>
	^ self textElement attributesBuilder 
]

{ #category : #initialization }
ToLabel >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	textElement := BlAttributedTextElement new.
	textElement background: self defaultBackground.
	self addChild: textElement.
	"self hAlignment: #left.
	self vAlignment: #center."
	self textChanged
]

{ #category : #accessing }
ToLabel >> text [

	^ text
]

{ #category : #accessing }
ToLabel >> text: aStringOrBlText [

	aStringOrBlText ~= self text ifFalse: [ ^ self ].
	text := aStringOrBlText ifNotNil: [ :s | s asString ].
	self textChanged
]

{ #category : #accessing }
ToLabel >> textChanged [

	self textElement text: (self text ifNil: [ '' ]) asRopedText

]

{ #category : #accessing }
ToLabel >> textElement [

	^ textElement
]
