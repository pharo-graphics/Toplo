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
	space deferAndSettle: [ space root addChild: e ].
	winRootChild := ToElement new.

	windowManager :=
		ToAnchoredWindowManagerForTest new
			windowBuilder: [ :anchWin :element |
				anchWin root addChild: winRootChild ];
			yourself.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: winRootChild parent identicalTo: win root.
	self deny: win isOpened.

	" can't close a closed window "
	self should: [ win close ] raise: Error.
	windowManager closeWindow.
	" but after it has been closed, it can't be opened anymore "
	space deferAndSettle: [ win popup ].

]

{ #category : #tests }
ToAnchoredWindowTest >> testClosedEventClass [

	| win windowManager e closeEvent |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].
	windowManager :=
		ToAnchoredWindowManagerForTest new
			windowBuilder: [ :anchWin :element |  ];
			yourself.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closeEvent := event ]).
	self assert: closeEvent isNil.

	space deferAndSettle: [ win popup ].

	" need to wait space pulsing "
	space deferAndSettle: [ win close ].
	self assert: closeEvent notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testDefaultElevation [

	| win e windowManager |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.

	space deferAndSettle: [
		e position: 10 asPoint.
		e extent: 10 asPoint.
		win popup ].
	self
		assert: win elevation elevation
		equals: win defaultElevation elevation
]

{ #category : #tests }
ToAnchoredWindowTest >> testDispatchClosedEvent [

	| win e windowManager closedEventReceivedByWin closedEventReceivedByElement |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closedEventReceivedByWin := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToClosedEvent
			 do: [ :event | closedEventReceivedByElement := event ]).

	space deferAndSettle: [
		win popup .
		win close ].
	self assert: closedEventReceivedByWin notNil.
	self assert: closedEventReceivedByElement notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testDispatchOpenedEvent [

	| win e windowManager openedEventReceivedByWin openedEventReceivedByElement |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEventReceivedByWin := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEventReceivedByElement := event ]).

	space deferAndSettle: [ win popup ].
	self assert: openedEventReceivedByWin notNil.
	self assert: openedEventReceivedByElement notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testElement [

	| win e windowManager |
	win := ToAnchoredWindow new.
	self deny: win hasManager.
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win anchorElement identicalTo: e
]

{ #category : #tests }
ToAnchoredWindowTest >> testHasAssociateElement [

	| win e windowManager |
	win := ToAnchoredWindow new.
	self deny: win hasManager.
	self should: [ win popup ] raise: Error.
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win hasAnchorElement
]

{ #category : #tests }
ToAnchoredWindowTest >> testLocalThemeSetOnPopupEvent [

	| win e windowManager |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win localTheme isNil.

	space deferAndSettle: [ win popupEvent: nil ].
	self assert: win lookupTheme identicalTo: e lookupTheme.

	space deferAndSettle: [ win close ].
	self assert: win lookupTheme identicalTo: e lookupTheme.
]

{ #category : #tests }
ToAnchoredWindowTest >> testLocalThemeSetOnPopupEvent2 [

	| win e windowManager localTheme |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win localTheme isNil.
	localTheme := ToRawDarkTheme new.
	" Even the win localTheme is set directly, 
	the actual win localTheme is the theme found from the element"
	space deferAndSettle: [
		win localTheme: localTheme.
		win popupEvent: nil ].
	self assert: win localTheme identicalTo: localTheme.
	self assert: win lookupTheme identicalTo: localTheme.

	space deferAndSettle: [ win close ].
	self assert: win localTheme identicalTo: localTheme.
]

{ #category : #tests }
ToAnchoredWindowTest >> testManager [

	| win e windowManager |
	win := ToAnchoredWindow new.
	self assert: win manager isNil.
	self should: [ win popup ] raise: Error.
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win manager identicalTo: windowManager
]

{ #category : #tests }
ToAnchoredWindowTest >> testOnOpened [

	| win e windowManager openedEventReceivedByWin openedEventReceivedByElement |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEventReceivedByWin := event ]).
	e addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEventReceivedByElement := event ]).

	space deferAndSettle: [ win popup ].
	self assert: openedEventReceivedByWin notNil.
	self assert: openedEventReceivedByElement notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testOpenedEventClass [

	| win windowManager e openedEvent |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEvent := event ]).
	self assert: openedEvent isNil.

	space deferAndSettle: [ win popup ].
	" need to wait space pulsing "
	self assert: openedEvent notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopup [

	| win e windowManager |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.

	space deferAndSettle: [ win popup ].
	self assert: win isOpened.
	self assert: win parent notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupEvent [

	| win e windowManager openedEvent sourceEvent |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new.
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEvent := event ]).
	space deferAndSettle: [
		win popupEvent: nil .
		win close ].
	sourceEvent := BlEvent new.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: ToOpenedEvent
			 do: [ :event | openedEvent := event ]).
	space deferAndSettle: [ win popupEvent: sourceEvent ].
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
	win addEventHandlerOn: ToOpenedEvent
			do: [ :event | openEventFromWindow := event ].
	e addEventHandlerOn: ToOpenedEvent
			do: [ :event | openEventFromWidget := event ].
	win addEventHandlerOn: ToClosedEvent
			do: [ :event | closeEventFromWindow := event ].
	e addEventHandlerOn: ToClosedEvent
			do: [ :event | closeEventFromWidget := event ].
	self should: [ win popup ] raise: Error.
	self assert: win isOpened not.
	self assert: openEventFromWindow isNil.
	self assert: openEventFromWidget isNil.

	space deferAndSettle: [
		space root addChild: e .
		win popup .
		win close ].
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
	self should: [ win popup ] raise: Error.
	self assert: win isOpened not.
	self assert: win isClosed
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupEventWithoutElement [

	| w |
	w := ToAnchoredWindow new.
	self deny: w hasManager.
	self should: [ w popup ] raise: Error
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupTimestamp [

	| win windowManager e openedEvent timeStamp |
	e := ToElement new.
	space deferAndSettle: [ space root addChild: e ].

	windowManager :=
		ToAnchoredWindowManagerForTest new
			windowBuilder: [ :anchWin :element | ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	win addEventHandlerOn: ToOpenedEvent
			 do: [ :event | openedEvent := event ].
	self assert: openedEvent isNil.
	self assert: win popupTimestamp isNil.

	space deferAndSettle: [ win popup ].
	self assert: win popupTimestamp notNil.
	timeStamp := win popupTimestamp.
	self assert: win popupTimestamp <= DateAndTime now.
	self assert: win isOpened.
	self assert: win isClosed not.

	space deferAndSettle: [ win close ].
	self assert: win popupTimestamp equals: timeStamp.
	self assert: win isOpened not.
	self assert: win isClosed
]

{ #category : #tests }
ToAnchoredWindowTest >> testValueOfTokenNamedInWindow [

	| win e windowManager lab notFoundDispatched |
	e := ToElement new.
	e localTheme: ToRawThemeForTest new.
	space deferAndSettle: [ space root addChild: e ].
	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
			                 :anchWin
			                 :requestEvent |
			                 lab := ToLabel new text: 'H'.
			                 anchWin root addChild: lab ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.

	space deferAndSettle: [ win popupEvent: nil ].
	self
		assert: (e valueOfTokenNamed: #'test-background-color')
		equals: Color white.
	self assert: lab notNil.
	self assert: lab lookupTheme identicalTo: win lookupTheme.
	self
		assert: (lab valueOfTokenNamed: #'test-background-color')
		equals: Color white.

	space deferAndSettle: [ win close ].
	self
		assert: (e valueOfTokenNamed: #'test-background-color')
		equals: Color white.
	" here the lab is no more attached. the last installed theme is used 
	(see BlElement>>valueOfTokenNamed:)"
	notFoundDispatched := false.
	lab
		addEventHandlerOn: ToTokenPropertyNotFoundEvent
		do: [ notFoundDispatched := true ].
	notFoundDispatched := false.
	self
		assert: (lab valueOfTokenNamed: #'background-color')
		equals: (space root valueOfTokenNamed: #'background-color').
	self assert: notFoundDispatched.
	" now the #'test-background-color' token is nbot accessible at all 
	because it is not defined by the last installed theme "
	notFoundDispatched := false.
	self
		should: [ lab valueOfTokenNamed: #'test-background-color' ]
		raise: ToTokenPropertyNotFoundError.
	self assert: notFoundDispatched
]

{ #category : #tests }
ToAnchoredWindowTest >> testWindowSize [
	" since there is no size hook by default, the window is fitContent by default"

	| win e windowManager |
	e := ToElement new.
	e position: 10 asPoint.
	e extent: 10 asPoint.
	space deferAndSettle: [ space root addChild: e ].

	windowManager := ToAnchoredWindowManagerForTest new windowBuilder: [
		                 :anchWin
		                 :element |  ].
	e addEventHandler: windowManager.
	win := windowManager createNewWindowOnEvent: nil.
	self assert: win constraints horizontal resizer isFitContent.
	self assert: win constraints vertical resizer isFitContent.
	self assert: win root constraints horizontal resizer isFitContent.
	self assert: win root constraints vertical resizer isFitContent.

	space deferAndSettle: [ win popup ].
	self assert: win constraints horizontal resizer isFitContent.
	self assert: win constraints vertical resizer isFitContent.
	self assert: win root constraints horizontal resizer isFitContent.
	self assert: win root constraints vertical resizer isFitContent.
	self assert: win bounds inSpace extent equals: 0 @ 0.
	self assert: win root bounds inSpace extent equals: 0 @ 0.

	space deferAndSettle: [ e position: 20 asPoint ].
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	self assert: win bounds inSpace extent equals: 0 @ 0
]
