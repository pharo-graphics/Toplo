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
	e extent: 20 asPoint.
	self waitTestingSpaces.
	self
		assert: e shrinkFeedbackLayer visibility
		equals: BlVisibility visible.
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
ToShrinkableContainerTest >> testIsShrinked [

	| e child |
	e := ToShrinkableContainer new.
	e extent: 100 asPoint.
	space root addChild: e.
	self deny: e isShrinked.
	e enableShrinkLayer: true.
	self deny: e isShrinked.

	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child extent: 50 asPoint.
	e addChild: child.

	self waitTestingSpaces.
	self deny: e isShrinked.
	child extent: 150 asPoint.
	self waitTestingSpaces.
	self assert: e isShrinked.
	^ e
]

{ #category : #tests }
ToShrinkableContainerTest >> testIsShrinkedHorizontally [

	| e  child |
	e := ToShrinkableContainer new.
	" horizontal is the default "
	e checkHorizontalShrinkability.
	e width: 100.
	space root addChild: e.
	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child width: 50.
	e addChild: child.
	self waitTestingSpaces.
	self deny: e isShrinked.
	child width: 150.
	self waitTestingSpaces.
	self assert: e isShrinked.
	e width: 200.
	self waitTestingSpaces.
	self deny: e isShrinked.
	^ e
]

{ #category : #tests }
ToShrinkableContainerTest >> testIsShrinkedHorizontally2 [

	| e  child |
	e := ToShrinkableContainer new.
	" horizontal is the default "
	e checkHorizontalShrinkability.
	e height: 100.
	space root addChild: e.
	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child height: 50.
	e addChild: child.
	self waitTestingSpaces.
	self deny: e isShrinked.
	child height: 150.
	self waitTestingSpaces.
	self deny: e isShrinked.
	e height: 200.
	self waitTestingSpaces.
	self deny: e isShrinked.
	^ e
]

{ #category : #tests }
ToShrinkableContainerTest >> testIsShrinkedVertically [

	| e  child |
	e := ToShrinkableContainer new.
	" horizontal is the default "
	e checkVerticalShrinkability.
	e height: 100.
	space root addChild: e.
	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child height: 50.
	e addChild: child.
	self waitTestingSpaces.
	self deny: e isShrinked.
	child height: 150.
	self waitTestingSpaces.
	self assert: e isShrinked.
	e height: 200.
	self waitTestingSpaces.
	self deny: e isShrinked.
	^ e
]

{ #category : #tests }
ToShrinkableContainerTest >> testIsShrinkedVertically2 [

	| e  child |
	e := ToShrinkableContainer new.
	" horizontal is the default "
	e checkVerticalShrinkability.
	e width: 100.
	space root addChild: e.
	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child width: 50.
	e addChild: child.
	self waitTestingSpaces.
	self deny: e isShrinked.
	child width: 150.
	self waitTestingSpaces.
	self deny: e isShrinked.
	e width: 200.
	self waitTestingSpaces.
	self deny: e isShrinked.
	^ e
]

{ #category : #tests }
ToShrinkableContainerTest >> testShrinkableContainerNotVisible [

	| e child |
	e := ToShrinkableContainer new.
	e enableShrinkLayer: true.
	e extent: 100 asPoint.
	e border: Color red.
	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child extent: 50 asPoint.
	e addChild: child.
	space root addChild: e.
	self waitTestingSpaces.
	self assert: e shrinkFeedbackLayer parent equals: e.
	self
		assert: e shrinkFeedbackLayer visibility
		equals: BlVisibility hidden.
	^ e
]

{ #category : #tests }
ToShrinkableContainerTest >> testShrinkableContainerVisible [

	| e child |
	e := self testShrinkableContainerNotVisible.
	child := e childWithId: #child.
	" make the child size greater than the container size
	this makes the shrink layer visible"
	child extent: 150 asPoint.
	self waitTestingSpaces.
	self
		assert: e shrinkFeedbackLayer visibility
		equals: BlVisibility visible.
	^ e
]
