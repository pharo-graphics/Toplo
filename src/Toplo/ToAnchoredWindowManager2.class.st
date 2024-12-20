Class {
	#name : #ToAnchoredWindowManager2,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'openingStrategy',
		'currentWindow',
		'element',
		'windowBuilder'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #modes }
ToAnchoredWindowManager2 class >> anchored [ 

	^ self new 
]

{ #category : #modes }
ToAnchoredWindowManager2 class >> overlay [ 

	^ self new openingStrategy: ToOverlayWindowStrategy new
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> anchorRoot [

	^ openingStrategy anchorRoot
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> anchorRoot: anElement [

	openingStrategy anchorRoot: anElement
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager2 >> applyHeightHookFromEvent: anEvent [

	openingStrategy heightHook ifNil: [ ^ self ].
	currentWindow ifNil: [ Error signal: 'No current window' ].
	currentWindow height: (openingStrategy heightHook value: currentWindow value: self element value: anEvent)
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager2 >> applyPositionAnsSizeHooksFromEvent: anEvent [

	currentWindow ifNil: [ Error signal: 'No current window' ].
	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager2 >> applyPositionHookFromEvent: anEvent [

	currentWindow ifNil: [ Error signal: 'No current window' ].
	openingStrategy positionHook ifNil: [ ^ self ].
	currentWindow position: (openingStrategy positionHook value: currentWindow value: element value: anEvent).

]

{ #category : #'bounds hook' }
ToAnchoredWindowManager2 >> applySizeHookFromEvent: anEvent [

	(openingStrategy widthHook notNil and: [openingStrategy heightHook notNil ]) ifTrue: [
		| w h |
		currentWindow ifNil: [ Error signal: 'No current window' ].
		w := openingStrategy widthHook
			     value: currentWindow
			     value: self element
			     value: anEvent.
		h := openingStrategy heightHook
			     value: currentWindow
			     value: self element
			     value: anEvent.
		currentWindow size: w @ h.
		^ self ].
	self applyWidthHookFromEvent: anEvent.
	self applyHeightHookFromEvent: anEvent
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager2 >> applyWidthHookFromEvent: anEvent [

	openingStrategy widthHook ifNil: [ ^ self ].
	currentWindow ifNil: [ Error signal: 'No current window' ].

	currentWindow width: (openingStrategy widthHook value: currentWindow value: self element value: anEvent)
]

{ #category : #'window handling' }
ToAnchoredWindowManager2 >> buildCurrentWindowFromRequest: aRequest [

	windowBuilder value: currentWindow value: aRequest
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> builder [

	self
		deprecated: 'Use #windowBuilder'
		transformWith:
		'`@rcvr builder' -> '`@rcvr windowBuilder'.
		
	^ self windowBuilder
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> builder: aWindowBuilderValuable [
	self
		deprecated: 'Use #windowBuilder:'
		transformWith:
		'`@rcvr builder: `@arg' -> '`@rcvr windowBuilder: `@arg'.
	self windowBuilder: aWindowBuilderValuable
]

{ #category : #'window handling' }
ToAnchoredWindowManager2 >> closeWindow [

	currentWindow ifNil: [ ^ self ].
	currentWindow isOpened ifFalse: [ ^ self ].
	currentWindow close.
]

{ #category : #'event handling' }
ToAnchoredWindowManager2 >> closedEvent: anEvent [

	" send from the window. Since I'm the only handler whatever the closed event, 
	I must be sure that the event is sent from my current window "

	currentWindow = anEvent window ifFalse: [ ^ self ].
	self onClosed
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> currentWindow [

	^ currentWindow
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> currentWindowDo: aValuable [

	currentWindow ifNotNil: [ :cw | aValuable value: cw ]
]

{ #category : #initialization }
ToAnchoredWindowManager2 >> defaultBuilder [
	" return a valuable used to build the window. The window is passed as first argument and the argument is request event "

	^ [ :theWindow :theRequest | ]

	
]

{ #category : #initialization }
ToAnchoredWindowManager2 >> defaultOpeningStrategy [

	^ ToAnchoredWindowStrategy new
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> element [

	^ element
]

{ #category : #'event handling' }
ToAnchoredWindowManager2 >> elementExtentChangedEvent: anEvent [

	self applySizeHookFromEvent: anEvent
]

{ #category : #'event handling' }
ToAnchoredWindowManager2 >> elementPositionInSpaceChangedEvent: anEvent [

	self currentWindowDo: [ :w | w applyPositionHookFromEvent: anEvent ]
]

{ #category : #'event handling' }
ToAnchoredWindowManager2 >> elementRemovedFromParentEvent: anEvent [

	self currentWindowDo: [ :cw | cw close ]
]

{ #category : #'event handling' }
ToAnchoredWindowManager2 >> elementRemovedFromSceneGraphEvent: anEvent [

	self currentWindowDo: [ :cw | cw close ]
]

{ #category : #'api - accessing' }
ToAnchoredWindowManager2 >> eventsToHandle [

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
ToAnchoredWindowManager2 >> handleEvent: anEvent [

	anEvent sendToWindowManager: self
]

{ #category : #testing }
ToAnchoredWindowManager2 >> hasWindow [

	^ currentWindow notNil
]

{ #category : #initialization }
ToAnchoredWindowManager2 >> initialize [

	super initialize.
	openingStrategy := self defaultOpeningStrategy.
	windowBuilder := self defaultBuilder
]

{ #category : #'window handling' }
ToAnchoredWindowManager2 >> newWindow [

	^ self windowClass new
		  manager: self;
		  yourself
]

{ #category : #'window handling' }
ToAnchoredWindowManager2 >> newWindowEvent: anEvent [

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
	currentWindow := self newWindow.
	self buildCurrentWindowFromRequest: request.
	^ currentWindow
]

{ #category : #'window handling' }
ToAnchoredWindowManager2 >> newWindowRequestFrom: anEvent [

	^ self windowRequestClass new
		  sourceEvent: anEvent;
		  yourself
]

{ #category : #'window handling' }
ToAnchoredWindowManager2 >> onClosed [

	currentWindow ifNil: [ ^ self ].
	currentWindow root removeChildren.
	currentWindow manager: nil.
	currentWindow := nil
]

{ #category : #'api - hooks' }
ToAnchoredWindowManager2 >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	element := anElement.
	openingStrategy element: element
]

{ #category : #'window handling' }
ToAnchoredWindowManager2 >> onOpened [

]

{ #category : #'api - hooks' }
ToAnchoredWindowManager2 >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	openingStrategy := nil.
	element := nil
]

{ #category : #'event handling' }
ToAnchoredWindowManager2 >> openedEvent: anEvent [

	"self trace. ' openedEvent: ' trace. currentWindow trace. ' ' trace. anEvent window traceCr."
	" send from the window. Since I'm the only handler whatever the opened event, 
	I must be sure that the event is sent from my current window "
	currentWindow = anEvent window ifFalse: [ ^ self ].
	self onOpened
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> openingStrategy [

	^ openingStrategy 
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> openingStrategy: aWindowStrategy [

	openingStrategy := aWindowStrategy.
	openingStrategy element: element
]

{ #category : #'event handling' }
ToAnchoredWindowManager2 >> themeInstalledEvent: anEvent [

	self withAllSubwindowsDo: [ :cw | cw toThemeInstalled ]
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> windowBuilder [

	^ windowBuilder
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> windowBuilder: aWindowBuilderValuable [

	windowBuilder := aWindowBuilderValuable
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> windowClass [

	^ ToAnchoredWindow 
]

{ #category : #'event handling' }
ToAnchoredWindowManager2 >> windowRequest: anEvent [
]

{ #category : #accessing }
ToAnchoredWindowManager2 >> windowRequestClass [

	^ ToWindowRequest 
]

{ #category : #'event handling' }
ToAnchoredWindowManager2 >> withAllSubwindowsDo: aBlock [

	self currentWindowDo: [ :cw |
		cw withAllSubwindowsDo: [ :sw | sw toThemeInstalled ] ]
]
