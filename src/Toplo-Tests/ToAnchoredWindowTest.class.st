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

	windowManager := ToAnchoredWindowManager new builder: [
		                 :anchWin
		                 :element | anchWin root addChild: winRootChild ].
	windowManager onInstalledIn: e.
	win := windowManager newWindowEvent: nil.
	self assert: winRootChild parent identicalTo: win root.
	self deny: win isOpened.
	" not opened, try to close -> Error "
	self should: [ win close ] raise: Error.
	windowManager removeWindow.
	self assert: winRootChild parent isNil.
	" but after it has been closed, it can't be opened anymore "
	self should: [ win popup ] raise: Error
]

{ #category : #tests }
ToAnchoredWindowTest >> testClosedEventClass [

	| win windowManager e closeEvent |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManager new builder: [
		                 :anchWin
		                 :element |  ].
	windowManager onInstalledIn: e.
	win := windowManager newWindowEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: win closedEventClass
			 do: [ :event | closeEvent := event ]).
	self assert: closeEvent isNil.
	win popup.
	win close.
	" need to wait space pulsing "
	self waitTestingSpaces.
	self assert: closeEvent notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testDefaultElevation [

	| win e windowHandler |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowManager new builder: [
		                 :anchWin
		                 :element |  ].
	windowHandler onInstalledIn: e.
	win := windowHandler newWindowEvent: nil.
	e position: 10 asPoint.
	e size: 10 asPoint.
	win popup.
	self
		assert: win elevation elevation
		equals: win defaultElevation elevation
]

{ #category : #tests }
ToAnchoredWindowTest >> testDispatchClosedEvent [

	| win e windowHandler closedEventReceivedByWin closedEventReceivedByElement |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.

	windowHandler := ToAnchoredWindowManager new.
	windowHandler onInstalledIn: e.
	win := windowHandler newWindowEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: win closedEventClass
			 do: [ :event | closedEventReceivedByWin := event ]).
	e addEventHandler: (BlEventHandler
			 on: win closedEventClass
			 do: [ :event | closedEventReceivedByElement := event ]).
	win popup.
	win close.
	self waitTestingSpaces.
	self assert: closedEventReceivedByWin notNil.
	self assert: closedEventReceivedByElement notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testDispatchOpenedEvent [

	| win e windowHandler openedEventReceivedByWin openedEventReceivedByElement |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.

	windowHandler := ToAnchoredWindowManager new.
	windowHandler onInstalledIn: e.
	win := windowHandler newWindowEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: win openedEventClass
			 do: [ :event | openedEventReceivedByWin := event ]).
	e addEventHandler: (BlEventHandler
			 on: win openedEventClass
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
	self assert: win element isNil.
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManager new.
	windowManager onInstalledIn: e.
	win := windowManager newWindowEvent: nil.
	self assert: win element identicalTo: e
]

{ #category : #tests }
ToAnchoredWindowTest >> testHasAssociateElement [

	| win e windowManager |
	win := ToAnchoredWindow new.
	self deny: win hasAssociateElement.
	self should: [ win popup ] raise: Error.
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.

	windowManager := ToAnchoredWindowManager new.
	windowManager onInstalledIn: e.
	win := windowManager newWindowEvent: nil.
	self assert: win hasAssociateElement
]

{ #category : #tests }
ToAnchoredWindowTest >> testLocalThemeSetOnPopupEvent [

	| win e windowHandler |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.

	windowHandler := ToAnchoredWindowManager new.
	windowHandler onInstalledIn: e.
	win := windowHandler newWindowEvent: nil.
	self assert: win localTheme isNil.
	win popupEvent: nil.
	self waitTestingSpaces.
	self assert: win localTheme identicalTo: e toTheme.
	win close.
	self waitTestingSpaces.
	self assert: win localTheme identicalTo: e toTheme.
]

{ #category : #tests }
ToAnchoredWindowTest >> testLocalThemeSetOnPopupEvent2 [

	| win e windowHandler localTheme |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.

	windowHandler := ToAnchoredWindowManager new.
	windowHandler onInstalledIn: e.
	win := windowHandler newWindowEvent: nil.
	self assert: win localTheme isNil.
	localTheme := ToRawDarkTheme new.
	win localTheme: localTheme.
	win popupEvent: nil.
	self waitTestingSpaces.
	self assert: win localTheme identicalTo: localTheme.
	win close.
	self waitTestingSpaces.
	self assert: win localTheme identicalTo: localTheme.
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

	windowManager := ToAnchoredWindowManager new.
	windowManager onInstalledIn: e.
	win := windowManager newWindowEvent: nil.
	self assert: win manager identicalTo: windowManager
]

{ #category : #tests }
ToAnchoredWindowTest >> testOpenedEventClass [

	| win windowManager e openedEvent |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManager new builder: [
		                 :anchWin
		                 :element |  ].
	windowManager onInstalledIn: e.
	win := windowManager newWindowEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: win openedEventClass
			 do: [ :event | openedEvent := event ]).
	self assert: openedEvent isNil.
	win popup.
	" need to wait space pulsing "
	self waitTestingSpaces.
	self assert: openedEvent notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopup [

	| win e windowHandler |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.

	windowHandler := ToAnchoredWindowManager new.
	windowHandler onInstalledIn: e.
	win := windowHandler newWindowEvent: nil.
	win popup.
	self assert: win isOpened.
	self assert: win parent notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupEvent [

	| win e windowHandler openedEvent sourceEvent |
	e := ToElement new.
	space root addChild: e.
	self waitTestingSpaces.
	self applyAllEnqueuedStates.

	windowHandler := ToAnchoredWindowManager new.
	windowHandler onInstalledIn: e.
	win := windowHandler newWindowEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: win openedEventClass
			 do: [ :event | openedEvent := event ]).
	win popupEvent: nil.
	self waitTestingSpaces.
	self assert: openedEvent sourceEvent isNil.
	win close.
	sourceEvent := BlEvent new.
	win := windowHandler newWindowEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: win openedEventClass
			 do: [ :event | openedEvent := event ]).
	win popupEvent: sourceEvent.
	self waitTestingSpaces.
	self assert: openedEvent sourceEvent identicalTo: sourceEvent
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupEventNotInSpace [

	| win e openEventFromWindow openEventFromWidget closeEventFromWindow closeEventFromWidget windowHandler |
	e := ToElement new.
	windowHandler := ToAnchoredWindowManager new builder: [
		                 :anchWin
		                 :element |  ].
	windowHandler onInstalledIn: e.
	win := windowHandler newWindowEvent: nil.
	self assert: win hasAssociateElement.
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

	self should: [ win popup ] raise: Error.
	self assert: win isOpened not.
	self assert: openEventFromWindow isNil.
	self assert: openEventFromWidget isNil.
	space root addChild: e.
	win popup.
	win close.
	self assert: closeEventFromWindow notNil.
	self assert: closeEventFromWidget notNil
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupEventNotInSpace2 [

	| win e windowHandler |
	e := ToElement new.
	windowHandler := ToAnchoredWindowManager new builder: [
		                 :anchWin
		                 :element |  ].
	windowHandler onInstalledIn: e.
	win := windowHandler newWindowEvent: nil.
	self waitTestingSpaces.
	self should: [ win popup ] raise: Error.
	self assert: win isOpened not.
	self assert: win isClosed
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupEventWithoutElement [

	| w |
	w := ToAnchoredWindow new.
	self assert: w hasAssociateElement not.
	self should: [ w popup ] raise: Error
]

{ #category : #tests }
ToAnchoredWindowTest >> testPopupTimeStamp [

	| win windowManager e openedEvent timeStamp |
	e := ToElement new.
	space root addChild: e.
	windowManager := ToAnchoredWindowManager new builder: [
		                 :anchWin
		                 :element |  ].
	windowManager onInstalledIn: e.
	win := windowManager newWindowEvent: nil.
	win addEventHandler: (BlEventHandler
			 on: win openedEventClass
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
ToAnchoredWindowTest >> testWindowSize [
	" since there is no size hook by default, the window is fitContent by default"

	| win e windowHandler |
	e := ToElement new.
	space root addChild: e.
	e position: 10 asPoint.
	e size: 10 asPoint.
	self waitTestingSpaces.

	windowHandler := ToAnchoredWindowManager new builder: [
		                 :anchWin
		                 :element |  ].
	windowHandler onInstalledIn: e.
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
	self assert: win bounds inSpace extent equals: 0 @ 0.
	self assert: win root bounds inSpace extent equals: 0 @ 0.
	e position: 20 asPoint.
	self waitTestingSpaces.
	self
		assert: win bounds inSpace bounds origin
		equals: e bounds inSpace bounds origin.
	self assert: win bounds inSpace extent equals: 0 @ 0
]
