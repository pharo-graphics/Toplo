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
	space deferAndSettle: [
		space root addChild: pane.
		child1 := ToElement new.
		child2 := ToElement new.
		pane addChildren: {
			child1.
			child2 } ]
]

{ #category : #tests }
TToOrientableTest >> testBeHorizontal [

	| ocpt |
	" to be sure pane is horizontal"
	space deferAndSettle: [ pane beHorizontal ].
	ocpt := oriCpt.
	space deferAndSettle: [ pane beHorizontal ].
	" no event sent "
	self assert: oriCpt equals: ocpt.

	space deferAndSettle: [ pane beVertical ].
	ocpt := oriCpt.
	space deferAndSettle: [ pane beHorizontal ].
	" orientation changed -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isHorizontal.
	self assert: pane isVertical not.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToOrientableTest >> testBeVertical [

	| ocpt |
	" to be sure pane is horizontal"
	space deferAndSettle: [ pane beVertical ].
	ocpt := oriCpt.
	space deferAndSettle: [ pane beVertical ].
	" no event sent "
	self assert: oriCpt equals: ocpt.

	space deferAndSettle: [ pane beHorizontal ].
	ocpt := oriCpt.
	space deferAndSettle: [ pane beVertical ].
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isVertical.
	self assert: pane isHorizontal not.
	self assert: child1 bounds bottom equals: child2 bounds top.
	self assert: child1 bounds left equals: child2 bounds left
]

{ #category : #tests }
TToOrientableTest >> testHorizontal [

	| ocpt |
	" to be sure pane is horizontal"
	space deferAndSettle: [ pane horizontal: true ].
	ocpt := oriCpt.
	space deferAndSettle: [ pane horizontal: true ].
	" no event sent "
	self assert: oriCpt equals: ocpt.

	space deferAndSettle: [ pane horizontal: false ].
	ocpt := oriCpt.
	space deferAndSettle: [ pane horizontal: true ].
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isHorizontal.
	self assert: pane isVertical not.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToOrientableTest >> testIsHorizontal [

	space deferAndSettle: [
		pane beHorizontal.
		pane beVertical.
		pane beHorizontal ].
	self assert: pane isHorizontal.

	space deferAndSettle: [ pane beVertical ].
	self assert: pane isHorizontal not
]

{ #category : #tests }
TToOrientableTest >> testIsVertical [

	space deferAndSettle: [
		pane beVertical.
		pane beHorizontal.
		pane beVertical ].
	self assert: pane isVertical.

	space deferAndSettle: [ pane beHorizontal ].
	self assert: pane isVertical not
]

{ #category : #tests }
TToOrientableTest >> testOrientation [

	| ocpt |
	space deferAndSettle: [ pane orientation: BlLinearLayoutOrientation vertical ].
	ocpt := oriCpt.
	" sure pane is vertical -> no event sent "
	space deferAndSettle: [ pane orientation: BlLinearLayoutOrientation vertical ].
	" no event sent "
	self assert: oriCpt equals: ocpt.

	space deferAndSettle: [ pane orientation: BlLinearLayoutOrientation horizontal ].
	ocpt := oriCpt.
	space deferAndSettle: [ pane orientation: BlLinearLayoutOrientation vertical ].
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isVertical.
	self assert: pane isHorizontal not.
	self assert: child1 bounds bottom equals: child2 bounds top.
	self assert: child1 bounds left equals: child2 bounds left.

	" now for the inverted orientation "
	space deferAndSettle: [ pane orientation: BlLinearLayoutOrientation horizontal ].
	ocpt := oriCpt.
	" sure pane is vertical -> no event sent "
	space deferAndSettle: [ pane orientation: BlLinearLayoutOrientation horizontal ].
	" no event sent "
	self assert: oriCpt equals: ocpt.

	space deferAndSettle: [ pane orientation: BlLinearLayoutOrientation vertical ].

	ocpt := oriCpt.
	space deferAndSettle: [ pane orientation: BlLinearLayoutOrientation horizontal ].
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isHorizontal.
	self assert: pane isVertical not.

	space deferAndSettle: [ pane requestNewSkin ].
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToOrientableTest >> testVertical [

	| ocpt |
	" to be sure pane is horizontal"
	space deferAndSettle: [ pane vertical: true ].
	ocpt := oriCpt.
	space deferAndSettle: [ pane vertical: true ].
	" no event sent "
	self assert: oriCpt equals: ocpt.

	space deferAndSettle: [ pane vertical: false ].
	ocpt := oriCpt.
	space deferAndSettle: [ pane vertical: true ].
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isVertical.
	self assert: pane isHorizontal not.
	self assert: child1 bounds bottom equals: child2 bounds top.
	self assert: child1 bounds left equals: child2 bounds left
]

{ #category : #tests }
TToOrientableTest >> testVerticalRightToLeft [

	" to be sure pane is leftToRight"
	space deferAndSettle: [
		pane rightToLeft: true.
		pane vertical: true ].
	self assert: child2 bounds left equals: child1 bounds left.
	self assert: child2 bounds bottom equals: child1 bounds top
]
