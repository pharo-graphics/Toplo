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
	e := ToElementWithAssociateWindowForTest new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	e associateWindowFactory: [ ToPopupWindow new ].
	win := e newAssociateWindow.
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
	e := ToElementWithAssociateWindowForTest new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	e associateWindowFactory: [ ToPopupWindow new ].
	win := e newAssociateWindow.
	self assert: win associateElement equals: e.
	self should: [ e newAssociateWindow ] raise: Error.
	e dissociateFromWindow.
	e when: BlMouseDownEvent do: [ :event | (win := e newAssociateWindow) popupEvent: event].
	e when: BlMouseUpEvent do: [ :event | (win := e currentAssociateWindow) ifNotNil: [:w | w close]. ].
	
	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self assert: win isOpened.
	BlSpace simulateMouseUpOn: e.
	self assert: win isClosed
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownDelayUp2 [

	| win e space |
	space := BlSpace new.
	e := ToElementWithAssociateWindowForTest new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	e associateWindowFactory: [ ToPopupWindow new ].
	win := e newAssociateWindow.
	self assert: win associateElement equals: e.
	self should: [ e newAssociateWindow ] raise: Error.
	e dissociateFromWindow.
	e when: BlMouseDownEvent do: [ :event | 'down' traceCr. (win := e newAssociateWindow) popupEvent: event].
		
	" mouse down then wait a delay then a mouse up -> the popup should be closed"
	BlSpace simulateMouseDownOn: e.
	self assert: e currentAssociateWindow notNil.
	(win autoCloseOnMouseUpDelay + 1 milliSecond ) wait.
	BlSpace simulateMouseUpOn: e.
	" window is closed on mouse-up "
	self assert: e currentAssociateWindow isNil
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseDownOutside [

	| win e space |
	space := BlSpace new.
	e := e := ToElementWithAssociateWindowForTest new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	e associateWindowFactory: [ ToPopupWindow new ].
	win := e newAssociateWindow.
	self assert: win isClosed.
	self assert: win associateElement equals: e.
	e dissociateFromWindow.
	e when: BlMouseDownEvent do: [ :event | (win := e newAssociateWindow) popupEvent: event].
	e when: BlMouseUpEvent do: [ :event | e currentAssociateWindow close. ].
	" mouse down immediately followed by a mouse up -> the popup should stay opened"
	BlSpace simulateMouseDownOn: e.
	self assert: win isOpened.
	BlSpace simulateMouseUpOn: e.
	self assert: win isClosed.
	
	" mouse down outside the widget"
	BlSpace simulateMouseDownOn: e.
	self assert: win isOpened.
	BlSpace simulateMouseDownOn: space root.
	
	self assert: win isClosed
]

{ #category : #tests }
ToPopupWindowTest >> testPopupOpenCloseWithMouseUpOutsideAssociateElement [

	| win e space |
	space := BlSpace new.
	e := ToElementWithAssociateWindowForTest new
		          background: Color red;
		          size: 100 @ 40;
		          position: 50 @ 50.
	space root addChild: e.
	e associateWindowFactory: [ ToPopupWindow new ].
	win := e newAssociateWindow.
	self assert: win associateElement equals: e.
	e dissociateFromWindow.
	e when: BlMouseDownEvent do: [ :event | (win := e newAssociateWindow) popupEvent: event].
	e when: BlMouseUpEvent do: [ :event | e currentAssociateWindow close. ].
	
	" mouse down on widget then up on popup"
	self waitTestingSpaces.
	BlSpace simulateMouseDownOn: e.
	self assert: win isOpened.
	self waitTestingSpaces.
	BlSpace simulateMouseUpOn: win.
	self assert: win isOpened.
	" mouse donw outside closes the iwndow"
	BlSpace simulateMouseDownOn: space root.
	self assert: win isClosed.
	

	

]
