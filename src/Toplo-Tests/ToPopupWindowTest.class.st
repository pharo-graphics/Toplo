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
ToPopupWindowTest >> testElementWithLabelEditorAndPopupWindowManager [

	| e |
	e := ToElement new
		     background: Color red;
		     size: 100 @ 40;
		     position: 50 @ 50.
	space root addChild: e.
	self waitTestingSpaces.

	e addEventHandler:
		(ToPopupWindowManager new builder: [ :anchWin :element |  ]).
	e addEventHandler: ToLabelEditorWindowManager new.
	e dispatchEvent: ToPopupWindowOpenedEvent new.
	e dispatchEvent: ToLabelEditorOpenedEvent new
]

{ #category : #tests }
ToPopupWindowTest >> testElementWithTooltipAndPopupWindowManager [

	| e windowManager tooltipWindowManager |
	e := ToElement new
		     background: Color red;
		     size: 100 @ 40;
		     position: 50 @ 50.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToPopupWindowManager new builder: [ :anchWin :element | ].
	e addEventHandler: windowManager.
	e tooltipContent: (ToLabel text: 'Tooltip content').
	tooltipWindowManager := e tooltipWindowManager.
	self assert: tooltipWindowManager notNil.
	
	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	self assert: windowManager currentWindow isOpened.
	self assert: tooltipWindowManager currentWindow isNil.
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

	windowManager := ToPopupWindowManager new builder: [ :anchWin :element |
		                 anchWin addChild: (ToElement new size: 20 @ 20) ].
	e addEventHandler: windowManager.
	windowManager autoCloseDelay: 0 milliSeconds.

	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self assert: windowManager currentWindow isOpened.
	BlSpace simulateMouseUpOn: e.
	self assert: windowManager currentWindow isNil.

	closed := false.
	e addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closed := true ]).
	windowManager autoCloseDelay: 200 milliSeconds.
	BlSpace simulateMouseDownOn: e.		
	BlSpace simulateMouseUpOn: e.
	self assert: windowManager currentWindow notNil.
	
	BlSpace simulateMouseDownOn: space root.
	300 milliSeconds asDelay wait.
	BlSpace simulateMouseUpOn: space root.
	self waitTestingSpaces.
	self assert: closed.
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseUpOutsideAssociateElement [

	| e windowManager closed other |
	e := ToElement new
		     background: Color red;
		     size: 100 @ 40;
		     position: 50 @ 50.
	other := ToElement new
		     background: Color blue;
		     size: 10 @ 10;
		     position: 500 @ 500.
	space root addChild: e.
	space root addChild: other.

	windowManager := ToPopupWindowManager new builder: [ :anchWin :element |
		                 anchWin addChild: (ToElement new size: 20 @ 20) ].
	e addEventHandler: windowManager.
	windowManager autoCloseDelay: 0 milliSeconds.

	" mouse down on widget then up on popup"
	BlSpace simulateMouseDownOn: e.
	self assert: windowManager currentWindow isOpened.
	BlSpace simulateMouseUpOn: windowManager currentWindow.
	self assert: windowManager currentWindow isOpened.
	self waitTestingSpaces.
	closed := false.
	e addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closed := true ]).
	BlSpace simulateMouseDownOn: other.
	self waitTestingSpaces.
	BlSpace simulateMouseUpOn: other.
	self waitTestingSpaces.
	self assert: closed.
	self assert: windowManager currentWindow isNil
]
