"
A ToShrinkableContainerTest is a test class for testing the behavior of ToShrinkableContainer
"
Class {
	#name : #ToShrinkableContainerTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Overlay'
}

{ #category : #tests }
ToShrinkableContainerTest >> testContainerSizeChange [

	| e |
	e := self testShrinkableContainerNotVisible.
	" make the container size smaller than the child size
	this makes the shrink layer visible"
	e size: 20 asPoint.
	self waitTestingSpaces.
	self assert: e shrinkFeedbackLayer visibility equals: BlVisibility visible.
	^ e
]

{ #category : #tests }
ToShrinkableContainerTest >> testEnableShrinkLayer [

	| e  |
	e := ToShrinkableContainer new.
	space root addChild: e.
	e enableShrinkLayer: true.
	self assert: e shrinkFeedbackLayer notNil.
	self assert: (e shrinkFeedbackLayer isKindOf: ToShrinkFeedbackLayer).
	self assert: e shrinkFeedbackLayer visibility equals: BlVisibility hidden.
	self waitTestingSpaces.
	^ e
]

{ #category : #tests }
ToShrinkableContainerTest >> testEnableShrinkLayer2 [

	| e  |
	e := ToShrinkableContainer new.
	space root addChild: e.
	e enableShrinkLayer: true.
	self assert: e shrinkFeedbackLayer notNil.
	e enableShrinkLayer: false.
	self assert: e shrinkFeedbackLayer isNil.
	^ e
]

{ #category : #tests }
ToShrinkableContainerTest >> testShrinkableContainerNotVisible [

	| e child |
	e := ToShrinkableContainer new.
	e enableShrinkLayer: true.
	e size: 100 asPoint.
	e border: Color red.
	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child size: 50 asPoint.
	e addChild: child.
	space root addChild: e.
	self waitTestingSpaces.
	self assert: e shrinkFeedbackLayer parent equals: e.
	self assert: e shrinkFeedbackLayer visibility equals: BlVisibility hidden.
	^ e
]

{ #category : #tests }
ToShrinkableContainerTest >> testShrinkableContainerVisible [

	| e child |
	e := self testShrinkableContainerNotVisible.
	child := e childWithId: #child.
	" make the child size greater than the container size
	this makes the shrink layer visible"
	child size: 150 asPoint.
	self waitTestingSpaces.
	self assert: e shrinkFeedbackLayer visibility equals: BlVisibility visible.
	^ e
]
