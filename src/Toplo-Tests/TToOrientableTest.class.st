"
A TToOrientableTest is a test class for testing the behavior of TToOrientable
"
Class {
	#name : #TToOrientableTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'space',
		'pane',
		'child1',
		'child2',
		'oriCpt',
		'dirCpt'
	],
	#category : 'Toplo-Tests-Core'
}

{ #category : #running }
TToOrientableTest >> setUp [ 

	super setUp.
	space := self newTestingSpace.
	pane := ToPane new.
	oriCpt := 0.
	dirCpt := 0.
	pane when: ToLayoutOrientationChangedEvent do: [ oriCpt := oriCpt + 1 ].
	pane when: ToLayoutDirectionChangedEvent do: [ dirCpt := dirCpt + 1 ].
	space root addChild: pane.
	child1 := ToElement new.
	child2 := ToElement new.
	pane addChildren: { child1. child2 }.

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
TToOrientableTest >> testBeLeftToRight [

	| dcpt |
	" to be sure pane is leftToRight"
	pane beLeftToRight.
	dcpt := dirCpt.
	pane beLeftToRight.
	" no event sent "
	self assert: dirCpt equals: dcpt.
	pane beRightToLeft.
	dcpt := dirCpt.
	pane beLeftToRight.
	" direction chaged -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isLeftToRight.
	self assert: pane isRightToLeft not.
	self waitTestingSpaces.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToOrientableTest >> testBeRightToLeft [

	| dcpt |
	" to be sure pane is leftToRight"
	pane beRightToLeft.
	dcpt := dirCpt.
	pane beRightToLeft.
	" no event sent "
	self assert: dirCpt equals: dcpt.
	pane beLeftToRight.
	dcpt := dirCpt.
	pane beRightToLeft.
	" direction chaged -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isRightToLeft.
	self assert: pane isLeftToRight not.
	self waitTestingSpaces.
	self assert: child2 bounds right equals: child1 bounds left.
	self assert: child2 bounds top equals: child1 bounds top
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
TToOrientableTest >> testDirection [

	| dcpt |
	pane direction: BlLayoutDirection rightToLeft.
	dcpt := dirCpt.
	" sure pane is rightToLeft -> no event sent "
	pane direction: BlLayoutDirection rightToLeft.
	" no event sent "
	self assert: dirCpt equals: dcpt.
	pane direction: BlLayoutDirection leftToRight.
	dcpt := dirCpt.
	pane direction: BlLayoutDirection rightToLeft.
	" direction changed -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isRightToLeft.
	self assert: pane isLeftToRight not.
	self waitTestingSpaces.
	self assert: child2 bounds right equals: child1 bounds left.
	self assert: child2 bounds top equals: child1 bounds top.

	" now for the inverted direction "
	pane direction: BlLayoutDirection leftToRight.
	dcpt := dirCpt.
	" sure pane is leftToRight -> no event sent "
	pane direction: BlLayoutDirection leftToRight.
	" no event sent "
	self assert: dirCpt equals: dcpt.
	pane direction: BlLayoutDirection rightToLeft.
	dcpt := dirCpt.
	pane direction: BlLayoutDirection leftToRight.
	" direction chaged -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isLeftToRight.
	self assert: pane isRightToLeft not.

	self waitTestingSpaces.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
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
TToOrientableTest >> testIsLeftToRight [

	pane beLeftToRight.
	pane beRightToLeft.
	pane beLeftToRight.
	self assert: pane isLeftToRight.
	pane beRightToLeft.
	self assert: pane isLeftToRight not.
]

{ #category : #tests }
TToOrientableTest >> testIsRightToLeft [

	pane beRightToLeft.
	pane beLeftToRight.
	pane beRightToLeft.
	self assert: pane isRightToLeft.
	pane beLeftToRight.
	self assert: pane isRightToLeft not.
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
TToOrientableTest >> testLeftToRight [

	| dcpt |
	" to be sure pane is leftToRight"
	pane leftToRight: true.
	dcpt := dirCpt.
	pane leftToRight: true.
	" no event sent "
	self assert: dirCpt equals: dcpt.
	pane leftToRight: false.
	dcpt := dirCpt.
	pane leftToRight: true.
	" direction chaged -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isLeftToRight.
	self assert: pane isRightToLeft not.
	self waitTestingSpaces.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToOrientableTest >> testOrientation [

	| ocpt |
	pane orientation: BlLinearLayoutVerticalOrientation new.
	ocpt := oriCpt.
	" sure pane is vertical -> no event sent "
	pane orientation: BlLinearLayoutVerticalOrientation new.
	" no event sent "
	self assert: oriCpt equals: ocpt.
	pane orientation: BlLinearLayoutHorizontalOrientation new.
	ocpt := oriCpt.
	pane orientation: BlLinearLayoutVerticalOrientation new.
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isVertical.
	self assert: pane isHorizontal not.
	self waitTestingSpaces.
	self assert: child1 bounds bottom equals: child2 bounds top.
	self assert: child1 bounds left equals: child2 bounds left.

	" now for the inverted orientation "
	pane orientation: BlLinearLayoutHorizontalOrientation new.
	ocpt := oriCpt.
	" sure pane is vertical -> no event sent "
	pane orientation: BlLinearLayoutHorizontalOrientation new.
	" no event sent "
	self assert: oriCpt equals: ocpt.
	pane orientation: BlLinearLayoutVerticalOrientation new.
	ocpt := oriCpt.
	pane orientation: BlLinearLayoutHorizontalOrientation new.
	" orientation chaged -> and event is sent "
	self assert: oriCpt equals: ocpt + 1.
	self assert: pane isHorizontal.
	self assert: pane isVertical not.

	self waitTestingSpaces.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToOrientableTest >> testRightToLeft [

	| dcpt |
	" to be sure pane is leftToRight"
	pane rightToLeft: true.
	dcpt := dirCpt.
	pane rightToLeft: true.
	" no event sent "
	self assert: dirCpt equals: dcpt.
	pane rightToLeft: false.
	dcpt := dirCpt.
	pane rightToLeft: true.
	" direction chaged -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isRightToLeft.
	self assert: pane isLeftToRight not.
	self waitTestingSpaces.
	self assert: child2 bounds right equals: child1 bounds left.
	self assert: child2 bounds top equals: child1 bounds top
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
