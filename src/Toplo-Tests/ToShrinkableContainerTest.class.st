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
	space deferAndSettle: [ e extent: 20 asPoint ].
	self
		assert: e shrinkFeedbackLayer visibility
		equals: BlVisibility visible
]

{ #category : #tests }
ToShrinkableContainerTest >> testEnableShrinkLayer [

	| e |
	e := ToShrinkableContainer new.
	space deferAndSettle: [
		space root addChild: e.
		e enableShrinkLayer: true ].
	self assert: e shrinkFeedbackLayer notNil.
	self assert: (e shrinkFeedbackLayer isKindOf: ToShrinkFeedbackLayer).
	self assert: e shrinkFeedbackLayer visibility equals: BlVisibility hidden
]

{ #category : #tests }
ToShrinkableContainerTest >> testEnableShrinkLayer2 [

	| e |
	e := ToShrinkableContainer new.
	space deferAndSettle: [
		space root addChild: e.
		e enableShrinkLayer: true ].
	self assert: e shrinkFeedbackLayer notNil.

	space deferAndSettle: [ e enableShrinkLayer: false ].
	self assert: e shrinkFeedbackLayer isNil
]

{ #category : #tests }
ToShrinkableContainerTest >> testIsShrinked [

	| e child |
	e := ToShrinkableContainer new.
	e extent: 100 asPoint.
	space deferAndSettle: [ space root addChild: e ].
	self deny: e isShrinked.

	space deferAndSettle: [ e enableShrinkLayer: true ].
	self deny: e isShrinked.

	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child extent: 50 asPoint.
	space deferAndSettle: [ e addChild: child ].
	self deny: e isShrinked.

	space deferAndSettle: [ child extent: 150 asPoint ].
	self assert: e isShrinked
]

{ #category : #tests }
ToShrinkableContainerTest >> testIsShrinkedHorizontally [

	| e child |
	e := ToShrinkableContainer new.
	" horizontal is the default "
	e checkHorizontalShrinkability.
	e width: 100.
	space deferAndSettle: [ space root addChild: e ].
	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child width: 50.
	space deferAndSettle: [ e addChild: child ].
	self deny: e isShrinked.

	space deferAndSettle: [ child width: 150 ].
	self assert: e isShrinked.

	space deferAndSettle: [ e width: 200 ].
	self deny: e isShrinked
]

{ #category : #tests }
ToShrinkableContainerTest >> testIsShrinkedHorizontally2 [

	| e child |
	e := ToShrinkableContainer new.
	" horizontal is the default "
	e checkHorizontalShrinkability.
	e height: 100.
	space deferAndSettle: [ space root addChild: e ].
	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child height: 50.
	space deferAndSettle: [ e addChild: child ].
	self deny: e isShrinked.

	space deferAndSettle: [ child height: 150 ].
	self deny: e isShrinked.

	space deferAndSettle: [ e height: 200 ].
	self deny: e isShrinked
]

{ #category : #tests }
ToShrinkableContainerTest >> testIsShrinkedVertically [

	| e child |
	e := ToShrinkableContainer new.
	" horizontal is the default "
	e checkVerticalShrinkability.
	e height: 100.
	space deferAndSettle: [ space root addChild: e ].
	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child height: 50.
	space deferAndSettle: [ e addChild: child ].
	self deny: e isShrinked.

	space deferAndSettle: [ child height: 150 ].
	self assert: e isShrinked.

	space deferAndSettle: [ e height: 200 ].
	self deny: e isShrinked
]

{ #category : #tests }
ToShrinkableContainerTest >> testIsShrinkedVertically2 [

	| e child |
	e := ToShrinkableContainer new.
	" horizontal is the default "
	e checkVerticalShrinkability.
	e width: 100.
	space deferAndSettle: [ space root addChild: e ].
	child := ToElement new.
	child id: #child.
	" make the child size less than the container size
	this let the shrink layer invisible"
	child width: 50.
	space deferAndSettle: [ e addChild: child ].
	self deny: e isShrinked.

	space deferAndSettle: [ child width: 150 ].
	self deny: e isShrinked.

	space deferAndSettle: [ e width: 200 ].
	self deny: e isShrinked
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
	space deferAndSettle: [ space root addChild: e ].
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
	space deferAndSettle: [ child extent: 150 asPoint ].
	self
		assert: e shrinkFeedbackLayer visibility
		equals: BlVisibility visible
]
