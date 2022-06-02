Class {
	#name : #ToLabel,
	#superclass : #ToBasicWidget,
	#traits : 'TToAlignable + TToLayoutResizable',
	#classTraits : 'TToAlignable classTrait + TToLayoutResizable classTrait',
	#instVars : [
		'textElement',
		'text'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #private }
ToLabel >> alignmentTarget [

	^ self textElement
]

{ #category : #initialization }
ToLabel >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self viewModel: ToLabelModel new.
	textElement := BlAttributedTextElement new.
	textElement background: self defaultBackground.
	self hMatchParent.
	self vFitContent.
	self addChild: textElement.
	self
		when: ToLabelChanged
		do: [ :anEvent | self textChanged: anEvent text ]
]

{ #category : #accessing }
ToLabel >> text [
	<return: #BlText>

	^ self viewModel text
]

{ #category : #accessing }
ToLabel >> text: aStringOrBlText [

	aStringOrBlText ~= self text ifFalse: [ ^ self ].
	self textChanged: aStringOrBlText.
]

{ #category : #accessing }
ToLabel >> textChanged: aText [

	self textElement text: aText asRopedText
]

{ #category : #accessing }
ToLabel >> textElement [

	^ textElement
]
