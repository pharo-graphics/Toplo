Class {
	#name : #ToAnchoredElementManager,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'mode',
		'currentWindow',
		'windowBuilder',
		'anchorElement'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #modes }
ToAnchoredElementManager class >> overlay [

	^ self new
		  placement: ToAnchoredTopLeftDownPlacement new;
		  measurement: ToOverlayMeasurement new;
		  yourself
]

{ #category : #accessing }
ToAnchoredElementManager >> anchorElement [

	^ anchorElement
]

{ #category : #accessing }
ToAnchoredElementManager >> anchorRoot [

	" the root element in which the window is placed "
	^ mode anchorRoot 
]

{ #category : #accessing }
ToAnchoredElementManager >> anchorRoot: anElement [

	" the root element in which the window is placed "
	mode anchorRoot: anElement
]

{ #category : #'window handling' }
ToAnchoredElementManager >> beInline [

	self mode: self newInlineMode 
]

{ #category : #'window handling' }
ToAnchoredElementManager >> buildCurrentWindowFromRequest: aRequest [

	windowBuilder value: currentWindow value: aRequest
]

{ #category : #accessing }
ToAnchoredElementManager >> builder [

	self
		deprecated: 'Use #windowBuilder'
		transformWith:
		'`@rcvr builder' -> '`@rcvr windowBuilder'.
		
	^ self windowBuilder
]

{ #category : #accessing }
ToAnchoredElementManager >> builder: aWindowBuilderValuable [
	self
		deprecated: 'Use #windowBuilder:'
		transformWith:
		'`@rcvr builder: `@arg' -> '`@rcvr windowBuilder: `@arg'.
	self windowBuilder: aWindowBuilderValuable
]

{ #category : #'window handling' }
ToAnchoredElementManager >> closeWindow [

	currentWindow ifNil: [ ^ self ].
	currentWindow isOpened ifFalse: [ ^ self ].
	currentWindow close.
]

{ #category : #'event handling' }
ToAnchoredElementManager >> closedEvent: anEvent [

	" send from the window. Since I'm the only handler whatever the closed event, 
	I must be sure that the event is sent from my current window "

	currentWindow = anEvent window ifFalse: [ ^ self ].
	self onClosed
]

{ #category : #accessing }
ToAnchoredElementManager >> currentWindow [

	^ currentWindow
]

{ #category : #accessing }
ToAnchoredElementManager >> currentWindowDo: aValuable [

	currentWindow ifNotNil: [ :cw | aValuable value: cw ]
]

{ #category : #initialization }
ToAnchoredElementManager >> defaultBuilder [
	" return a valuable used to build the window. The window is passed as first argument and the argument is request event "

	^ [ :theWindow :theRequest | ]

	
]

{ #category : #initialization }
ToAnchoredElementManager >> defaultMeasurement [

	^ ToNoMeasurement new
]

{ #category : #initialization }
ToAnchoredElementManager >> defaultMode [

	^ self newPopupMode 
]

{ #category : #initialization }
ToAnchoredElementManager >> defaultPlacement [ 

	^ ToAnchoredTopLeftDownPlacement new
]

{ #category : #accessing }
ToAnchoredElementManager >> element [

	self deprecated: 'Use #anchorElement instead' transformWith: '`@rcvr element'->'`@rcvr anchorElement'.
	^ self anchorElement
]

{ #category : #'event handling' }
ToAnchoredElementManager >> elementExtentChangedEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	currentWindow refreshLayout
]

{ #category : #'event handling' }
ToAnchoredElementManager >> elementPositionInSpaceChangedEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	currentWindow refreshLayout
]

{ #category : #'event handling' }
ToAnchoredElementManager >> elementRemovedFromParentEvent: anEvent [

	self currentWindowDo: [ :cw | cw isOpened ifTrue: [ cw close ] ]
]

{ #category : #'event handling' }
ToAnchoredElementManager >> elementRemovedFromSceneGraphEvent: anEvent [

	self currentWindowDo: [ :cw | cw close ]
]

{ #category : #'api - accessing' }
ToAnchoredElementManager >> eventsToHandle [

	^ {
		  ToWindowRequest.
		  ToOpenedClosedEvent.
		  BlElementExtentChangedEvent.
		  BlElementRemovedFromParentEvent.
		  BlElementRemovedFromSceneGraphEvent.
		  BlElementPositionInSpaceChangedEvent.
		  ToThemeInstalledEvent }
]

{ #category : #'api - event managing' }
ToAnchoredElementManager >> handleEvent: anEvent [

	anEvent sendToWindowManager: self
]

{ #category : #testing }
ToAnchoredElementManager >> hasWindow [

	^ currentWindow notNil
]

{ #category : #initialization }
ToAnchoredElementManager >> initialize [

	super initialize.
	windowBuilder := self defaultBuilder.
	self initializeMode
]

{ #category : #initialization }
ToAnchoredElementManager >> initializeMode [

	self mode: self defaultMode
]

{ #category : #accessing }
ToAnchoredElementManager >> inlineWindowClass [

	^ ToInlineWindowElement 
]

{ #category : #testing }
ToAnchoredElementManager >> isInline [ 

	^ mode isInline
]

{ #category : #accessing }
ToAnchoredElementManager >> measurement: aMeasurement [

	mode measurement: aMeasurement 
]

{ #category : #accessing }
ToAnchoredElementManager >> mode: aWindowMode [

	mode ifNotNil: [ mode onUninstalledIn: self ].
	mode := aWindowMode.
	mode onInstalledIn: self
]

{ #category : #'window handling' }
ToAnchoredElementManager >> newInlineMode [

	^ ToInlineWindowMode new
]

{ #category : #initialization }
ToAnchoredElementManager >> newPopupMode [

	^ ToPopupWindowMode new
]

{ #category : #'window handling' }
ToAnchoredElementManager >> newWindow [

	^ self popupWindowClass new
		  manager: self;
		  yourself
]

{ #category : #'window handling' }
ToAnchoredElementManager >> newWindowEvent: anEvent [

	| request |
	currentWindow ifNotNil: [
		^ Error signal: 'Asking for a window building twice' ].
	self anchorElement ifNil: [
		^ Error signal: 'An element is required for building a window' ].
	self windowBuilder ifNil: [
		^ Error signal: 'A window builder is required for building a window' ].

	self anchorElement isEnabled ifFalse: [ ^ nil ].

	request := self newWindowRequestFrom: anEvent.

	" dispatch the event. handlers can eventually feed the event with additional data 
	that can be used by the builder "
	self anchorElement dispatchEvent: request.

	" the event is dispatched, eventually updated with additional data, 
	the current window can be created then built"
	currentWindow := mode newWindow.
	self buildCurrentWindowFromRequest: request.
	^ currentWindow
]

{ #category : #'window handling' }
ToAnchoredElementManager >> newWindowRequestFrom: anEvent [

	^ self windowRequestClass new
		  sourceEvent: anEvent;
		  yourself
]

{ #category : #'window handling' }
ToAnchoredElementManager >> onClosed [

	currentWindow ifNil: [ ^ self ].
	currentWindow root removeChildren.
	currentWindow manager: nil.
	currentWindow := nil
]

{ #category : #'api - hooks' }
ToAnchoredElementManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anchorElement := anElement
]

{ #category : #'window handling' }
ToAnchoredElementManager >> onMeasure: anExtentMeasurementSpec onEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	mode onMeasure: anExtentMeasurementSpec element: currentWindow onEvent: anEvent
]

{ #category : #'window handling' }
ToAnchoredElementManager >> onOpened [

]

{ #category : #'api - hooks' }
ToAnchoredElementManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anchorElement := nil
]

{ #category : #'event handling' }
ToAnchoredElementManager >> openedEvent: anEvent [

	"self trace. ' openedEvent: ' trace. currentWindow trace. ' ' trace. anEvent window traceCr."
	" send from the window. Since I'm the only handler whatever the opened event, 
	I must be sure that the event is sent from my current window "
	currentWindow = anEvent window ifFalse: [ ^ self ].
	self onOpened
]

{ #category : #accessing }
ToAnchoredElementManager >> placement: aPlacement [

	mode placement: aPlacement 
]

{ #category : #accessing }
ToAnchoredElementManager >> popupWindowClass [

	^ ToAnchoredWindow 
]

{ #category : #'window handling' }
ToAnchoredElementManager >> positionWindowOnEvent: anEvent context: aBlElementBoundsUpdateContext [

	currentWindow ifNil: [ ^ self ].
	mode
		positionElement: currentWindow
		onEvent: anEvent
		context: aBlElementBoundsUpdateContext
]

{ #category : #'window handling' }
ToAnchoredElementManager >> startWindow: aWindow [ 

	mode startWindow: aWindow
]

{ #category : #'window handling' }
ToAnchoredElementManager >> stopWindow: aWindow [ 

	mode stopWindow: aWindow
]

{ #category : #'event handling' }
ToAnchoredElementManager >> themeInstalledEvent: anEvent [

	self withAllSubwindowsDo: [ :cw | cw toThemeInstalled ]
]

{ #category : #accessing }
ToAnchoredElementManager >> windowBuilder [

	^ windowBuilder
]

{ #category : #accessing }
ToAnchoredElementManager >> windowBuilder: aWindowBuilderValuable [

	windowBuilder := aWindowBuilderValuable
]

{ #category : #'event handling' }
ToAnchoredElementManager >> windowRequest: anEvent [
]

{ #category : #accessing }
ToAnchoredElementManager >> windowRequestClass [

	^ ToWindowRequest 
]

{ #category : #'event handling' }
ToAnchoredElementManager >> withAllSubwindowsDo: aBlock [

	self currentWindowDo: [ :cw |
		cw withAllSubwindowsDo: aBlock ]
]
