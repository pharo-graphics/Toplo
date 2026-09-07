"
A ToOverlayWindowTest is a test class for testing the behavior of ToOverlayWindow
"
Class {
	#name : #ToOverlayWindowTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToOverlayWindowTest >> testWindowSize [

	| win e windowManager |
	e := ToElement new.
	space deferAndSettle: [
		space root addChild: e.
		e position: 10 asPoint.
		e extent: 10 asPoint ].
	windowManager :=
		ToAnchoredWindowManager overlay
			windowBuilder: [ :anchWin :requestEvent |  ];
			yourself.
	e addEventHandler: windowManager.
	space deferAndSettle: [
		win := windowManager createNewWindowOnEvent: nil.
		win popup ].
	self assert: win bounds inSpace extent equals: 10 asPoint.

	space deferAndSettle: [ e extent: 20 asPoint ].
	self assert: win bounds inSpace extent equals: 20 asPoint
]

{ #category : #tests }
ToOverlayWindowTest >> testWindowSize2 [

	| win e windowManager |
	e := ToElement new.
	space deferAndSettle: [
		space root addChild: e.
		e position: 10 asPoint.
		e extent: 10 asPoint ].
	windowManager :=
		ToAnchoredWindowManager overlay
			windowBuilder: [ :anchWin :requestEvent |
				anchWin root addChild: (ToElement new extent: 100 asPoint) ];
			yourself.
	e addEventHandler: windowManager.
	space deferAndSettle: [
		win := windowManager createNewWindowOnEvent: nil.
		win popup ].
	self assert: win bounds inSpace extent equals: 10 asPoint.

	space deferAndSettle: [ e extent: 20 asPoint ].
	self assert: win bounds inSpace extent equals: 20 asPoint
]
