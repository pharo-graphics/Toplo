"
A ToPopupWindowTest is a test class for testing the behavior of ToPopupWindow
"
Class {
	#name : 'ToPopupWindowTest',
	#superclass : 'BlParameterizedHostTest',
	#category : 'Toplo-Tests-Core-Window',
	#package : 'Toplo-Tests',
	#tag : 'Core-Window'
}

{ #category : 'tests' }
ToPopupWindowTest >> testAssociateElement [

	| win e space windowHandler |
	space := BlSpace new.
	e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	
	windowHandler := ToPopupWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.	
	
	win popup.
	self waitTestingSpaces.
	self assert: win element equals: e.
	self assert: win isOpened.
	win close.
	self waitTestingSpaces.
	self assert: win isClosed.
	
	self should: [ win popup ] raise: Error.
	win := windowHandler newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win element equals: e.
	self assert: win isOpened.
	win close.
	self waitTestingSpaces.
	self assert: win isClosed
]

{ #category : 'tests' }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownDelayUp [

	| e space windowHandler |
	space := BlSpace new.
	e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	
	windowHandler := ToPopupWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.
	
	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self assert: windowHandler currentWindow isOpened.
	BlSpace simulateMouseUpOn: e.
	self assert: windowHandler currentWindow isOpened.
	
	BlSpace simulateMouseDownOn: e.
	self assert: windowHandler currentWindow isNil.
	BlSpace simulateMouseUpOn: e.
	self assert: windowHandler currentWindow isNil.

]

{ #category : 'tests' }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownDelayUp2 [

	| e space windowHandler |
	space := BlSpace new.
	e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.

	windowHandler := ToPopupWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.
		
	" mouse down then wait a delay then a mouse up -> the popup should be closed"
	BlSpace simulateMouseDownOn: e.
	self assert: windowHandler currentWindow notNil.
	self assert: windowHandler currentWindow isOpened.
	(windowHandler autoCloseOnMouseUpDelay + 1 milliSecond ) wait.
	BlSpace simulateMouseUpOn: e.
	" window is closed on mouse-up "
	self assert: windowHandler currentWindow isNil
]

{ #category : 'tests' }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownOutside [

	| e space windowHandler closed |
	space := BlSpace new.
	e := e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.

	windowHandler := ToPopupWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.

	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self assert: windowHandler currentWindow isOpened.
	BlSpace simulateMouseUpOn: e.
	self assert: windowHandler currentWindow isOpened.

	closed := false.
	windowHandler currentWindow when: ToWindowClosedEvent do: [ :event | closed := true ].
	BlSpace simulateMouseDownOn: space root.
	self assert: closed.
	self assert: windowHandler currentWindow isNil
]

{ #category : 'tests' }
ToPopupWindowTest >> testPopupOpenCloseWithMouseUpOutsideAssociateElement [

	| e space windowHandler |
	space := BlSpace new.
	e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	
	windowHandler := ToPopupWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.
	
	" mouse down on widget then up on popup"
	self waitTestingSpaces.
	BlSpace simulateMouseDownOn: e.
	self assert: windowHandler currentWindow isOpened.
	self waitTestingSpaces.
	BlSpace simulateMouseUpOn: windowHandler currentWindow.
	self assert: windowHandler currentWindow isOpened
	

]
