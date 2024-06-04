"
A ToAnchorEventHandlerTest is a test class for testing the behavior of ToAnchorEventHandler
"
Class {
	#name : #ToAnchorEventHandlerTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToAnchorEventHandlerTest >> testElementPositionInSpaceChangedEvent [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :anchWin
		                 :element |  ].
	windowManager onInstalledIn: e.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: e bounds inSpace bounds origin equals: 20 asPoint.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin
]

{ #category : #tests }
ToAnchorEventHandlerTest >> testElementRemovedFromParentEvent [

	| win e windowManager closed |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :anchWin
		                 :element |  ].
	windowManager onInstalledIn: e.
	win := windowManager newWindowEvent: nil.
	win popup.
	closed := false.
	win addEventHandler: (BlEventHandler
			 on: windowManager windowClosedEventClass
			 do: [ closed := true ]).
	self waitTestingSpaces.
	self assert: win isOpened.
	space root removeChild: e.
	self assert: closed.
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToAnchorEventHandlerTest >> testElementRemovedFromSceneGraphEvent [

	self testElementRemovedFromParentEvent 
]
