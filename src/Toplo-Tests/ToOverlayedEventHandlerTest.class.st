"
A ToOverlayedEventHandlerTest is a test class for testing the behavior of ToOverlayedEventHandler
"
Class {
	#name : 'ToOverlayedEventHandlerTest',
	#superclass : 'ToParameterizedHostTest',
	#category : 'Toplo-Tests-Core-Window',
	#package : 'Toplo-Tests',
	#tag : 'Core-Window'
}

{ #category : 'tests' }
ToOverlayedEventHandlerTest >> testElementExtentChangedEvent [

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
	self assert: win bounds inSpace extent equals: 10 asPoint.
	e size: 100 asPoint.
	self waitTestingSpaces.
	self assert: win bounds inSpace extent equals: 100 asPoint.

	
]
