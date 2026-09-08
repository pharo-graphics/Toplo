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
	self
		assert: win isOpened
		description: 'Window must be opened after popup'.
	win close.
	space settle.
	self
		assert: win isClosed
		description: 'Window must be closed after close'.

	win := windowManager createNewWindowOnEvent: nil.
	win popup.
	space settle.
	self assert: win anchorElement equals: e.
	self
		assert: win isOpened
		description: 'Window must be opened on second popup'.
	win close.
	space settle.
	self
		assert: win isClosed
		description: 'Window must be closed on second close'
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
	self
		assert: windowManager currentWindow notNil
		description: 'Popup window must be created on mouse down'.
	self
		assert: windowManager currentWindow isOpened
		description: 'Popup window must be open on mouse down'.

	e popupEditorEvent: nil.

	space waitUntilTrue: [ e editorWindowManager notNil ].
	self
		assert: e editorWindowManager notNil
		description: 'Editor window manager must be created'.
	self
		assert: e editorWindowManager editor notNil
		description: 'Editor element must be present in editor window'.
	self
		assert: e editorWindowManager editor text asString
		equals: e text asString.
	e editorWindowManager currentWindow close.
	space waitUntilTrue: [ e editorWindowManager currentWindow isNil ].
	self
		assert: e editorWindowManager editor isNil
		description: 'Editor must be cleared after editor window closes'
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
	"Use a generous delay to give a safe margin against CI thread scheduling lag"
	windowManager autoCloseDelay: 500 milliSeconds.
	e addEventHandler: windowManager.
	e tooltipBuilder: [ :win :request |
		win root addChild: (ToLabel text: 'Tooltip content') ].
	tooltipWindowManager := e ensuredTooltipManager.
	self
		assert: tooltipWindowManager notNil
		description: 'Tooltip manager must be installed'.

	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	self
		assert: windowManager currentWindow isOpened
		description: 'Popup must open on mouse down'.
	self
		assert: tooltipWindowManager currentWindow isNil
		description: 'Tooltip must remain closed while popup is open'.

	e eventSimulator mouseUp.
	space waitForDuration: 600 milliSeconds.
	self
		assert: windowManager currentWindow isOpened
		description: 'Popup must stay open after a quick click'.

	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	self
		assert: windowManager currentWindow isOpened
		description: 'Popup must still be open on second mouse down'.

	e eventSimulator mouseUp.
	space waitUntilTrue: [ windowManager currentWindow isNil ].
	self
		assert: windowManager currentWindow isNil
		description: 'Popup must close on second click release'
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
	self
		assert: windowManager currentWindow notNil
		description: 'Popup must exist after immediate click'.
	self
		assert: windowManager currentWindow isOpened
		description: 'Popup must stay open on immediate click'.

	"Use a generous delay to give a safe margin against CI thread scheduling lag"
	windowManager autoCloseDelay: 500 milliSeconds.

	" mouse down then waiting for a delay < autoclose delay then a mouse up -> the popup should stay opened"
	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	self
		assert: windowManager currentWindow notNil
		description: 'Popup must be created on second mouse down'.
	self
		assert: windowManager currentWindow isOpened
		description: 'Popup must be open on second mouse down'.

	space waitForDuration: 50 milliSeconds.
	e eventSimulator mouseUp.
	self
		assert: windowManager currentWindow notNil
		description: 'Popup must remain open when released before autoCloseDelay'.
	self
		assert: windowManager currentWindow isOpened
		description: 'Popup must still be opened after short-hold release'.

	" mouse down then waiting for a delay > autoclose delay then a mouse up -> the popup should be closed"
	e eventSimulator mouseDown.
	space waitForDuration: 600 milliSeconds.
	self
		assert: windowManager currentWindow notNil
		description: 'Popup must still exist during long hold'.
	self
		assert: windowManager currentWindow isOpened
		description: 'Popup must remain open during long hold'.

	e eventSimulator mouseUp.
	space waitUntilTrue: [ windowManager currentWindow isNil ].
	self
		assert: windowManager currentWindow isNil
		description: 'Popup must close on release after autoCloseDelay'
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
			
	"Use a generous delay to give a safe margin against CI thread scheduling lag"
	windowManager autoCloseDelay: 500 milliSeconds.
	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	e eventSimulator mouseUp.
	self
		assert: windowManager currentWindow notNil
		description: 'Popup must open on click'.

	space root eventSimulator mouseDown.
	space waitForDuration: 600 milliSeconds.
	space root eventSimulator mouseUp.
	space waitUntilTrue: [ windowManager currentWindow isNil ].
	self
		assert: closed
		description: 'ToClosedEvent must be received on outside click'.
	self
		assert: windowManager currentWindow isNil
		description: 'Popup must be nil after outside click'
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
	"Use a generous delay to give a safe margin against CI thread scheduling lag"
	windowManager autoCloseDelay: 500 milliSeconds.
	" mouse down on widget then up on popup"
	e eventSimulator mouseDown.
	space waitUntilTrue: [ windowManager currentWindow notNil ].
	e eventSimulator mouseUp.
	self
		assert: windowManager currentWindow notNil
		description: 'Popup must exist after opening click'.
	self
		assert: windowManager currentWindow isOpened
		description: 'Popup must be opened after opening click'.

	windowManager currentWindow eventSimulator mouseDown.
	windowManager currentWindow eventSimulator mouseUp.
	space waitForDuration: 600 milliSeconds.
	self
		assert: windowManager currentWindow notNil
		description: 'Popup must remain open after click inside the popup itself'.
	self
		assert: windowManager currentWindow isOpened
		description: 'Popup must still be opened after click inside the popup'.

	closed := false.
	e addEventHandlerOn: ToClosedEvent do: [ :event | closed := true ].
	other eventSimulator mouseDown.
	space waitForDuration: 600 milliSeconds.
	other eventSimulator mouseUp.
	space waitUntilTrue: [ windowManager currentWindow isNil ].
	self
		assert: closed
		description: 'ToClosedEvent must be received on clicking outside sibling'.
	self
		assert: windowManager currentWindow isNil
		description: 'Popup must close on clicking outside sibling'
]
