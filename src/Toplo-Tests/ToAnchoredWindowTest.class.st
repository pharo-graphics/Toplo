"
A ToAnchoredWindowTest is a test class for testing the behavior of ToAnchoredWindow
"
Class {
	#name : #ToAnchoredWindowTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToAnchoredWindowTest >> testAssociateElement [

	| win e space openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget |
	space := BlSpace new.
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToAnchoredWindow new associateElement: e.
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
	win popup.
	self assert: win associateElement equals: e.	
	self assert: openEventFromWindow notNil.
	self assert: openEventFromWindow currentTarget equals: win.
	self assert: openEventFromWindow window equals: win.
	self assert: openEventFromWidget notNil.
	self assert: openEventFromWidget currentTarget equals: e.
	self assert: openEventFromWidget window equals: win.
	win close.
	self assert: closeEventFromWindow notNil.
	self assert: closeEventFromWindow currentTarget equals: win.
	self assert: closeEventFromWindow window equals: win.
	self assert: closeEventFromWidget notNil.
	self assert: closeEventFromWidget currentTarget equals: e.
	self assert: closeEventFromWidget window equals: win
]

{ #category : #tests }
ToAnchoredWindowTest >> testAssociateElementEventHandler [

	| win e space |
	space := BlSpace new.
	e := ToElement new.
	space root addChild: e.
	win := ToAnchoredWindow new associateElement: e.
	win popup.
	self assert: win associateElement equals: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: win defaultAssociateElementEventHandlerClass ]).
	win close.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: win defaultAssociateElementEventHandlerClass ]).

	self assert: win hasAssociateElement.
	win associateElement: nil.
	self assert: win hasAssociateElement not.
	self assert: win associateElement isNil.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: win defaultAssociateElementEventHandlerClass ]) not.
	self should: [ win popup ] raise: Error
]

{ #category : #tests }
ToAnchoredWindowTest >> testAssociateElementEventHandler2 [

	| win e space |
	space := BlSpace new.
	e := ToElement new.
	space root addChild: e.
	win := ToAnchoredWindow new associateElement: e.
	win popup.
	self assert: win associateElement equals: e.
	self assert: (e eventDispatcher hasEventHandlerSuchThat: [ :eh |
			 eh isKindOf: win defaultAssociateElementEventHandlerClass ]).
	win associateElement: nil.
	win close.
]

{ #category : #tests }
ToAnchoredWindowTest >> testElevation [

	| win e space |
	space := BlSpace new.
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToAnchoredWindow new associateElement: e.
	win popup.
	self
		assert: win elevation elevation
		equals: win defaultElevation elevation
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupWithAssociateElementInSpace2 [

	| win e space timeStamp |
	space := BlSpace new.
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToAnchoredWindow new associateElement: e.
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

	| win e openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget |
	e := ToElement new.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToAnchoredWindow new associateElement: e.
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
	self assert: closeEventFromWindow isNil.
	self assert: closeEventFromWidget isNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupWithAssociateElementNotInSpace2 [

	| win e |
	e := ToElement new.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToAnchoredWindow new associateElement: e.
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

	| win e space |
	space := self newTestingSpace.
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToAnchoredWindow new associateElement: e.
	self assert: win positionHook notNil.
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

	| win e space |
	space := self newTestingSpace.
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToAnchoredWindow new associateElement: e.
	self assert: win positionHook notNil.
	win popup.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	self assert: win hasAssociateElement.	
	win positionHook: [ :w :event | w associateElement bounds inSpace bounds bottomRight ].
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	win setPositionFromHook.
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
ToAnchoredWindowTest >> testWindowsize [

	| win e space |
	space := self newTestingSpace.
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToAnchoredWindow new associateElement: e.
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
ToAnchoredWindowTest >> testWindowsize2 [

	| win e space |
	space := self newTestingSpace.
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win := ToAnchoredWindow new associateElement: e.
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
