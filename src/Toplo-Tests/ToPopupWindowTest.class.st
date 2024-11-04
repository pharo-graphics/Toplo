"
A ToPopupWindowTest is a test class for testing the behavior of ToPopupWindow
"
Class {
	#name : #ToPopupWindowTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToPopupWindowTest >> testElement [

	| win e windowManager |
	e := ToElement new
		     background: Color red;
		     size: 100 @ 40;
		     position: 50 @ 50.
	space root addChild: e.

	" have to layout the space here to ensure that no position changed event is sent (which should close the window and make the test failing fail the test)"
	self waitTestingSpaces.
	windowManager := ToPopupWindowManager new builder: [ :anchWin :element |
		                  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.

	self waitTestingSpaces.
	self assert: win element equals: e.
	self assert: win isOpened.
	win close.
	self waitTestingSpaces.
	self assert: win isClosed.

	self should: [ win popup ] raise: Error.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win element equals: e.
	self assert: win isOpened.
	win close.
	self waitTestingSpaces.
	self assert: win isClosed
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownDelayUp [

	| e windowManager |
	e := ToElement new
		     background: Color red;
		     size: 100 @ 40;
		     position: 50 @ 50.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new builder: [ :anchWin :element | ].
	e addEventHandler: windowManager.

	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow isOpened.
	BlSpace simulateMouseUpOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow isOpened.

	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow isNil.
	BlSpace simulateMouseUpOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownDelayUp2 [

	| e windowManager |
	e := ToElement new
		     background: Color red;
		     size: 100 @ 40;
		     position: 50 @ 50.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new builder: [ :anchWin :element | ].
	e addEventHandler: windowManager.

	" mouse down then wait a delay then a mouse up -> the popup should be closed"
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	self assert: e shouldHandleMousePickOutsideEvent.
	(windowManager autoCloseDelay + 1 milliSecond) wait.
	BlSpace simulateMouseUpOn: e.
	self waitTestingSpaces.
	" window is closed on mouse-up "
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownOutside [

	| e windowManager closed |
	e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new builder: [ :anchWin :element |
		                 anchWin addChild: (ToElement new size: 20 @ 20) ].
	e addEventHandler: windowManager.

	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow isOpened.
	BlSpace simulateMouseUpOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow isOpened.
	self assert: e shouldHandleMousePickOutsideEvent.

	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :event | closed := true ]).
	BlSpace simulateMouseMoveOutside: windowManager currentWindow.
	BlSpace simulateMouseDownOn: space root.
	BlSpace simulateMouseUpOn: space root.
	self waitTestingSpaces.
	self assert: closed.
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseUpOutsideAssociateElement [

	| e windowManager closed |
	e := ToElement new
		     background: Color red;
		     size: 100 @ 40;
		     position: 50 @ 50.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new builder: [ :anchWin :element |
		                 anchWin addChild: (ToElement new size: 20 @ 20) ].
	e addEventHandler: windowManager.

	" mouse down on widget then up on popup"
	self waitTestingSpaces.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow isOpened.
	self waitTestingSpaces.
	BlSpace simulateMouseUpOn: windowManager currentWindow.
	self assert: windowManager currentWindow isOpened.

	closed := false.
	windowManager currentWindow addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :event | closed := true ]).
	BlSpace simulateMouseDownOn: space root.
	BlSpace simulateMouseUpOn: space root.
	self assert: closed.
	self assert: windowManager currentWindow isNil
]
