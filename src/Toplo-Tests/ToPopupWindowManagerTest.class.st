"
A ToPopupWindowManagerTest is a test class for testing the behavior of ToPopupWindowManager
"
Class {
	#name : #ToPopupWindowManagerTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToPopupWindowManagerTest >> testAutoCloseOnMouseUpDelay [

	| windowManager |

	windowManager := ToPopupWindowManager new .
	self assert: windowManager autoCloseOnMouseUpDelay equals: windowManager defaultAutoCloseOnMouseUpDelay.
	windowManager autoCloseOnMouseUpDelay: 1 second.
	self assert: windowManager autoCloseOnMouseUpDelay equals: 1 second.
	windowManager autoCloseOnMouseUpDelay: nil.
	self assert: windowManager autoCloseOnMouseUpDelay isNil

]

{ #category : #tests }
ToPopupWindowManagerTest >> testAutoClosePickOutsideEventClass [

	| e windowManager closed event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	self assert: windowManager autoClosePickOutsideEventClass identicalTo: windowManager defaultAutoClosePickOutsideEventClass.

	windowManager onInstalledIn: e.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :anEvent | closed := true ]).
	event := BlMouseUpEvent primary position: 0 @ 0.
	e dispatchEvent: event asMouseOutsideEvent.

	" window is closed on mouse-up-outside"
	self assert: windowManager currentWindow isNil.
	self assert: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testAutoClosePickOutsideEventClass2 [

	| e windowManager closed event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager autoClosePickOutsideEventClass: BlMouseDownOutsideEvent.
	self deny: windowManager autoClosePickOutsideEventClass identicalTo: windowManager defaultAutoClosePickOutsideEventClass.

	windowManager onInstalledIn: e.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :anEvent | closed := true ]).
	event := BlMouseDownEvent primary position: 0 @ 0.
	e dispatchEvent: event asMouseOutsideEvent.

	" window is closed on mouse-up-outside"
	self assert: windowManager currentWindow isNil.
	self assert: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testAutoClosePickOutsideEventClass3 [

	| e windowManager closed event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager autoClosePickOutsideEventClass: BlMouseDownOutsideEvent.
	self deny: windowManager autoClosePickOutsideEventClass identicalTo: windowManager defaultAutoClosePickOutsideEventClass.

	windowManager onInstalledIn: e.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :anEvent | closed := true ]).
	event := BlMouseUpEvent primary position: 0 @ 0.
	e dispatchEvent: event asMouseOutsideEvent.

	" window is not closed on mouse-up-outside"
	self deny: windowManager currentWindow isNil.
	self deny: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testAutoClosePickOutsideEventClass4 [

	| e windowManager closed event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager autoClosePickOutsideEventClass: BlMouseUpOutsideEvent.
	self assert: windowManager autoClosePickOutsideEventClass identicalTo: windowManager defaultAutoClosePickOutsideEventClass.

	windowManager onInstalledIn: e.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :anEvent | closed := true ]).
	event := BlMouseDownEvent primary position: 0 @ 0.
	e dispatchEvent: event asMouseOutsideEvent.

	" window is not closed on mouse-down-outside"
	self deny: windowManager currentWindow isNil.
	self deny: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testDefaultAutoClosePickOutsideEventClass [

	| windowManager |
	windowManager := ToPopupWindowManager new.
	self assert: windowManager autoClosePickOutsideEventClass identicalTo: windowManager defaultAutoClosePickOutsideEventClass.
	windowManager autoClosePickOutsideEventClass: BlMouseDownOutsideEvent.
	self deny: windowManager autoClosePickOutsideEventClass identicalTo: windowManager defaultAutoClosePickOutsideEventClass.

]

{ #category : #tests }
ToPopupWindowManagerTest >> testElementEventHandlerClass [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager onInstalledIn: e.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win element equals: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithPopupEventHandler ]).
	win close.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToElementWithPopupEventHandler ]).

	self deny: win hasAssociateElement.
	self should: [ win popup ] raise: Error
]

{ #category : #tests }
ToPopupWindowManagerTest >> testMouseDownInElementEvent [

	| e windowManager |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	windowManager onInstalledIn: e.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened
]

{ #category : #tests }
ToPopupWindowManagerTest >> testMouseUpInElementEvent [

	| e windowManager closed |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	windowManager onInstalledIn: e.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :event | closed := true ]).
	(windowManager autoCloseOnMouseUpDelay + 1 milliSecond) wait.
	BlSpace simulateMouseUpOn: e.
	" window is closed on mouse-up "
	self assert: windowManager currentWindow isNil.
	self assert: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testMouseUpInElementEventAfterLongDelayShouldCloseWindow [

	| e windowManager closed |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	windowManager onInstalledIn: e.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :event | closed := true ]).
	(windowManager autoCloseOnMouseUpDelay + 1 milliSecond) wait.
	BlSpace simulateMouseUpOn: e.
	" window is closed on mouse-up "
	self assert: windowManager currentWindow isNil.
	self assert: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testNoAutoCloseEvenAfterLongDelay [

	| e windowManager closed |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	windowManager onInstalledIn: e.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	" should avoid auto-close"
	windowManager autoCloseOnMouseUpDelay: nil.
	self assert: windowManager autoCloseOnMouseUpDelay isNil.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :event | closed := true ]).
	" use an huge waiting time "
	(5000 milliSecond) wait.
	BlSpace simulateMouseUpOn: e.
	" window is not closed on mouse-up "
	self deny: windowManager currentWindow isNil.
	self deny: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testUsePrimaryMouseButton [

	| e windowManager event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager usePrimaryMouseButton.
	windowManager onInstalledIn: e.
	event := BlMouseDownEvent primary.
	event position: e bounds inSpace center.
	BlSpace simulateEvent: event on: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened
]

{ #category : #tests }
ToPopupWindowManagerTest >> testUsePrimaryMouseButton2 [

	| e windowManager event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager usePrimaryMouseButton.
	windowManager onInstalledIn: e.
	event := BlMouseDownEvent secondary.
	event position: e bounds inSpace center.
	BlSpace simulateEvent: event on: e.
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToPopupWindowManagerTest >> testUseSecondaryMouseButton [

	| e windowManager event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager useSecondaryMouseButton.
	windowManager onInstalledIn: e.
	event := BlMouseDownEvent secondary.
	event position: e bounds inSpace center.
	BlSpace simulateEvent: event on: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened
]

{ #category : #tests }
ToPopupWindowManagerTest >> testUseSecondaryMouseButton2 [

	| e windowManager event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager useSecondaryMouseButton.
	windowManager onInstalledIn: e.
	event := BlMouseDownEvent primary.
	event position: e bounds inSpace center.
	BlSpace simulateEvent: event on: e.
	self assert: windowManager currentWindow isNil
]
