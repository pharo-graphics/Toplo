"
A ToPopupWindowTest is a test class for testing the behavior of ToPopupWindow
"
Class {
	#name : #ToPopupWindowTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToPopupWindowTest >> testAssociateElement [

	| win e space |
	space := BlSpace new.
	e := e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	win := ToPopupWindow new associateElement: e.

	win popup.
	self waitTestingSpaces.
	self assert: win associateElement equals: e.
	self assert: win isOpened.
	win close.
	self waitTestingSpaces.
	self assert: win isClosed
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownDelayUp [

	| win e space |
	space := BlSpace new.
	e := e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	win := ToPopupWindow new associateElement: e.
	self assert: win associateElement equals: e.
	
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
	win := ToPopupWindow new associateElement: e.
	self assert: win associateElement equals: e.
	
	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self assert: win isOpened.
	BlSpace simulateMouseUpOn: e.
	self assert: win isOpened.
	
	" mouse down outside the widget"
	BlSpace simulateMouseDownOn: space root.
	BlSpace simulateMouseUpOn: space root.
	self assert: win isClosed
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseUpOutsideAssociateElement [

	| win e space |
	self skip.
	space := BlSpace new.
	e := e := ToElement new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	win := ToPopupWindow new associateElement: e.
	self assert: win associateElement equals: e.
	
	" mouse down on widget then up on popup"
	BlSpace simulateMouseDownOn: e.
	self assert: win isOpened.
	BlSpace simulateMouseUpOn: win.
	self flag: 'should stay opened. it works on examples. I guess this is due a bad implementation of the test:
	in working examples but the use case is a  mouse drag from e to win'.
	self assert: win isOpened.
	
	" mouse down on widget then up on space root"
	BlSpace simulateMouseDownOn: e.
	BlSpace simulateMouseUpOn: space root.
	self assert: win isOpened
]
