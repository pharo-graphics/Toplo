"
A ToAnchoredWindowTest is a test class for testing the behavior of ToAnchoredWindow
"
Class {
	#name : #ToAnchoredWindowTest,
	#superclass : #BlParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Window'
}

{ #category : #running }
ToAnchoredWindowTest >> setUp [ 

	super setUp.
	space := self newTestingSpace.

]

{ #category : #tests }
ToAnchoredWindowTest >> testAssociateElement [

	| win e openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget windowHandler |

	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowHandler new builder: [ :window :element | ].
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
ToAnchoredWindowTest >> testAssociateElementEventHandler [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowHandler new builder: [ :anchWin :element |  ].
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

{ #category : #tests }
ToAnchoredWindowTest >> testElevation [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win popup.
	self
		assert: win elevation elevation
		equals: win defaultElevation elevation
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupWithAssociateElementInSpace2 [

	| win e  timeStamp windowHandler |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	self assert: win isOpened not.
	self assert: win isClosed.
	self assert: win popupTimestamp isNil.
	win popup.
	self assert: win popupTimestamp notNil.
	timeStamp := win popupTimestamp.
	self assert: win popupTimestamp < DateAndTime now.
	self assert: win isOpened.
	self assert: win isClosed not.
	win close.
	self assert: win popupTimestamp equals: timeStamp.
	self assert: win isOpened not.
	self assert: win isClosed
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupWithAssociateElementNotInSpace [

	| win e openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget windowHandler |
	e := ToElement new.
	windowHandler := ToAnchoredWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	self assert: win hasAssociateElement.
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
		
	self should: [ win popup ] raise: Error.
	self assert: win isOpened not.
	self assert: openEventFromWindow isNil.
	self assert: openEventFromWidget isNil.
	win close.
	self assert: closeEventFromWindow notNil.
	self assert: closeEventFromWidget notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupWithAssociateElementNotInSpace2 [

	| win e windowHandler |
	e := ToElement new.
	windowHandler := ToAnchoredWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	self waitTestingSpaces.
	self should: [ win popup ] raise: Error.
	self assert: win isOpened not.
	self assert: win isClosed.

]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupWithoutAssociateElement [

	| w |
	w := ToAnchoredWindow new.
	self assert: w hasAssociateElement not.
	self should: [ w popup ] raise: Error
]

{ #category : #tests }
ToAnchoredWindowTest >> testPositionHook [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.
	
	windowHandler := ToAnchoredWindowHandler new builder: [ :anchWin :element | ].
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
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.


	
]

{ #category : #tests }
ToAnchoredWindowTest >> testPositionHook2 [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	self assert: windowHandler positionHook notNil.
	win popup.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	self assert: win hasAssociateElement.	
	windowHandler positionHook: [ :event :theElement | e bounds inSpace bounds bottomRight ].
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds bottomRight.
	e position: 50 asPoint.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds bottomRight.

	
]

{ #category : #tests }
ToAnchoredWindowTest >> testWindowSize [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowHandler new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	self assert: win constraints horizontal resizer isFitContent.
	self assert: win constraints vertical resizer isFitContent.
	self assert: win root constraints horizontal resizer isFitContent.
	self assert: win root constraints vertical resizer isFitContent.
	win popup.
	self waitTestingSpaces.
	self assert: win constraints horizontal resizer isFitContent.
	self assert: win constraints vertical resizer isFitContent.
	self assert: win root constraints horizontal resizer isFitContent.
	self assert: win root constraints vertical resizer isFitContent.
	self
		assert: win bounds inSpace extent 
		equals: 0@0.
	self
		assert: win root bounds inSpace extent 
		equals: 0@0.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	self
		assert: win bounds inSpace extent 
		equals: 0@0.



	
]

{ #category : #tests }
ToAnchoredWindowTest >> testWindowSize2 [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowHandler new builder: [ :anchWin :element |  ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	win popup.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace extent 
		equals: 0@0.
	self
		assert: win root bounds inSpace extent 
		equals: 0@0.

	win root addChild: (ToElement new size: 100 asPoint ).
	self waitTestingSpaces.

	self
		assert: win bounds inSpace extent 
		equals: 100 asPoint.
	self
		assert: win root bounds inSpace extent 
		equals: 100 asPoint.
	
]
