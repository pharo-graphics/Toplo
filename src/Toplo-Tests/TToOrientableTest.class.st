"
A TToOrientableTest is a test class for testing the behavior of TToOrientable
"
Class {
	#name : #TToOrientableTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'pane',
		'child1',
		'child2',
		'oriCpt'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #running }
TToOrientableTest >> setUp [

	super setUp.
	pane := ToPane new.
	oriCpt := 0.
	pane addEventHandler: (BlEventHandler
			 on: ToLayoutOrientationChangedEvent
			 do: [ oriCpt := oriCpt + 1 ]).
	space root addChild: pane.
	child1 := ToElement new.
	child2 := ToElement new.
	pane addChildren: {
			child1.
			child2 }
]

{ #category : #tests }
TToOrientableTest >> testBeHorizontal [

	| ocpt |
	" to be sure pane is horizontal"
	pane beHorizontal.
	ocpt := oriCpt.
	pane beHorizontal.
	" no event sent "
	self assert: oriCpt equals: ocpt.
	pane beVertical.
	ocpt := oriCpt.
	pane beHorizontal.
	" orientation changed -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isHorizontal.
	self assert: pane isVertical not.
	self waitTestingSpaces.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToOrientableTest >> testBeVertical [
	" to be sure pane is horizontal"

	| ocpt |
	pane beVertical.
	ocpt := oriCpt.
	pane beVertical.
	" no event sent "
	self assert: oriCpt equals: ocpt.
	pane beHorizontal.
	ocpt := oriCpt.
	pane beVertical.
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isVertical.
	self assert: pane isHorizontal not.
	self waitTestingSpaces.
	self assert: child1 bounds bottom equals: child2 bounds top.
	self assert: child1 bounds left equals: child2 bounds left
]

{ #category : #tests }
TToOrientableTest >> testHorizontal [
	" to be sure pane is horizontal"

	| ocpt |
	pane horizontal: true.
	ocpt := oriCpt.
	pane horizontal: true.
	" no event sent "
	self assert: oriCpt equals: ocpt.
	pane horizontal: false.
	ocpt := oriCpt.
	pane horizontal: true.
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isHorizontal.
	self assert: pane isVertical not.
	self waitTestingSpaces.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToOrientableTest >> testIsHorizontal [

	pane beHorizontal.
	pane beVertical.
	pane beHorizontal.
	self assert: pane isHorizontal.
	pane beVertical.
	self assert: pane isHorizontal not.
]

{ #category : #tests }
TToOrientableTest >> testIsVertical [

	pane beVertical.
	pane beHorizontal.
	pane beVertical.
	self assert: pane isVertical.
	pane beHorizontal.
	self assert: pane isVertical not.
]

{ #category : #tests }
TToOrientableTest >> testOrientation [

	| ocpt |
	pane orientation: BlLinearLayoutOrientation vertical.
	ocpt := oriCpt.
	" sure pane is vertical -> no event sent "
	pane orientation: BlLinearLayoutOrientation vertical.
	" no event sent "
	self assert: oriCpt equals: ocpt.
	pane orientation: BlLinearLayoutOrientation horizontal.
	ocpt := oriCpt.
	pane orientation: BlLinearLayoutOrientation vertical.
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isVertical.
	self assert: pane isHorizontal not.
	self waitTestingSpaces.
	self assert: child1 bounds bottom equals: child2 bounds top.
	self assert: child1 bounds left equals: child2 bounds left.

	" now for the inverted orientation "
	pane orientation: BlLinearLayoutOrientation horizontal.
	ocpt := oriCpt.
	" sure pane is vertical -> no event sent "
	pane orientation: BlLinearLayoutOrientation horizontal.
	" no event sent "
	self assert: oriCpt equals: ocpt.
	pane orientation: BlLinearLayoutOrientation vertical.
	ocpt := oriCpt.
	pane orientation: BlLinearLayoutOrientation horizontal.
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isHorizontal.
	self assert: pane isVertical not.
	pane requestNewSkin.
	self waitTestingSpaces.

	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToOrientableTest >> testVertical [
	" to be sure pane is horizontal"

	| ocpt |
	pane vertical: true.
	ocpt := oriCpt.
	pane vertical: true.
	" no event sent "
	self assert: oriCpt equals: ocpt.
	pane vertical: false.
	ocpt := oriCpt.
	pane vertical: true.
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isVertical.
	self assert: pane isHorizontal not.
	self waitTestingSpaces.
	self assert: child1 bounds bottom equals: child2 bounds top.
	self assert: child1 bounds left equals: child2 bounds left
]

{ #category : #tests }
TToOrientableTest >> testVerticalRightToLeft [

	" to be sure pane is leftToRight"
	pane rightToLeft: true.
	pane vertical: true.
	self waitTestingSpaces.
	self assert: child2 bounds left equals: child1 bounds left.
	self assert: child2 bounds bottom equals: child1 bounds top
]
