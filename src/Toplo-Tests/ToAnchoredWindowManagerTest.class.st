"
A ToAnchoredWindowHandlerTest is a test class for testing the behavior of ToAnchoredWindowHandler
"
Class {
	#name : 'ToAnchoredWindowManagerTest',
	#superclass : 'ToParameterizedHostTest',
	#category : 'Toplo-Tests-Core-Window',
	#package : 'Toplo-Tests',
	#tag : 'Core-Window'
}

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testApplyHeightHookFromEvent [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self should: [ windowManager applyHeightHookFromEvent: nil ] raise: Error.
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	windowManager heightHook: [ :theWindow :theElement | 100 ].
	windowManager applyHeightHookFromEvent: nil.
	self assert: windowManager currentWindow identicalTo: win.
	win forceLayout.
	self assert: win bounds height equals: 100.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds height equals: 100.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: win bounds height equals: 100.


	
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testApplyPositionHookFromEvent [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self should: [ windowManager applyPositionHookFromEvent: nil ] raise: Error.
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	windowManager applyPositionHookFromEvent: nil.
	self assert: windowManager currentWindow identicalTo: win.
	self assert: win position equals: 0@0.
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
		equals: e bounds inSpace bounds origin.


	
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testApplyWidthHookFromEvent [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self should: [ windowManager applyWidthHookFromEvent: nil ] raise: Error.
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	windowManager widthHook: [ :theWindow :theElement | 100 ].
	windowManager applyWidthHookFromEvent: nil.
	self assert: windowManager currentWindow identicalTo: win.
	win forceLayout.
	self assert: win bounds width equals: 100.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds width equals: 100.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: win bounds width equals: 100.


	
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testBuilder [

	| win e  windowManager builder|
	e := ToElement new.
	space root addChild: e.
	builder := [ :theWindow :theElement | 
		| child |
		child := ToElement new size: 100 asPoint; id: #child.
		child background: Color red.
		theWindow root addChild: child].
	windowManager := ToAnchoredWindowManager new builder: builder.
	self assert: windowManager builder identicalTo: builder.
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	self assert: win root children size equals: 1.
	self assert: win root firstChild id asSymbol identicalTo: #child.
	win popup.
	self waitTestingSpaces.
	self assert: win bounds extent equals: 100 asPoint.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: win bounds extent equals: 100 asPoint.


	
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testCloseWindow [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :request | ].
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	win popup.
	self assert: win isOpened.
	windowManager closeWindow.
	self assert: win isClosed

]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testCurrentWindow [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowManager element: e.
	self assert: windowManager currentWindow isNil.
	win := windowManager newWindowEvent: nil.
	self assert: windowManager currentWindow identicalTo: win.
	win popup.
	self assert: windowManager currentWindow identicalTo: win.
	windowManager closeWindow.
	self assert: windowManager currentWindow isNil.

]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testDefaultHeightHook [

	| e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowManager := ToAnchoredWindowManager new.
	self assert: windowManager defaultHeightHook isNil
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testDefaultPositionHook [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.	
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self assert: (windowManager defaultPositionHook isKindOf: BlockClosure).
	self should: [ windowManager applyPositionHookFromEvent: nil ] raise: Error.
	windowManager element: e.
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
		equals: e bounds inSpace bounds origin.


	
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testDefaultWidthHook [

	| e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	windowManager := ToAnchoredWindowManager new.
	self assert: windowManager defaultWidthHook isNil
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testElement [

	| win e openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManager new builder: [
		                 :window
		                 :element |  ].
	windowManager element: e.
	" create the window -> plug-in the window handler "
	win := windowManager newWindowEvent: nil.

	self assert: win element identicalTo: e.

	" a window handler can be used only for one window  "
	self should: [ windowManager newWindowEvent: nil ] raise: Error.
	win addEventHandler: (BlEventHandler
			 on: ToWindowOpenedEvent
			 do: [ :event | openEventFromWindow := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToWindowOpenedEvent
			 do: [ :event | openEventFromWidget := event ]).
	win addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :event | closeEventFromWindow := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToWindowClosedEvent
			 do: [ :event | closeEventFromWidget := event ]).
	self assert: win element equals: e.

	win popup.
	self assert: openEventFromWindow isNil.
	win forceLayout.
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

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testElementEventHandler [

	| e windowManager |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self assert: windowManager elementEventHandler isNil.
	windowManager element: e.
	self assert: windowManager elementEventHandler notNil.
	self assert: (e eventDispatcher handlers includes: windowManager elementEventHandler)
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testElementEventHandlerClass [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element |  ].
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	win popup.
	self assert: win element equals: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToAnchorEventHandler ]).
	win close.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: ToAnchorEventHandler ]).

	self deny: win hasAssociateElement.
	self should: [ win popup ] raise: Error
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testHasWindow [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowManager element: e.
	self deny: windowManager hasWindow.
	win := windowManager newWindowEvent: nil.
	self assert: windowManager hasWindow.
	win popup.
	self assert: windowManager hasWindow.
	windowManager closeWindow.
	self deny: windowManager hasWindow.

]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testHeightHook [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowManager := ToAnchoredWindowManager new.
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	windowManager heightHook: [ :theWindow :theElement | 100 ].
	windowManager applyHeightHookFromEvent: nil.
	win forceLayout.
	self assert: win bounds height equals: 100 
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testNewElementEventHandler [

	| windowManager |
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self assert: windowManager elementEventHandler isNil.
	windowManager newElementEventHandler.
	self assert: windowManager elementEventHandler notNil
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testNewWindowEvent [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	" no element -> Error "
	self should: [ windowManager newWindowEvent: nil ] raise: Error.
 	windowManager element: e.
	self assert: windowManager currentWindow isNil.
	win := windowManager newWindowEvent: nil.
	self assert: windowManager currentWindow identicalTo: win.
	" the window is already built -> Error "
	self should: [ windowManager newWindowEvent: nil ] raise: Error.

]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testNewWindowEvent2 [

	| win1 win2 e  windowManager |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManager new.
 	windowManager element: e.
	win1 := windowManager newWindowEvent: nil.
	self assert: windowManager currentWindow identicalTo: win1.
	" the window is already built -> Error "
	windowManager closeWindow.
	win2 := windowManager newWindowEvent: nil.
	self deny: win1 identicalTo: win2

]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testPositionHook [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowManager element: e.
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
		equals: e bounds inSpace bounds origin.


	
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testPositionHook2 [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	windowManager positionHook: [ :event :theElement | theElement bounds inSpace bounds bottomRight ].
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds bottomRight.
	e position: 50 asPoint.
	self waitTestingSpaces.
	self assert: e bounds inSpace bounds origin equals: 50 asPoint.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds bottomRight.

	
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testPositionHook3 [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowManager element: e.
	windowManager positionHook: [ :theEvent :theElement | 30@30 ].
	win := windowManager newWindowEvent: nil.
	self assert: windowManager positionHook notNil.
	win popup.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: 30@30.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self assert: e bounds inSpace bounds origin equals: 20 asPoint.
	self
		assert: win bounds inSpace bounds origin
		equals: 30@30.


	
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testWidthHook [

	| win e  windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowManager := ToAnchoredWindowManager new.
	windowManager element: e.
	win := windowManager newWindowEvent: nil.
	windowManager widthHook: [ :theWindow :theElement | 100 ].
	windowManager applyWidthHookFromEvent: nil.
	win forceLayout.
	self assert: win bounds width equals: 100 
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testWindowClass [

	| windowManager |
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self assert: windowManager windowClass identicalTo: ToAnchoredWindow
]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testWindowRequestClass [

	| windowManager |
	windowManager := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self assert: windowManager windowRequestClass identicalTo: ToWindowRequest
]
