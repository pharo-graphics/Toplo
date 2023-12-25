"
A ToOverlayWindowManagerTest is a test class for testing the behavior of ToOverlayWindowManager
"
Class {
	#name : #ToOverlayWindowManagerTest,
	#superclass : #ToParameterizedHostTest,
	#category : 'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToOverlayWindowManagerTest >> testDefaultSizeHook [

	| e windowManager win |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowManager := ToOverlayWindowManager new.
	windowManager element: e.
	self assert: (windowManager defaultSizeHook isKindOf: BlockClosure).
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: e bounds inSpace extent
]

{ #category : #tests }
ToOverlayWindowManagerTest >> testElementEventHandlerClass [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToOverlayWindowManager new builder: [ :anchWin :element |  ].
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	win popup.
	self assert: win element equals: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToOverlayedEventHandler ]).
	win close.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToOverlayedEventHandler ])
]
