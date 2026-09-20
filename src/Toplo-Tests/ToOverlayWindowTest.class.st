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
	space root addChild: e.
	e position: 10 @ 10.
	e extent: 10 @ 10.
	windowManager := ToAnchoredWindowManager overlay windowBuilder: [ :anchWin :requestEvent |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 10 @ 10.

	e extent: 20 @ 20.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 20 @ 20
]

{ #category : #tests }
ToOverlayWindowTest >> testWindowSize2 [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 @ 10.
	e extent: 10 @ 10.
	windowManager := ToAnchoredWindowManager overlay windowBuilder: [ :anchWin :requestEvent |
		                 anchWin root addChild: (ToElement new extent: 100 @ 100) ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 10 @ 10.
	e extent: 20 @ 20.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 20 @ 20
]
