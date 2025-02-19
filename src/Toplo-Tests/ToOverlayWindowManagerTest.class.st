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
	windowManager := ToAnchoredElementManager overlay.
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self
		assert: win measuredBounds inSpace extent
		equals: e bounds inSpace extent
]

{ #category : #tests }
ToOverlayWindowManagerTest >> testElementEventHandlerClass [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredElementManager overlay.
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win anchorElement equals: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToAnchoredElementManager ]).
	win close.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToAnchoredElementManager ])
]

{ #category : #tests }
ToOverlayWindowManagerTest >> testElementExtentChangedEvent [

	| e windowManager win |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowManager := ToAnchoredElementManager overlay.
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 10 asPoint.
	e size: 100 asPoint.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 100 asPoint
]
