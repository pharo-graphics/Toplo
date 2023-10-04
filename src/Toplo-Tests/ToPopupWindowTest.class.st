"
A ToPopupWindowTest is a test class for testing the behavior of ToPopupWindow
"
Class {
	#name : #ToPopupWindowTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownDelayUp [

	| win e space |
	space := BlSpace new.
	e := e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	win := ToPopupWindow new widget: e.
	self assert: win widget equals: e.
	
	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self assert: win isOpened.
	BlSpace simulateMouseUpOn: e.
	self assert: win isOpened.
	
	" mouse down then wait a delay then a mouse up -> the popup should be closed"
	BlSpace simulateMouseDownOn: e.
	win autoCloseOnMouseUpDelay wait.
	BlSpace simulateMouseUpOn: e.
	self assert: win isClosed
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownOutside [

	| win e space |
	space := BlSpace new.
	e := e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	win := ToPopupWindow new widget: e.
	self assert: win widget equals: e.
	
	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self assert: win isOpened.
	BlSpace simulateMouseUpOn: e.
	self assert: win isOpened.
	
	" mouse down outside the widget"
	BlSpace simulateMouseDownOn: space root.
	self assert: win isClosed
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseUpOutsideWidget [

	| win e space |
	space := BlSpace new.
	e := e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	win := ToPopupWindow new widget: e.
	self assert: win widget equals: e.
	
	" mouse down on widget then up on popup"
	BlSpace simulateMouseDownOn: e.
	self assert: win isOpened.
	BlSpace simulateMouseUpOn: win.
	self assert: win isOpened.
	
	" mouse down on widget then up on space root"
	BlSpace simulateMouseDownOn: e.
	BlSpace simulateMouseUpOn: space root.
	self assert: win isOpened
]

{ #category : #tests }
ToPopupWindowTest >> testPopupWithWidgetInSpace [

	| win e space |
	space := BlSpace new.
	e := e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	win := ToPopupWindow new widget: e.

	win popup.
	self waitTestingSpaces.
	self assert: win widget equals: e.
	self assert: win isOpened.
	win close.
	self waitTestingSpaces.
	self assert: win isClosed
]
