"
A ToOverlayWindowManagerTest is a test class for testing the behavior of ToOverlayWindowManager
"
Class {
	#name : #ToOverlayWindowManagerTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToOverlayWindowManagerTest >> testDefaultSizeHook [

	| e windowManager win |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowManager := ToOverlayWindowManager new.
	e addEventHandler: windowManager.
	self assert: (windowManager heightHook isKindOf: BlockClosure).
	self assert: (windowManager widthHook isKindOf: BlockClosure).
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace extent
		equals: e bounds inSpace extent
]

{ #category : #tests }
ToOverlayWindowManagerTest >> testElementEventHandlerClass [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToOverlayWindowManager new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win element equals: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToOverlayWindowManager ]).
	win close.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToOverlayWindowManager ])
]

{ #category : #tests }
ToOverlayWindowManagerTest >> testElementExtentChangedEvent [

	| e windowManager win |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowManager := ToOverlayWindowManager new.
	e addEventHandler: windowManager.
	self assert: (windowManager heightHook isKindOf: BlockClosure).
	self assert: (windowManager widthHook isKindOf: BlockClosure).
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 10 asPoint.
	e size: 100 asPoint.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 100 asPoint
]
