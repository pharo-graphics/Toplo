"
A ToAnchoredWindowHandlerTest is a test class for testing the behavior of ToAnchoredWindowHandler
"
Class {
	#name : #ToAnchoredWindowManagerTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToAnchoredWindowManagerTest >> testApplyPositionHookFromEvent [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :anchWin
		                 :element |  ].
	self
		should: [ windowManager applyPositionHookFromEvent: nil ]
		raise: Error.
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	windowManager applyPositionHookFromEvent: nil.
	self assert: windowManager currentWindow identicalTo: win.
	self assert: win position equals: 0 @ 0.
	self assert: windowManager positionHook notNil.
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
ToAnchoredWindowManagerTest >> testApplySizeHookFromEvent [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :anchWin
		                 :element |  ].
	self
		should: [ windowManager applySizeHookFromEvent: nil ]
		raise: Error.
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	windowManager sizeHook: [ :theWindow :theElement :theEvent |
		theWindow size: 100 asPoint ].
	windowManager applySizeHookFromEvent: nil.
	self assert: windowManager currentWindow identicalTo: win.
	win forceLayout.
	self assert: win bounds extent equals: 100 asPoint.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds extent equals: 100 asPoint.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: win bounds extent equals: 100 asPoint
]

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
	windowManager := ToAnchoredWindowManagerForTest new builder: builder.
	self assert: windowManager builder identicalTo: builder.
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

	windowManager := ToAnchoredWindowManagerForTest new builder: [
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
	windowManager := ToAnchoredWindowManagerForTest new builder: [
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
	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :anchWin
		                 :element |  ].
	self assert:
		(windowManager defaultPositionHook isKindOf: BlockClosure).
	self
		should: [ windowManager applyPositionHookFromEvent: nil ]
		raise: Error.
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
ToAnchoredWindowManagerTest >> testDefaultSizeHook [

	| e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowManager := ToAnchoredWindowManager new.
	self assert: windowManager defaultSizeHook isNil
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testElement [

	| win e openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :window
		                 :element |  ].
	e addEventHandler: windowManager.
	" create the window -> plug-in the window handler "
	win := windowManager newWindowEvent: nil.

	self assert: win element identicalTo: e.

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
	self assert: win element equals: e.

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
	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	self assert: (e eventDispatcher handlers includes:
			 windowManager)
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testElementEventHandlerClass [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win element equals: e.
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

	windowManager := ToAnchoredWindowManagerForTest new builder: [
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
ToAnchoredWindowManagerTest >> testElementRemovedFromParentEvent [

	| win e windowManager closed |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new builder: [
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
	windowManager := ToAnchoredWindowManagerForTest new builder: [
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
	windowManager := ToAnchoredWindowManagerForTest new builder: [
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
ToAnchoredWindowManagerTest >> testPositionHook [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	self assert: windowManager positionHook notNil.
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
ToAnchoredWindowManagerTest >> testPositionHook2 [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	windowManager positionHook: [ :theWindow :theElement :event |
		theWindow position: theElement bounds inSpace bounds bottomRight ].
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

	windowManager := ToAnchoredWindowManagerForTest new builder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	windowManager positionHook: [ :theWindow :theElement :event |
		theWindow position: 30 @ 30 ].
	win := windowManager newWindowEvent: nil.
	self assert: windowManager positionHook notNil.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds inSpace bounds origin equals: 30 @ 30.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: e bounds inSpace bounds origin equals: 20 asPoint.
	self assert: win bounds inSpace bounds origin equals: 30 @ 30
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testSizeHook [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager newWindowEvent: nil.
	windowManager sizeHook: [ :theWindow :theElement :tenEvent |
		theWindow size: 100 asPoint ].
	windowManager applySizeHookFromEvent: nil.
	win forceLayout.
	self assert: win bounds extent equals: 100 asPoint
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testWindowClass [

	| windowManager |
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self assert: windowManager windowClass identicalTo: ToAnchoredWindow
]

{ #category : #tests }
ToAnchoredWindowManagerTest >> testWindowOpenRequestClass [

	| windowManager |
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self assert: windowManager windowRequestClass identicalTo: ToWindowRequest
]
