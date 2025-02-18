"
A ToAnchoredWindowHandlerTest is a test class for testing the behavior of ToAnchoredWindowHandler
"
Class {
	#name : #ToAnchoredWindowManagerTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToAnchoredWindowManagerTest >> testBuilder [

	| win e windowManager builder |
	e := ToElement new.
	space root addChild: e.
	builder := [ :theWindow :theElement |
	           | child |
	           child := ToElement new
		                    size: 100 asPoint;
		                    id: #child.
	           child background: Color red.
	           theWindow root addChild: child ].
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder:
		                 builder.
	self assert: windowManager windowBuilder identicalTo: builder.
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	self assert: win root children size equals: 1.
	self assert: win root firstChild id asSymbol identicalTo: #child.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds extent equals: 100 asPoint.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: win bounds extent equals: 100 asPoint
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testCloseWindow [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :request |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win isOpened.
	win close.
	self assert: win isClosed
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testCurrentWindow [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	self assert: windowManager currentWindow isNil.
	win := windowManager newWindowEvent: nil.
	self assert: windowManager currentWindow identicalTo: win.
	win popup.
	self waitTestingSpaces.
	self assert: windowManager currentWindow identicalTo: win.
	win close.
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testDefaultPositionHook [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: e bounds inSpace bounds origin equals: 20 asPoint.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testElement [

	| win e openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :window
		                 :element |  ].
	e addEventHandler: windowManager.
	" create the window -> plug-in the window handler "
	win := windowManager newWindowEvent: nil.

	self assert: win anchorElement identicalTo: e.

	" a window handler can be used only for one window  "
	self should: [ windowManager newWindowEvent: nil ] raise: Error.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openEventFromWindow := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openEventFromWidget := event ]).
	win addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closeEventFromWindow := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closeEventFromWidget := event ]).
	self assert: win anchorElement equals: e.

	win popup.
	self waitTestingSpaces.
	self assert: openEventFromWindow notNil.
	self assert: openEventFromWindow currentTarget equals: win.
	self assert: openEventFromWidget notNil.
	self assert: openEventFromWidget currentTarget equals: e.
	win close.
	self assert: closeEventFromWindow notNil.
	self assert: closeEventFromWindow currentTarget equals: win.
	self assert: closeEventFromWidget notNil.
	self assert: closeEventFromWidget currentTarget equals: e
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testElementEventHandler [

	| e windowManager |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	self assert: (e eventDispatcher handlers includes: windowManager)
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testElementEventHandlerClass [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win anchorElement equals: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToAnchoredWindowManager ]).
	win close.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToAnchoredWindowManager ]).

	self deny: win hasAssociateElement.
	self should: [ win popup ] raise: Error
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testElementPositionInSpaceChangedEvent [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	self assert: e position equals: 10 asPoint.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: e bounds inSpace bounds origin equals: 20 asPoint.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testElementRemovedFromParentEvent [

	| win e windowManager closed |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	closed := false.
	win addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ closed := true ]).
	self waitTestingSpaces.
	self assert: win isOpened.
	space root removeChild: e.
	self assert: closed.
	self assert: windowManager currentWindow isNil
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testElementRemovedFromSceneGraphEvent [

	self testElementRemovedFromParentEvent 
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testHasWindow [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	self deny: windowManager hasWindow.
	win := windowManager newWindowEvent: nil.
	self assert: windowManager hasWindow.
	win popup.
	self waitTestingSpaces.
	self assert: windowManager hasWindow.
	win close.
	self deny: windowManager hasWindow
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testNewWindowEvent [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	" no element -> Error "
	self should: [ windowManager newWindowEvent: nil ] raise: Error.
	e addEventHandler: windowManager.
	self assert: windowManager currentWindow isNil.
	win := windowManager newWindowEvent: nil.
	self assert: windowManager currentWindow identicalTo: win.
	" the window is already built -> Error "
	self should: [ windowManager newWindowEvent: nil ] raise: Error
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testNewWindowEvent2 [

	| win1 e windowManager |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win1 := windowManager newWindowEvent: nil.
	self assert: windowManager currentWindow identicalTo: win1.
	" the window is already built -> Error "
	self should: [ windowManager newWindowEvent: nil ] raise: Error.
	" the window is closed, closing it with #closWindow has no effect "
	windowManager closeWindow.
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testPopupWindowClass [

	| windowManager |
	windowManager := ToAnchoredWindowManager new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	self assert: windowManager popupWindowClass identicalTo: ToAnchoredWindow
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testPositionHook [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: e bounds inSpace bounds origin equals: 20 asPoint.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testPositionHook2 [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self waitTestingSpaces.
	windowManager placement: (ToActionPlacement new
			 action: [ :window :evt |
				 | theElem theRoot |
				 theElem := window anchorElement.
				 theRoot := window anchorRoot.
				 window position: (theElem bounds inParent: theRoot) bottomRight ];
			 yourself).
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	e position: 50 asPoint.
	self waitTestingSpaces.
	self assert: e bounds inSpace bounds origin equals: 50 asPoint.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds bottomRight
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testPositionHook3 [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
		windowManager placement: (ToActionPlacement new
			 action: [ :theWin :evt | 
				theWin position: 30 @ 30 ];
			 yourself).

	win := windowManager newWindowEvent: nil.

	win popup.
	self waitTestingSpaces.
	self waitTestingSpaces.
	self assert: win bounds inSpace bounds origin equals: 30 @ 30.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: e bounds inSpace bounds origin equals: 20 asPoint.
	self assert: win bounds inSpace bounds origin equals: 30 @ 30
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testWindowOpenRequestClass [

	| windowManager |
	windowManager := ToAnchoredWindowManager new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	self
		assert: windowManager windowRequestClass
		identicalTo: ToWindowRequest
]
