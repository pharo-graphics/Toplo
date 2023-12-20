"
A ToOverlayWindowManagerTest is a test class for testing the behavior of ToOverlayWindowManager
"
Class {
	#name : 'ToOverlayWindowManagerTest',
	#superclass : 'ToParameterizedHostTest',
	#category : 'Toplo-Tests-Core-Window',
	#package : 'Toplo-Tests',
	#tag : 'Core-Window'
}

{ #category : 'tests' }
ToOverlayWindowManagerTest >> testDefaultHeightHook [

	| e windowManager win |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowManager := ToOverlayWindowManager new.
	windowManager element: e.
	self assert: (windowManager defaultHeightHook isKindOf: BlockClosure).
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds inSpace height equals: e bounds inSpace height
]

{ #category : 'tests' }
ToOverlayWindowManagerTest >> testDefaultWidthHook [

	| e windowManager win |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowManager := ToOverlayWindowManager new.
	windowManager element: e.
	self assert: (windowManager defaultWidthHook isKindOf: BlockClosure).
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds inSpace width equals: e bounds inSpace width
]

{ #category : 'tests' }
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
