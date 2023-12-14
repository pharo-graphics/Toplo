"
A ToPopupWindowManagerTest is a test class for testing the behavior of ToPopupWindowManager
"
Class {
	#name : 'ToPopupWindowManagerTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Window',
	#package : 'Toplo-Tests',
	#tag : 'Core-Window'
}

{ #category : 'running' }
ToPopupWindowManagerTest >> setUp [ 

	super setUp.
	space := self newTestingSpace.

]

{ #category : 'tests' }
ToPopupWindowManagerTest >> testAutoCloseOnMouseUpDelay [

	| windowManager |

	windowManager := ToPopupWindowManager new .
	self assert: windowManager autoCloseOnMouseUpDelay equals: windowManager defaultAutoCloseOnMouseUpDelay.
	windowManager autoCloseOnMouseUpDelay: 1 second.
	self assert: windowManager autoCloseOnMouseUpDelay equals: 1 second.
	windowManager autoCloseOnMouseUpDelay: nil.
	self assert: windowManager autoCloseOnMouseUpDelay equals: windowManager defaultAutoCloseOnMouseUpDelay.

]

{ #category : 'tests' }
ToPopupWindowManagerTest >> testElementEventHandlerClass [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	win popup.
	self assert: win element equals: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithPopupEventHandler ]).
	win close.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithPopupEventHandler ]).

	self deny: win hasAssociateElement.
	self should: [ win popup ] raise: Error
]

{ #category : 'tests' }
ToPopupWindowManagerTest >> testMouseDownInElementEvent [

	|  e  windowManager  |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	windowManager element: e.
	BlSpace simulateMouseDownOn: e.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.

]

{ #category : 'tests' }
ToPopupWindowManagerTest >> testMouseUpInElementEvent [

	|  e  windowManager closed |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	windowManager element: e.
	BlSpace simulateMouseDownOn: e.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :event | closed := true ]).
	(windowManager autoCloseOnMouseUpDelay + 1 milliSecond ) wait.
	BlSpace simulateMouseUpOn: e.
	" window is closed on mouse-up "
	self assert: windowManager currentWindow isNil.
	self assert: closed
	
]

{ #category : 'tests' }
ToPopupWindowManagerTest >> testMouseUpInElementEventAfterLongDelayShouldCloseWindow [

	|  e  windowManager closed |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	windowManager element: e.
	BlSpace simulateMouseDownOn: e.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :event | closed := true ]).
	(windowManager autoCloseOnMouseUpDelay + 1 milliSecond ) wait.
	BlSpace simulateMouseUpOn: e.
	" window is closed on mouse-up "
	self assert: windowManager currentWindow isNil.
	self assert: closed
	
]

{ #category : 'tests' }
ToPopupWindowManagerTest >> testUsePrimaryMouseButton [

	|  e  windowManager  event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager usePrimaryMouseButton.
	windowManager element: e.
	event := BlMouseDownEvent primary.
	event position: e bounds inSpace center.
	BlSpace simulateEvent: event on: e.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.

]

{ #category : 'tests' }
ToPopupWindowManagerTest >> testUsePrimaryMouseButton2 [

	|  e  windowManager  event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager usePrimaryMouseButton.
	windowManager element: e.
	event := BlMouseDownEvent secondary.
	event position: e bounds inSpace center.
	BlSpace simulateEvent: event on: e.
	self assert: windowManager currentWindow isNil.
]

{ #category : 'tests' }
ToPopupWindowManagerTest >> testUseSecondaryMouseButton [

	|  e  windowManager  event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager useSecondaryMouseButton.
	windowManager element: e.
	event := BlMouseDownEvent secondary.
	event position: e bounds inSpace center.
	BlSpace simulateEvent: event on: e.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.

]

{ #category : 'tests' }
ToPopupWindowManagerTest >> testUseSecondaryMouseButton2 [

	|  e  windowManager  event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager useSecondaryMouseButton.
	windowManager element: e.
	event := BlMouseDownEvent primary.
	event position: e bounds inSpace center.
	BlSpace simulateEvent: event on: e.
	self assert: windowManager currentWindow isNil.
]
