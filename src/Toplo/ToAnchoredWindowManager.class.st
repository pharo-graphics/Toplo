Class {
	#name : #ToAnchoredWindowManager,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'anchorRoot',
		'currentWindow',
		'element',
		'positionHook',
		'sizeHook',
		'windowBuilder'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindowManager >> anchorRoot [

	^ anchorRoot ifNil: [ anchorRoot := element space root ]
]

{ #category : #accessing }
ToAnchoredWindowManager >> anchorRoot: anElement [

	anchorRoot := anElement
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager >> applyPositionAnsSizeHooksFromEvent: anEvent [

	currentWindow ifNil: [ Error signal: 'No current window' ].
	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager >> applyPositionHookFromEvent: anEvent [

	currentWindow ifNil: [ Error signal: 'No current window' ].
	self positionHook ifNil: [ ^ self ].
	self positionHook
		value: currentWindow
		value: self element
		value: anEvent
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager >> applySizeHookFromEvent: anEvent [

	currentWindow ifNil: [ Error signal: 'No current window' ].
	self sizeHook ifNil: [ ^ self ].
	self sizeHook
			 value: currentWindow
			 value: self element
			 value: anEvent
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
ToAnchoredWindowManager >> defaultPositionHook [

	^ [ :window :theElement :event |
	  window position:
		  (theElement bounds inParent: self anchorRoot) bounds topLeft ]
]

{ #category : #initialization }
ToAnchoredWindowManager >> defaultSizeHook [

	^ nil
]

{ #category : #accessing }
ToAnchoredWindowManager >> element [

	^ element
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> elementExtentChangedEvent: anEvent [
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> elementPositionInSpaceChangedEvent: anEvent [

	self currentWindowDo: [ :w | w applyPositionHookFromEvent: anEvent ]
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> elementRemovedFromParentEvent: anEvent [

	self currentWindowDo: [ :cw | cw close ]
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
	self positionHook: self defaultPositionHook.
	self sizeHook: self defaultSizeHook.
	self windowBuilder: self defaultBuilder
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> newWindow [

	^ self windowClass new
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

	self element isEnabled ifFalse: [ ^ self ].

	request := self newWindowRequestFrom: anEvent.

	" dispatch the event. handlers can eventually feed the event with additional data 
	that can be used by the builder "
	self element dispatchEvent: request.

	" the event is dispatched, eventually updated with additional data, 
	the current window can be created then built"
	currentWindow := self newWindow.
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

	" send from the window. Since I'm the only handler whatever the opened event, 
	I must be sure that the event is sent from my current window "
	currentWindow = anEvent window ifFalse: [ ^ self ].
	self onOpened
]

{ #category : #accessing }
ToAnchoredWindowManager >> positionHook [

	^ positionHook
]

{ #category : #accessing }
ToAnchoredWindowManager >> positionHook: aValuable [
	" aValuable takes the window as first argument, the element as second argument 
	and the event as third argument. 
	Computes the window position according to the element position "
	
	positionHook := aValuable
]

{ #category : #accessing }
ToAnchoredWindowManager >> sizeHook [
	
	^ sizeHook
]

{ #category : #accessing }
ToAnchoredWindowManager >> sizeHook: aValuable [
	
	sizeHook := aValuable.
	currentWindow ifNil: [ ^ self ].
	self applySizeHookFromEvent: nil
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

{ #category : #accessing }
ToAnchoredWindowManager >> windowClass [

	^ ToAnchoredWindow 
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
		cw withAllSubwindowsDo: [ :sw | sw toThemeInstalled ] ]
]
