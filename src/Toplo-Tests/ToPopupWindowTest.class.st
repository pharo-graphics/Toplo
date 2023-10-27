"
A ToPopupWindowTest is a test class for testing the behavior of ToPopupWindow
"
Class {
	#name : 'ToPopupWindowTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Window',
	#package : 'Toplo-Tests',
	#tag : 'Core-Window'
}

{ #category : 'running' }
ToPopupWindowTest >> setUp [ 

	super setUp.
	space := self newTestingSpace.

]

{ #category : 'tests' }
ToPopupWindowTest >> testAssociateElement [

	| win e windowHandler |
	e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	
	" have to layout the space here to ensure that no position changed event is sent (which should close the window and make the test failing fail the test)"
	self waitTestingSpaces.
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

	| e windowHandler |
	e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	self waitTestingSpaces.
	
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

	| e windowHandler |
	e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	self waitTestingSpaces.

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

	| e windowHandler closed |
	e := e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	self waitTestingSpaces.

	windowHandler := ToPopupWindowHandler new builder: [ :anchWin :element | anchWin addChild: (ToElement new size: 20@20)].
	windowHandler element: e.

	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self assert: windowHandler currentWindow isOpened.
	BlSpace simulateMouseUpOn: e.
	self assert: windowHandler currentWindow isOpened.

	closed := false.
	windowHandler currentWindow when: ToWindowClosedEvent do: [ :event | closed := true ].
	BlSpace simulateMouseMoveOutside: windowHandler currentWindow.
	BlSpace simulateMouseDownOn: space root.
	BlSpace simulateMouseUpOn: space root.
	self assert: closed.
	self assert: windowHandler currentWindow isNil
]

{ #category : 'tests' }
ToPopupWindowTest >> testPopupOpenCloseWithMouseUpOutsideAssociateElement [

	| e  windowHandler closed |
	e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	self waitTestingSpaces.
	
	windowHandler := ToPopupWindowHandler new builder: [ :anchWin :element | anchWin addChild: (ToElement new size: 20@20)].
	windowHandler element: e.
	
	" mouse down on widget then up on popup"
	self waitTestingSpaces.
	BlSpace simulateMouseDownOn: e.
	self assert: windowHandler currentWindow isOpened.
	self waitTestingSpaces.
	BlSpace simulateMouseUpOn: windowHandler currentWindow.
	self assert: windowHandler currentWindow isOpened.
	
	closed := false.
	windowHandler currentWindow when: ToWindowClosedEvent do: [ :event | closed := true ].
	BlSpace simulateMouseDownOn: space root.
	BlSpace simulateMouseUpOn: space root.
	self assert: closed.
	self assert: windowHandler currentWindow isNil
]
