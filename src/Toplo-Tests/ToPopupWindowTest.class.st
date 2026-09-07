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
		     extent: 100 @ 40;
		     position: 50 @ 50;
		     yourself.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToPopupWindowManager new.
	windowManager windowBuilder: [ :anchWin :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win popup.
	space settle.
	self assert: win anchorElement equals: e.
	self assert: win isOpened.
	win close.
	space settle.
	self assert: win isClosed.

	win := windowManager createNewWindowOnEvent: nil.
	win popup.
	space settle.
	self assert: win anchorElement equals: e.
	self assert: win isOpened.
	win close.
	space settle.
	self assert: win isClosed
]

{ #category : #tests }
ToPopupWindowTest >> testElementWithLabelEditorAndPopupWindowManager [

	| e windowManager |
	e := ToLabel new
		     text: 'a text that can be edited';
		     background: Color red;
		     extent: 100 @ 40;
		     position: 50 @ 50;
		     yourself.
	e isEditable: true.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToPopupWindowManager new.
	e addEventHandler: windowManager.
	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].

	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.

	e popupEditorEvent: nil.

	space waitUntilTrue: [ e editorWindowManager notNil ].
	self assert: e editorWindowManager notNil.
	self assert: e editorWindowManager editor notNil.
	self
		assert: e editorWindowManager editor text asString
		equals: e text asString.
	e editorWindowManager currentWindow close.
	space waitUntilTrue: [ e editorWindowManager currentWindow isNil ].
	self assert: e editorWindowManager editor isNil
]

{ #category : #tests }
ToPopupWindowTest >> testElementWithTooltipAndPopupWindowManager [

	| e windowManager tooltipWindowManager |
	e := ToElement new
		     background: Color red;
		     extent: 100 @ 40;
		     position: 50 @ 50;
		     yourself.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToPopupWindowManager new.
	windowManager windowBuilder: [ :anchWin :element |  ].
	e addEventHandler: windowManager.
	e tooltipBuilder: [ :win :request |
		win root addChild: (ToLabel text: 'Tooltip content') ].
	tooltipWindowManager := e ensuredTooltipManager.
	self assert: tooltipWindowManager notNil.

	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	self assert: windowManager currentWindow isOpened.
	self assert: tooltipWindowManager currentWindow isNil.
	e eventSimulator mouseUp.
	space waitForDuration: 400 milliSeconds.
	self assert: windowManager currentWindow isOpened.
	space waitForDuration: 150 milliSeconds.

	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	self assert: windowManager currentWindow isOpened.
	e eventSimulator mouseUp.

	space waitUntilTrue: [ windowManager currentWindow isNil ].
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownDelayUp [

	| e windowManager |
	e := ToElement new
		     background: Color red;
		     extent: 100 @ 40;
		     position: 50 @ 50;
		     yourself.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToPopupWindowManager new.
	windowManager windowBuilder: [ :anchWin :element |  ].
	e addEventHandler: windowManager.

	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	e eventSimulator mouseUp.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.

	windowManager autoCloseDelay: 200 milliSeconds.

	" mouse down then waiting for a delay < autoclose delay then a mouse up -> the popup should stay opened"
	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	space waitForDuration: 50 milliSeconds.
	e eventSimulator mouseUp.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	
	" mouse down then waiting for a delay > autoclose delay then a mouse up -> the popup should be closed"
	e eventSimulator mouseDown.
	space waitForDuration: 300 milliSeconds.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.
	e eventSimulator mouseUp.
	space waitUntilTrue: [ windowManager currentWindow isNil ].
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownOutside [

	| e windowManager closed |
	e := ToElement new
		     background: Color red;
		     extent: 100 @ 40;
		     position: 50 @ 50;
		     yourself.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToPopupWindowManager new.
	windowManager windowBuilder: [ :anchWin :element |
		anchWin addChild: (ToElement new extent: 20 @ 20) ].
	e addEventHandler: windowManager.

	closed := false.
	e addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closed := true ]).
			
	windowManager autoCloseDelay: 200 milliSeconds.
	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	e eventSimulator mouseUp.
	self assert: windowManager currentWindow notNil.

	space root eventSimulator mouseDown.
	space waitForDuration: 400 milliSeconds.
	space root eventSimulator mouseUp.
	space waitUntilTrue: [ windowManager currentWindow isNil ].
	self assert: closed.
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseUpOutsideOnASibling [

	| e windowManager closed other |
	e := ToElement new
		     background: Color red;
		     extent: 100 @ 40;
		     position: 50 @ 50;
		     yourself.
	other := ToElement new
		         background: Color blue;
		         extent: 50 @ 50;
		         position: 500 @ 500;
		         yourself.
	space deferAndSettle: [
		space root addChild: e.
		space root addChild: other ].

	windowManager := ToPopupWindowManager new.
	windowManager windowBuilder: [ :anchWin :element |
		anchWin addChild: (ToElement new extent: 100 @ 100) ].
	e addEventHandler: windowManager.
	windowManager autoCloseDelay: 100 milliSeconds.
	" mouse down on widget then up on popup"
	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	e eventSimulator mouseUp.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.

	windowManager currentWindow eventSimulator mouseDown.
	windowManager currentWindow eventSimulator mouseUp.
	space waitForDuration: 400 milliSeconds.
	self assert: windowManager currentWindow notNil.
	self assert: windowManager currentWindow isOpened.

	closed := false.
	e addEventHandlerOn: ToClosedEvent do: [ :event | closed := true ].
	other eventSimulator mouseDown.
	space waitForDuration: 400 milliSeconds.
	other eventSimulator mouseUp.
	space waitUntilTrue: [ windowManager currentWindow isNil ].
	self assert: closed.
	self assert: windowManager currentWindow isNil
]
