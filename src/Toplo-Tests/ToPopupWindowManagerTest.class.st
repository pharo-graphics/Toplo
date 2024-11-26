"
A ToPopupWindowManagerTest is a test class for testing the behavior of ToPopupWindowManager
"
Class {
	#name : #ToPopupWindowManagerTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToPopupWindowManagerTest >> testAutoCloseDelay [

	| windowManager |

	windowManager := ToPopupWindowManager new .
	self assert: windowManager autoCloseDelay equals: windowManager defaultAutoCloseDelay.
	windowManager autoCloseDelay: 1 second.
	self assert: windowManager autoCloseDelay equals: 1 second.
	windowManager autoCloseDelay: nil.
	self assert: windowManager autoCloseDelay isNil

]

{ #category : #tests }
ToPopupWindowManagerTest >> testAutoClosePickOutsideEventClass [

	| e windowManager closed |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	e addEventHandler: windowManager.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :anEvent | closed := true ]).
	" 
	two mouseUp are necessary because by default, windowManager popupOnMouseDown is true.
	have a look at ToPopupPickOutsideEventFilter>>mouseUpEvent:
	"
	BlSpace simulateMouseUpOn: space root.
	BlSpace simulateMouseDownOn: space root.
	BlSpace simulateMouseUpOn: space root.
	" window is closed on mouse-up-outside"
	self assert: windowManager currentWindow isNil.
	self assert: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testElementEventHandlerClass [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win element equals: e.
	win close.
	self deny: win hasAssociateElement.
	self should: [ win popup ] raise: Error
]

{ #category : #tests }
ToPopupWindowManagerTest >> testElementPositionInSpaceChangedEvent [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win isOpened.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: win isOpened
]

{ #category : #tests }
ToPopupWindowManagerTest >> testMouseDownEvent [

	| e windowManager position event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	e addEventHandler: windowManager.
	position := e bounds inSpace center.
	event := BlMouseDownEvent primary position: position.
	e dispatchEvent: event.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self waitTestingSpaces.
	self assert: windowManager currentWindow isOpened
]

{ #category : #tests }
ToPopupWindowManagerTest >> testMouseDownInElementEvent [

	| e windowManager |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	e addEventHandler: windowManager.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened
]

{ #category : #tests }
ToPopupWindowManagerTest >> testMouseUpEvent [

	| e windowManager closed position event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	e addEventHandler: windowManager.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ closed := true ]).
	(windowManager autoCloseDelay + 1 milliSecond) wait.
	position := e bounds inSpace center.
	event := BlMouseUpEvent primary position: position.
	event timestamp: e space time now.
	e dispatchEvent: event.
	self waitTestingSpaces.

	" window is closed on mouse-up "
	self assert: windowManager currentWindow isNil.
	self assert: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testMouseUpInElementEvent [

	| e windowManager closed |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	e addEventHandler: windowManager.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closed := true ]).
	(windowManager autoCloseDelay + 1 milliSecond) wait.
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

	e addEventHandler: windowManager.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closed := true ]).
	(windowManager autoCloseDelay + 1 milliSecond) wait.
	BlSpace simulateMouseUpOn: e.
	" window is closed on mouse-up "
	self assert: windowManager currentWindow isNil.
	self assert: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testMouseUpOutsideEvent [

	| e windowManager closed event |
	e := ToElement new.
	e size: 100 asPoint.
	e position: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.

	e addEventHandler: windowManager.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ closed := true ]).
	(windowManager autoCloseDelay + 1 milliSecond) wait.
	event := BlMouseUpEvent primary position: 0 @ 0; timestamp: space time now.
	e dispatchEvent: event.
	self waitTestingSpaces.

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

	e addEventHandler: windowManager.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	closed := false.
	" should avoid auto-close"
	windowManager autoCloseDelay: nil.
	self assert: windowManager autoCloseDelay isNil.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closed := true ]).
	" use an huge waiting time "
	(5000 milliSecond) wait.
	BlSpace simulateMouseUpOn: e.
	" window is not closed on mouse-up "
	self deny: windowManager currentWindow isNil.
	self deny: closed
]

{ #category : #tests }
ToPopupWindowManagerTest >> testOnInstalledIn [

	| e windowManager  |
	e := ToElement new.
	windowManager := ToPopupWindowManager new.
	e addEventHandler: windowManager
]

{ #category : #tests }
ToPopupWindowManagerTest >> testOnUninstalledIn [

	| e windowManager |
	e := ToElement new.
	windowManager := ToPopupWindowManager new.
	e addEventHandler: windowManager.

]

{ #category : #tests }
ToPopupWindowManagerTest >> testUseNoMouseButton [

	| e windowManager event |
	e := ToElement new.
	e size: 100 asPoint.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new.
	windowManager useNoMouseButton.
	e addEventHandler: windowManager.
	event := BlMouseDownEvent primary.
	event position: e bounds inSpace center.
	BlSpace simulateEvent: event on: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow isNil.
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
	e addEventHandler: windowManager.
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
	e addEventHandler: windowManager.
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
	e addEventHandler: windowManager.
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
	e addEventHandler: windowManager.
	event := BlMouseDownEvent primary.
	event position: e bounds inSpace center.
	BlSpace simulateEvent: event on: e.
	self assert: windowManager currentWindow isNil
]
