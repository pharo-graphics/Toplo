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
	space root addChild: pane.
	child1 := ToElement new.
	child2 := ToElement new.
	pane addChildren: {
			child1.
			child2 }
]

{ #category : #tests }
TToDirectionalTest >> testBeLeftToRight [

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
TToDirectionalTest >> testBeRightToLeft [

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
TToDirectionalTest >> testDirection [

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
TToDirectionalTest >> testIsLeftToRight [

	pane beLeftToRight.
	pane beRightToLeft.
	pane beLeftToRight.
	self assert: pane isLeftToRight.
	pane beRightToLeft.
	self assert: pane isLeftToRight not.
]

{ #category : #tests }
TToDirectionalTest >> testIsRightToLeft [

	pane beRightToLeft.
	pane beLeftToRight.
	pane beRightToLeft.
	self assert: pane isRightToLeft.
	pane beLeftToRight.
	self assert: pane isRightToLeft not.
]

{ #category : #tests }
TToDirectionalTest >> testLeftToRight [

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
TToDirectionalTest >> testRightToLeft [

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
TToDirectionalTest >> testVerticalRightToLeft [

	" to be sure pane is leftToRight"
	pane rightToLeft: true.
	pane vertical: true.
	self waitTestingSpaces.
	self assert: child2 bounds left equals: child1 bounds left.
	self assert: child2 bounds bottom equals: child1 bounds top
]
