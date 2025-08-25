"
A ToAnchoredWindowTest is a test class for testing the behavior of ToAnchoredWindow
"
Class {
	#name : #ToAnchoredWindowTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #tests }
ToAnchoredWindowTest >> testClose [

	| win e windowManager winRootChild |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.
	winRootChild := ToElement new.

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element | anchWin root addChild: winRootChild ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: winRootChild parent identicalTo: win root.
	self deny: win isOpened.
	" can't close a closed window "
	self should: [ win close ] raise: Error.
	windowManager closeWindow.
	" but after it has been closed, it can't be opened anymore "
	win popup
]

{ #category : #tests }
ToAnchoredWindowTest >> testClosedEventClass [

	| win windowManager e closeEvent |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closeEvent := event ]).
	self assert: closeEvent isNil.
	win popup.
	self waitTestingSpaces.
	win close.
	" need to wait space pulsing "
	self waitTestingSpaces.
	self assert: closeEvent notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testDefaultElevation [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	e position: 10 asPoint.
	e extent: 10 asPoint.
	win popup.
	self
		assert: win elevation elevation
		equals: win defaultElevation elevation
]

{ #category : #tests }
ToAnchoredWindowTest >> testDispatchClosedEvent [

	| win e windowManager closedEventReceivedByWin closedEventReceivedByElement |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closedEventReceivedByWin := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closedEventReceivedByElement := event ]).
	win popup.
	self waitTestingSpaces.
	win close.
	self waitTestingSpaces.
	self assert: closedEventReceivedByWin notNil.
	self assert: closedEventReceivedByElement notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testDispatchOpenedEvent [

	| win e windowManager openedEventReceivedByWin openedEventReceivedByElement |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEventReceivedByWin := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEventReceivedByElement := event ]).
	win popup.
	self waitTestingSpaces.
	self assert: openedEventReceivedByWin notNil.
	self assert: openedEventReceivedByElement notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testElement [

	| win e windowManager |
	win := ToAnchoredWindow new.
	self assert: win anchorElement isNil.
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win anchorElement identicalTo: e
]

{ #category : #tests }
ToAnchoredWindowTest >> testHasAssociateElement [

	| win e windowManager |
	win := ToAnchoredWindow new.
	self deny: win hasAnchorElement.
	self should: [ win popup ] raise: Error.
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win hasAnchorElement
]

{ #category : #tests }
ToAnchoredWindowTest >> testLocalThemeSetOnPopupEvent [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win localTheme isNil.
	win popupEvent: nil.
	self waitTestingSpaces.
	self assert: win localTheme identicalTo: e lookupTheme.
	win close.
	self waitTestingSpaces.
	self assert: win localTheme identicalTo: e lookupTheme.
]

{ #category : #tests }
ToAnchoredWindowTest >> testLocalThemeSetOnPopupEvent2 [

	| win e windowManager localTheme |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win localTheme isNil.
	localTheme := ToRawDarkTheme new.
	" Even the win localTheme is set directly, 
	the actual win localTheme is the theme found from the element"
	win localTheme: localTheme.
	win popupEvent: nil.
	self waitTestingSpaces.
	self assert: win localTheme identicalTo: e lookupTheme.
	win close.
	self waitTestingSpaces.
	self assert: win localTheme identicalTo: e lookupTheme.
]

{ #category : #tests }
ToAnchoredWindowTest >> testManager [

	| win e windowManager |
	win := ToAnchoredWindow new.
	self assert: win manager isNil.
	self should: [ win popup ] raise: Error.
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win manager identicalTo: windowManager
]

{ #category : #tests }
ToAnchoredWindowTest >> testOnOpened [

	| win e windowManager openedEventReceivedByWin openedEventReceivedByElement |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEventReceivedByWin := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEventReceivedByElement := event ]).
	win popup.
	self waitTestingSpaces.
	self assert: openedEventReceivedByWin notNil.
	self assert: openedEventReceivedByElement notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testOpenedEventClass [

	| win windowManager e openedEvent |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEvent := event ]).
	self assert: openedEvent isNil.
	win popup.
	" need to wait space pulsing "
	self waitTestingSpaces.
	self assert: openedEvent notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopup [

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win popup.
	self waitTestingSpaces.
	self assert: win isOpened.
	self assert: win parent notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupEvent [

	| win e windowManager openedEvent sourceEvent |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEvent := event ]).
	win popupEvent: nil.
	self waitTestingSpaces.
	win close.
	self waitTestingSpaces.
	sourceEvent := BlEvent new.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEvent := event ]).
	win popupEvent: sourceEvent.
	self waitTestingSpaces.
	self assert: openedEvent class equals: win openedEventClass
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupEventNotInSpace [

	| win e openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget windowManager |
	e := ToElement new.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win hasAnchorElement.
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

	self should: [ win popup ] raise: Error.
	self assert: win isOpened not.
	self assert: openEventFromWindow isNil.
	self assert: openEventFromWidget isNil.
	space root addChild: e.
	win popup.
	self waitTestingSpaces.
	win close.
	self assert: closeEventFromWindow notNil.
	self assert: closeEventFromWidget notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupEventNotInSpace2 [

	| win e windowManager |
	e := ToElement new.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self waitTestingSpaces.
	self should: [ win popup ] raise: Error.
	self assert: win isOpened not.
	self assert: win isClosed
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupEventWithoutElement [

	| w |
	w := ToAnchoredWindow new.
	self assert: w hasAnchorElement not.
	self should: [ w popup ] raise: Error
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupTimeStamp [

	| win windowManager e openedEvent timeStamp |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEvent := event ]).
	self assert: openedEvent isNil.
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

{ #category : #tests }
ToAnchoredWindowTest >> testValueOfTokenNamedInWindow [

	| win e windowManager lab |
	e := ToElement new.
	e localTheme: ToRawThemeForTest new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :requestEvent |
		                 lab := ToLabel new text: 'H'.
		                 anchWin root addChild: lab ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win popupEvent: nil.
	self waitTestingSpaces.
	self
		assert: (e valueOfTokenNamed: #'test-background-color')
		equals: Color white.
	self assert: lab notNil.
	"self assert: win localTheme identicalTo: e lookupTheme."
	self assert: lab lookupTheme identicalTo: win lookupTheme.
	self
		assert: (lab valueOfTokenNamed: #'test-background-color')
		equals: Color white.
	win close.
	self waitTestingSpaces.
	self
		assert: (e valueOfTokenNamed: #'test-background-color')
		equals: Color white.
	self
		should: [ lab valueOfTokenNamed: #'test-background-color' ]
		raise: Error
]

{ #category : #tests }
ToAnchoredWindowTest >> testWindowSize [
	" since there is no size hook by default, the window is fitContent by default"

	| win e windowManager |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e extent: 10 asPoint.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
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
	self assert: win bounds inSpace extent equals: 0 @ 0.
	self assert: win root bounds inSpace extent equals: 0 @ 0.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	self assert: win bounds inSpace extent equals: 0 @ 0
]
