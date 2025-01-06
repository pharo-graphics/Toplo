Class {
	#name : #ToAnchoredWindowManager,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'mode',
		'currentWindow',
		'element',
		'windowBuilder'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #modes }
ToAnchoredWindowManager class >> overlay [

	^ self new
		  placement: ToOverlayPlacement new;
		  yourself
]

{ #category : #accessing }
ToAnchoredWindowManager >> anchorRoot [

	" the root element in which the window is placed "
	^ mode anchorRoot 
]

{ #category : #accessing }
ToAnchoredWindowManager >> anchorRoot: anElement [

	" the root element in which the window is placed "
	mode anchorRoot: anElement
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager >> arrangeWindowOnEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	mode arrangeWindow: currentWindow onEvent: anEvent
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> beInline [

	self mode: self newInlineMode 
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> buildCurrentWindowFromRequest: aRequest [

	windowBuilder value: currentWindow value: aRequest
]

{ #category : #accessing }
ToAnchoredWindowManager >> builder [

	self
		deprecated: 'Use #windowBuilder'
		transformWith:
		'`@rcvr builder' -> '`@rcvr windowBuilder'.
		
	^ self windowBuilder
]

{ #category : #accessing }
ToAnchoredWindowManager >> builder: aWindowBuilderValuable [
	self
		deprecated: 'Use #windowBuilder:'
		transformWith:
		'`@rcvr builder: `@arg' -> '`@rcvr windowBuilder: `@arg'.
	self windowBuilder: aWindowBuilderValuable
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> closeWindow [

	currentWindow ifNil: [ ^ self ].
	currentWindow isOpened ifFalse: [ ^ self ].
	currentWindow close.
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> closedEvent: anEvent [

	" send from the window. Since I'm the only handler whatever the closed event, 
	I must be sure that the event is sent from my current window "

	currentWindow = anEvent window ifFalse: [ ^ self ].
	self onClosed
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
ToAnchoredWindowManager >> defaultBuilder [
	" return a valuable used to build the window. The window is passed as first argument and the argument is request event "

	^ [ :theWindow :theRequest | ]

	
]

{ #category : #initialization }
ToAnchoredWindowManager >> defaultMode [

	^ self newPopupMode 
]

{ #category : #initializing }
ToAnchoredWindowManager >> defaultPlacement [ 

	^ ToTopLeftDownPlacement new
]

{ #category : #accessing }
ToAnchoredWindowManager >> element [

	^ element
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> elementExtentChangedEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	mode arrangeWindow: currentWindow onEvent: nil
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> elementPositionInSpaceChangedEvent: anEvent [

	currentWindow ifNil: [ ^ self ].
	mode arrangeWindow: currentWindow onEvent: anEvent
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> elementRemovedFromParentEvent: anEvent [

	self currentWindowDo: [ :cw | cw isOpened ifTrue: [ cw close ] ]
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> elementRemovedFromSceneGraphEvent: anEvent [

	self currentWindowDo: [ :cw | cw close ]
]

{ #category : #'api - accessing' }
ToAnchoredWindowManager >> eventsToHandle [

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
	windowBuilder := self defaultBuilder.
	self initializeMode
]

{ #category : #initialization }
ToAnchoredWindowManager >> initializeMode [

	self mode: self defaultMode
]

{ #category : #accessing }
ToAnchoredWindowManager >> inlineWindowClass [

	^ ToInlineWindowElement 
]

{ #category : #testing }
ToAnchoredWindowManager >> isInline [ 

	^ mode isInline
]

{ #category : #accessing }
ToAnchoredWindowManager >> mode: aWindowMode [

	mode ifNotNil: [ mode onUninstalledIn: self ].
	mode := aWindowMode.
	mode onInstalledIn: self
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> newInlineMode [

	^ ToInlineWindowMode new
]

{ #category : #initialization }
ToAnchoredWindowManager >> newPopupMode [

	^ ToPopupWindowMode new
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> newWindow [

	^ self popupWindowClass new
		  manager: self;
		  yourself
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> newWindowEvent: anEvent [

	| request |
	currentWindow ifNotNil: [
		^ Error signal: 'Asking for a window building twice' ].
	self element ifNil: [
		^ Error signal: 'An element is required for building a window' ].
	self windowBuilder ifNil: [
		^ Error signal: 'A window builder is required for building a window' ].

	self element isEnabled ifFalse: [ ^ nil ].

	request := self newWindowRequestFrom: anEvent.

	" dispatch the event. handlers can eventually feed the event with additional data 
	that can be used by the builder "
	self element dispatchEvent: request.

	" the event is dispatched, eventually updated with additional data, 
	the current window can be created then built"
	currentWindow := mode newWindow.
	self buildCurrentWindowFromRequest: request.
	^ currentWindow
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> newWindowRequestFrom: anEvent [

	^ self windowRequestClass new
		  sourceEvent: anEvent;
		  yourself
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onClosed [

	currentWindow ifNil: [ ^ self ].
	currentWindow root removeChildren.
	currentWindow manager: nil.
	currentWindow := nil
]

{ #category : #'api - hooks' }
ToAnchoredWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	element := anElement
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onOpened [

]

{ #category : #'api - hooks' }
ToAnchoredWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	element := nil
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> openedEvent: anEvent [

	"self trace. ' openedEvent: ' trace. currentWindow trace. ' ' trace. anEvent window traceCr."
	" send from the window. Since I'm the only handler whatever the opened event, 
	I must be sure that the event is sent from my current window "
	currentWindow = anEvent window ifFalse: [ ^ self ].
	self onOpened
]

{ #category : #accessing }
ToAnchoredWindowManager >> placement: aPlacement [

	mode placement: aPlacement 
]

{ #category : #accessing }
ToAnchoredWindowManager >> popupWindowClass [

	^ ToAnchoredWindow 
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> startWindow: aWindow [ 

	mode startWindow: aWindow
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> stopWindow: aWindow [ 

	mode stopWindow: aWindow
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> themeInstalledEvent: anEvent [

	self withAllSubwindowsDo: [ :cw | cw toThemeInstalled ]
]

{ #category : #accessing }
ToAnchoredWindowManager >> windowBuilder [

	^ windowBuilder
]

{ #category : #accessing }
ToAnchoredWindowManager >> windowBuilder: aWindowBuilderValuable [

	windowBuilder := aWindowBuilderValuable
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
