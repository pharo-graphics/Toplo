Class {
	#name : #ToLabel,
	#superclass : #ToBasicWidget,
	#traits : 'TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'textElement'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #accessing }
ToLabel >> defaultText [
	^ self textElement defaultText
]

{ #category : #accessing }
ToLabel >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self textElement constraints frame horizontal alignment
]

{ #category : #accessing }
ToLabel >> horizontalAlignment: aBlElementAlignment [
	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self textElement constraintsDo: [ :c | c frame horizontal alignment: aBlElementAlignment].

]

{ #category : #initialization }
ToLabel >> initialize [

	super initialize.
	textElement := BlAttributedTextElement new.
	textElement background: self defaultBackground.
	self layout: BlFrameLayout new.
	self viewModel: ToLabelModel new.
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
	| t |

	t := (aStringOrBlText ifNil: [self textElement defaultText]).
	t asString ~= self text asString ifFalse: [ ^ self ].
	self viewModel text: t asRopedText
]

{ #category : #accessing }
ToLabel >> textChanged: aText [

	self textElement text: aText asRopedText
]

{ #category : #accessing }
ToLabel >> textElement [

	^ textElement
]

{ #category : #accessing }
ToLabel >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self textElement constraints frame vertical alignment
]

{ #category : #accessing }
ToLabel >> verticalAlignment: aBlElementAlignment [
	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self textElement constraintsDo: [ :c | c frame vertical alignment: aBlElementAlignment].

]
