"
A TToOrientableTest is a test class for testing the behavior of TToOrientable
"
Class {
	#name : #TToDirectionalTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'pane',
		'child1',
		'child2',
		'dirCpt'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #running }
TToDirectionalTest >> setUp [

	super setUp.
	pane := ToPane new.
	dirCpt := 0.
	pane addEventHandler: (BlEventHandler
		on: ToLayoutDirectionChangedEvent
		do: [ dirCpt := dirCpt + 1 ]).
	space deferAndSettle: [
		space root addChild: pane.
		child1 := ToElement new.
		child2 := ToElement new.
		pane addChildren: {
			child1.
			child2 } ]
]

{ #category : #tests }
TToDirectionalTest >> testBeLeftToRight [

	| dcpt |
	" to be sure pane is leftToRight"
	space deferAndSettle: [ pane beLeftToRight ].
	dcpt := dirCpt.
	space deferAndSettle: [ pane beLeftToRight ].
	" no event sent "
	self assert: dirCpt equals: dcpt.

	space deferAndSettle: [ pane beRightToLeft ].
	dcpt := dirCpt.
	space deferAndSettle: [ pane beLeftToRight ].
	" direction chaged -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isLeftToRight.
	self assert: pane isRightToLeft not.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToDirectionalTest >> testBeRightToLeft [

	| dcpt |
	" to be sure pane is leftToRight"
	space deferAndSettle: [ pane beRightToLeft ].
	dcpt := dirCpt.
	space deferAndSettle: [ pane beRightToLeft ].
	" no event sent "
	self assert: dirCpt equals: dcpt.

	space deferAndSettle: [ pane beLeftToRight ].
	dcpt := dirCpt.
	space deferAndSettle: [ pane beRightToLeft ].
	" direction chaged -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isRightToLeft.
	self assert: pane isLeftToRight not.
	self assert: child2 bounds right equals: child1 bounds left.
	self assert: child2 bounds top equals: child1 bounds top
]

{ #category : #tests }
TToDirectionalTest >> testDirection [

	| dcpt |
	space deferAndSettle: [ pane direction: BlLayoutDirection rightToLeft ].
	dcpt := dirCpt.
	" sure pane is rightToLeft -> no event sent "
	space deferAndSettle: [ pane direction: BlLayoutDirection rightToLeft ].
	" no event sent "
	self assert: dirCpt equals: dcpt.

	space deferAndSettle: [ pane direction: BlLayoutDirection leftToRight ].
	dcpt := dirCpt.
	space deferAndSettle: [ pane direction: BlLayoutDirection rightToLeft ].
	" direction changed -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isRightToLeft.
	self assert: pane isLeftToRight not.
	self assert: child2 bounds right equals: child1 bounds left.
	self assert: child2 bounds top equals: child1 bounds top.

	" now for the inverted direction "
	space deferAndSettle: [ pane direction: BlLayoutDirection leftToRight ].
	dcpt := dirCpt.
	" sure pane is leftToRight -> no event sent "
	space deferAndSettle: [ pane direction: BlLayoutDirection leftToRight ].
	" no event sent "
	self assert: dirCpt equals: dcpt.

	space deferAndSettle: [ pane direction: BlLayoutDirection rightToLeft ].
	dcpt := dirCpt.
	space deferAndSettle: [ pane direction: BlLayoutDirection leftToRight ].
	" direction chaged -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isLeftToRight.
	self assert: pane isRightToLeft not.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToDirectionalTest >> testIsLeftToRight [

	space deferAndSettle: [
		pane beLeftToRight.
		pane beRightToLeft.
		pane beLeftToRight ].
	self assert: pane isLeftToRight.

	space deferAndSettle: [ pane beRightToLeft ].
	self assert: pane isLeftToRight not
]

{ #category : #tests }
TToDirectionalTest >> testIsRightToLeft [

	space deferAndSettle: [
		pane beRightToLeft.
		pane beLeftToRight.
		pane beRightToLeft ].
	self assert: pane isRightToLeft.

	space deferAndSettle: [ pane beLeftToRight ].
	self assert: pane isRightToLeft not
]

{ #category : #tests }
TToDirectionalTest >> testLeftToRight [

	| dcpt |
	" to be sure pane is leftToRight"
	space deferAndSettle: [ pane leftToRight: true ].
	dcpt := dirCpt.
	space deferAndSettle: [ pane leftToRight: true ].
	" no event sent "
	self assert: dirCpt equals: dcpt.

	space deferAndSettle: [ pane leftToRight: false ].
	dcpt := dirCpt.
	space deferAndSettle: [ pane leftToRight: true ].
	" direction chaged -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isLeftToRight.
	self assert: pane isRightToLeft not.
	self assert: child1 bounds right equals: child2 bounds left.
	self assert: child1 bounds top equals: child2 bounds top
]

{ #category : #tests }
TToDirectionalTest >> testRightToLeft [

	| dcpt |
	" to be sure pane is leftToRight"
	space deferAndSettle: [ pane rightToLeft: true ].
	dcpt := dirCpt.
	space deferAndSettle: [ pane rightToLeft: true ].
	" no event sent "
	self assert: dirCpt equals: dcpt.

	space deferAndSettle: [ pane rightToLeft: false ].
	dcpt := dirCpt.
	space deferAndSettle: [ pane rightToLeft: true ].
	" direction chaged -> and event is sent "
	self assert: dirCpt equals: dcpt + 1.
	self assert: pane isRightToLeft.
	self assert: pane isLeftToRight not.
	self assert: child2 bounds right equals: child1 bounds left.
	self assert: child2 bounds top equals: child1 bounds top
]

{ #category : #tests }
TToDirectionalTest >> testVerticalRightToLeft [

	" to be sure pane is leftToRight"
	space deferAndSettle: [
		pane rightToLeft: true.
		pane vertical: true ].
	self assert: child2 bounds left equals: child1 bounds left.
	self assert: child2 bounds bottom equals: child1 bounds top
]
