"
A ToAnchoredWindowTest is a test class for testing the behavior of ToAnchoredWindow
"
Class {
	#name : 'ToAnchoredWindowTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Window',
	#package : 'Toplo-Tests',
	#tag : 'Core-Window'
}

{ #category : 'running' }
ToAnchoredWindowTest >> setUp [ 

	super setUp.
	space := self newTestingSpace.

]

{ #category : 'tests' }
ToAnchoredWindowTest >> testDefaultElevation [

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win popup.
	self
		assert: win elevation elevation
		equals: win defaultElevation elevation
]

{ #category : 'tests' }
ToAnchoredWindowTest >> testPopupEvent [

	| win e  timeStamp windowHandler |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.

	windowHandler := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.

	self assert: win isOpened not.
	self assert: win isClosed.
	self assert: win popupTimestamp isNil.
	win popup.
	self waitTestingSpaces.

	self assert: win popupTimestamp notNil.
	timeStamp := win popupTimestamp.
	self assert: win popupTimestamp <= DateAndTime now.
	self assert: win isOpened.
	self assert: win isClosed not.
	win close.
	self waitTestingSpaces.
	self assert: win popupTimestamp equals: timeStamp.
	self assert: win isOpened not.
	self assert: win isClosed
]

{ #category : 'tests' }
ToAnchoredWindowTest >> testPopupEventNotInSpace [

	| win e openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget windowHandler |
	e := ToElement new.
	windowHandler := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
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

{ #category : 'tests' }
ToAnchoredWindowTest >> testPopupEventNotInSpace2 [

	| win e windowHandler |
	e := ToElement new.
	windowHandler := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
	windowHandler element: e.
	win := windowHandler newWindowEvent: nil.
	self waitTestingSpaces.
	self should: [ win popup ] raise: Error.
	self assert: win isOpened not.
	self assert: win isClosed.

]

{ #category : 'tests' }
ToAnchoredWindowTest >> testPopupEventWithoutElement [

	| w |
	w := ToAnchoredWindow new.
	self assert: w hasAssociateElement not.
	self should: [ w popup ] raise: Error
]

{ #category : 'tests' }
ToAnchoredWindowTest >> testWindowSize [
	" since there is no size hook by default, the window is fitContent by default"

	| win e  windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowManager new builder: [ :anchWin :element | ].
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
