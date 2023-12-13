"
A ToAnchoredWindowHandlerTest is a test class for testing the behavior of ToAnchoredWindowHandler
"
Class {
	#name : 'ToAnchoredWindowManagerTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Window',
	#package : 'Toplo-Tests',
	#tag : 'Core-Window'
}

{ #category : 'running' }
ToAnchoredWindowManagerTest >> setUp [ 

	super setUp.
	space := self newTestingSpace.

]

{ #category : 'tests' }
ToAnchoredWindowManagerTest >> testApplyPositionHookFromEvent [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowHandler := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	self should: [ windowHandler applyPositionHookFromEvent: nil ] raise: Error.
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	windowHandler applyPositionHookFromEvent: nil.
	self assert: windowHandler currentWindow identicalTo: win.
	self assert: win position equals: 0@0.
	self assert: windowHandler positionHook notNil.
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
ToAnchoredWindowManagerTest >> testElement [

	| win e openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget windowHandler |

	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowManager new builder: [ :window :element | ].
	windowHandler element: e.
	" create the window -> plug-in the window handler "
	win := windowHandler newWindowEvent: nil.
	
	self assert: win element identicalTo: e.
	
	" a window handler can be used only for one window  "
	self should: [ windowHandler newWindowEvent: nil  ] raise: Error.
	win
		when: ToWindowOpenedEvent
		do: [ :event | openEventFromWindow := event ].
	e
		when: ToWindowOpenedEvent
		do: [ :event | openEventFromWidget := event ].
	win
		when: ToWindowClosedEvent
		do: [ :event | closeEventFromWindow := event ].
	e
		when: ToWindowClosedEvent
		do: [ :event | closeEventFromWidget := event ].
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
ToAnchoredWindowManagerTest >> testElementEventHandlerClass [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowManager new builder: [ :anchWin :element |  ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
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
ToAnchoredWindowManagerTest >> testPositionHook [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowHandler := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	self assert: windowHandler positionHook notNil.
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

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	windowHandler positionHook: [ :event :theElement | theElement bounds inSpace bounds bottomRight ].
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

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowHandler := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowHandler element: e.
	windowHandler positionHook: [ :theEvent :theElement | 30@30 ].
	win := windowHandler newWindowEvent: nil.
	self assert: windowHandler positionHook notNil.
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
