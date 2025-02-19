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
	windowManager := ToPopupManager new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.

	self waitTestingSpaces.
	self assert: win anchorElement equals: e.
	self assert: win isOpened.
	win close.
	self waitTestingSpaces.
	self assert: win isClosed.

	self should: [ win popup ] raise: Error.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win anchorElement equals: e.
	self assert: win isOpened.
	win close.
	self waitTestingSpaces.
	self assert: win isClosed
]

{ #category : #tests }
ToPopupWindowTest >> testElementWithLabelEditorAndPopupWindowManager [

	| e windowManager |
	e := ToLabel new
		     text: 'a text that can be edited';
		     background: Color red;
		     size: 100 @ 40;
		     position: 50 @ 50.
	e isEditable: true.
	space root addChild: e.
	
	windowManager := ToPopupManager new.
	e addEventHandler: windowManager.
	BlSpace simulateMouseDownOn: e.
	self waitTestingSpaces.
	
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	
	self waitTestingSpaces.
	e popupEditorEvent: nil.
	
	self waitTestingSpaces.
	self assert: e editorWindowManager notNil.
	self assert: e editorWindowManager editor notNil.
	self assert: e editorWindowManager editor text asString equals: e text asString.
	e editorWindowManager currentWindow close.
	self assert: e editorWindowManager currentWindow isNil.
	self assert: e editorWindowManager editor isNil
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

	windowManager := ToPopupManager new windowBuilder: [
		                 :anchWin
		                 :element |  ].
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

	windowManager := ToPopupManager new windowBuilder: [
		                 :anchWin
		                 :element |  ].
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

	windowManager := ToPopupManager new windowBuilder: [
		                 :anchWin
		                 :element |  ].
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

	windowManager := ToPopupManager new windowBuilder: [
		                 :anchWin
		                 :element |
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
	400 milliSeconds asDelay wait.
	self waitTestingSpaces.
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
		         size: 50 @ 50;
		         position: 500 @ 500.
	space root addChild: e.
	space root addChild: other.

	windowManager := ToPopupManager new windowBuilder: [
		                 :anchWin
		                 :element |
		                 anchWin addChild: (ToElement new size: 100 @ 100) ].
	e addEventHandler: windowManager.
	windowManager autoCloseDelay: 100 milliSeconds.

	self waitTestingSpaces.
	" mouse down on widget then up on popup"
	BlSpace simulateMouseDownOn: e.
	BlSpace simulateMouseUpOn: e.

	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	BlSpace simulateMouseDownOn: windowManager currentWindow.
	BlSpace simulateMouseUpOn: windowManager currentWindow.
	100 milliSeconds asDelay wait.
	self waitTestingSpaces.
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
