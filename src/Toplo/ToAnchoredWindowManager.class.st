Class {
	#name : #ToAnchoredWindowManager,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'currentWindow',
		'windowBuilder',
		'anchorElement',
		'anchorRoot',
		'placement',
		'measurement',
		'windowStarter',
		'minDelayAfterOpening'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #modes }
ToAnchoredWindowManager class >> overlay [

	^ self new
		  placement: ToAnchoredTopLeftDownPlacement new;
		  measurement: ToOverlayMeasurement new;
		  yourself
]

{ #category : #accessing }
ToAnchoredWindowManager >> anchorElement [

	^ anchorElement
]

{ #category : #accessing }
ToAnchoredWindowManager >> anchorRoot [

	" the root element in which the window is placed "
	^ anchorRoot ifNil: [ anchorRoot := anchorElement space root ]
]

{ #category : #accessing }
ToAnchoredWindowManager >> anchorRoot: anElement [

	" the root element in which the window is placed "
	anchorRoot := anElement
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> closeWindow [

	self closeWindowOnEvent: nil
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> closeWindowOnEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	currentWindow isOpened ifFalse: [ ^ self ].
	currentWindow close.
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> closedEvent: anEvent [

	" send from the window. Since I'm the only handler whatever the closed event, 
	I must be sure that the event is sent from my current window "

	currentWindow = anEvent window ifFalse: [ ^ self ].
	self onWindowClosedOnEvent: anEvent
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> createNewWindowOnEvent: anEvent [

	| request |
	currentWindow ifNotNil: [
		^ Error signal: 'Asking for a window building twice' ].
	self anchorElement ifNil: [
		^ Error signal: 'An element is required for building a window' ].
	self windowBuilder ifNil: [
		^ Error signal: 'A window builder is required for building a window' ].

	request := self newWindowRequestOnEvent: anEvent.

	" dispatch the event. handlers can eventually feed the event with additional data 
	that can be used by the builder "
	self anchorElement dispatchEvent: request.

	" the event is dispatched, eventually updated with additional data, 
	the current window can be created then built"
	currentWindow := self newWindow.
	" use the accessor because it is lazy "
	self windowBuilder value: currentWindow value: request.
	^ currentWindow
]

{ #category : #accessing }
ToAnchoredWindowManager >> currentWindow [

	^ currentWindow
]

{ #category : #accessing }
ToAnchoredWindowManager >> currentWindowDo: aValuable [

	currentWindow ifNotNil: [ :cw | aValuable value: cw ]
]

{ #category : #initialization }
ToAnchoredWindowManager >> defaultMeasurement [

	^ ToNoCustomMeasurement new
]

{ #category : #initialization }
ToAnchoredWindowManager >> defaultPlacement [ 

	^ ToAnchoredTopLeftDownPlacement new
]

{ #category : #initialization }
ToAnchoredWindowManager >> defaultWindowBuilder [
	" return a valuable used to build the window. The window is passed as first argument and the argument is request event "

	^ [ :theWindow :theRequest | ]

	
]

{ #category : #accessing }
ToAnchoredWindowManager >> defaultWindowClass [

	^ ToAnchoredWindow 
]

{ #category : #initialization }
ToAnchoredWindowManager >> defaultWindowStarter [

	^ ToStandardWindowStarter new
]

{ #category : #accessing }
ToAnchoredWindowManager >> element [

	self deprecated: 'Use #anchorElement instead' transformWith: '`@rcvr element'->'`@rcvr anchorElement'.
	^ self anchorElement
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> elementExtentChangedEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	currentWindow refreshLayout
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> elementPositionInSpaceChangedEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	currentWindow refreshLayout
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> elementRemovedFromParentEvent: anEvent [

	self currentWindowDo: [ :cw | cw isOpened ifTrue: [ cw close ] ]
]

{ #category : #'api - accessing' }
ToAnchoredWindowManager >> eventsToHandle [

	^ {
		  ToWindowRequest.
		  ToOpenedClosedEvent.
		  BlElementExtentChangedEvent.
		  BlElementRemovedFromParentEvent.
		  ToRemovedFromSpaceEvent.
		  BlElementPositionInSpaceChangedEvent.
		  ToThemeInstalledEvent }
]

{ #category : #'api - event managing' }
ToAnchoredWindowManager >> handleEvent: anEvent [

	anEvent sendToWindowManager: self
]

{ #category : #testing }
ToAnchoredWindowManager >> hasWindow [

	^ currentWindow notNil
]

{ #category : #initialization }
ToAnchoredWindowManager >> initialize [

	super initialize.
	minDelayAfterOpening := 300 milliSeconds.
	windowBuilder := self defaultWindowBuilder.
	windowStarter := self defaultWindowStarter
]

{ #category : #testing }
ToAnchoredWindowManager >> isInline [ 

	self
		deprecated: 'Use #hasInlineWindow instead'
		transformWith: '`@rcvr isInline' -> '`@rcvr hasInlineWindow'.
	^ self hasInlineWindow
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> isMinimumDelayExceededAfter: aTimeStamp [

	| delay |
	currentWindow ifNil: [ ^ true ].
	aTimeStamp ifNil: [ ^ true ].
	" check a minimum delay between opening and closing - 
	useful to not close immediately context menu on mouse up"
	delay := aTimeStamp - currentWindow popupTimestamp.
	^ delay > minDelayAfterOpening
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> isMinimumDelayExceededOnEvent: anEvent [

	^ self isMinimumDelayExceededAfter: anEvent timestamp
]

{ #category : #accessing }
ToAnchoredWindowManager >> measurement [

	^ measurement ifNil: [ measurement := self defaultMeasurement ]
]

{ #category : #accessing }
ToAnchoredWindowManager >> measurement: aMeasurement [

	measurement := aMeasurement 
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> newWindow [

	^ self windowClass new
		  manager: self;
		  yourself
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> newWindowRequestOnEvent: anEvent [

	^ self windowRequestClass new
		  sourceEvent: anEvent;
		  yourself
]

{ #category : #'api - hooks' }
ToAnchoredWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anchorElement := anElement
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onMeasure: anExtentMeasurementSpec onEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	self measurement
		onMeasure: anExtentMeasurementSpec
		element: currentWindow
		onEvent: anEvent
]

{ #category : #'api - hooks' }
ToAnchoredWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anchorElement := nil
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onWindowClosedOnEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	currentWindow root removeChildren.
	currentWindow manager: nil.
	currentWindow := nil
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onWindowOpenedOnEvent: anEvent [

]

{ #category : #'event handling' }
ToAnchoredWindowManager >> openedEvent: anEvent [

	"self trace. ' openedEvent: ' trace. currentWindow trace. ' ' trace. anEvent window traceCr."
	" send from the window. Since I'm the only handler whatever the opened event, 
	I must be sure that the event is sent from my current window "
	currentWindow = anEvent window ifFalse: [ ^ self ].
	self onWindowOpenedOnEvent: anEvent
]

{ #category : #accessing }
ToAnchoredWindowManager >> placement [

	^ placement ifNil: [ placement := self defaultPlacement ]
]

{ #category : #accessing }
ToAnchoredWindowManager >> placement: aPlacement [

	placement := aPlacement
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> positionWindowOnEvent: anEvent context: aBlElementBoundsUpdateContext [

	currentWindow ifNil: [ ^ self ].
	self placement
		positionElement: currentWindow
		onEvent: anEvent
		context: aBlElementBoundsUpdateContext
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> removedFromSpaceEvent: anEvent [

	self currentWindowDo: [ :cw | cw isOpened ifTrue: [ cw close ] ]
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> startWindow: aWindow [ 

	windowStarter startWindow: aWindow fromManager: self
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> stopWindow: aWindow [

	windowStarter stopWindow: aWindow fromManager: self
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> themeInstalledEvent: anEvent [

	self withAllSubwindowsDo: [ :cw | cw toThemeInstalled ]
]

{ #category : #accessing }
ToAnchoredWindowManager >> windowBuilder [
	" return a valuable used to build the window. The window is passed as first argument and the argument is request event "

	^ windowBuilder ifNil: [ windowBuilder := self defaultWindowBuilder ]
]

{ #category : #accessing }
ToAnchoredWindowManager >> windowBuilder: aWindowBuilderValuable [
	" a valuable with the window as first argument and a request event as second argument "

	windowBuilder := aWindowBuilderValuable
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> windowClass [ 

	^ windowStarter windowClassFromManager: self
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> windowRequest: anEvent [
]

{ #category : #accessing }
ToAnchoredWindowManager >> windowRequestClass [

	^ ToWindowRequest 
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> withAllSubwindowsDo: aBlock [

	self currentWindowDo: [ :cw |
		cw withAllSubwindowsDo: aBlock ]
]
