Class {
	#name : #ToAnchoredWindowManager,
	#superclass : #Object,
	#instVars : [
		'anchorRoot',
		'currentWindow',
		'element',
		'builder',
		'elementEventHandler',
		'positionHook',
		'sizeHook'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindowManager >> anchorRoot [

	^ anchorRoot ifNil: [ anchorRoot := self element space root ]
]

{ #category : #accessing }
ToAnchoredWindowManager >> anchorRoot: anElement [

	anchorRoot := anElement
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager >> applyPositionAnsSizeHooksFromEvent: anEvent [

	self currentWindow ifNil: [ Error signal: 'No current window' ].
	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager >> applyPositionHookFromEvent: anEvent [

	self currentWindow ifNil: [ Error signal: 'No current window' ].
	self positionHook ifNil: [ ^ self ].
	self positionHook
		value: self currentWindow
		value: self element
		value: anEvent
]

{ #category : #'bounds hook' }
ToAnchoredWindowManager >> applySizeHookFromEvent: anEvent [

	self currentWindow ifNil: [ Error signal: 'No current window' ].
	self sizeHook ifNil: [ ^ self ].
	self sizeHook
			 value: self currentWindow
			 value: self element
			 value: anEvent
]

{ #category : #accessing }
ToAnchoredWindowManager >> builder [

	^ builder
]

{ #category : #accessing }
ToAnchoredWindowManager >> builder: aWindowBuilderValuable [

	builder := aWindowBuilderValuable
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> closeWindow [

	currentWindow ifNotNil: [
		currentWindow close.
		^ self ]
]

{ #category : #accessing }
ToAnchoredWindowManager >> currentWindow [

	^ currentWindow
]

{ #category : #accessing }
ToAnchoredWindowManager >> currentWindow: aWindowElement [

	currentWindow := aWindowElement
]

{ #category : #accessing }
ToAnchoredWindowManager >> currentWindowDo: aValuable [

	self currentWindow ifNotNil: [ :cw | aValuable value: cw ]
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
ToAnchoredWindowManager >> elementAddedToSceneGraphEvent: anEvent [


]

{ #category : #accessing }
ToAnchoredWindowManager >> elementEventHandler [

	^ elementEventHandler
]

{ #category : #accessing }
ToAnchoredWindowManager >> elementEventHandlerClass [

	^ ToAnchorEventHandler 
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

	self currentWindowDo: [ :w | w isOpened ifTrue: [ w close ] ]
]

{ #category : #testing }
ToAnchoredWindowManager >> hasWindow [

	^ self currentWindow notNil
]

{ #category : #initialization }
ToAnchoredWindowManager >> initialize [ 

	super initialize.
	self positionHook: self defaultPositionHook.
	self sizeHook: self defaultSizeHook.
	self builder: self defaultBuilder.

	
]

{ #category : #accessing }
ToAnchoredWindowManager >> newElementEventHandler [

	elementEventHandler := self elementEventHandlerClass new.
	elementEventHandler windowManager: self.
	^ elementEventHandler
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> newWindowEvent: anEvent [

	| request |
	self currentWindow ifNotNil: [
		^ Error signal: 'Asking for a window building twice' ].
	self element ifNil: [
		^ Error signal: 'An element is required for building a window' ].
	self builder ifNil: [
		^ Error signal: 'A window builder is required for building a window' ].
	
	self element isEnabled ifFalse: [ ^ self ].
	
	request := self newWindowOpenRequestEventFromSourceEvent: anEvent.
	
	" dispatch the event. handlers can eventually feed the event with additional data 
	that can be used by the builder "
	self element dispatchEvent: request.
	
	" the event is dispatched, eventually updated with additional data, 
	the widow can be created	then built"
	self currentWindow: (self windowClass new
			 manager: self;
			 yourself).
	builder value: self currentWindow value: request.
	^ self currentWindow
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> newWindowOpenRequestEventFromSourceEvent: anEvent [

	^ self windowOpenRequestClass new
]

{ #category : #'api - hooks' }
ToAnchoredWindowManager >> onInstalledIn: anElement [

	element := anElement.
	element ifNotNil: [
		element addEventHandler: self newElementEventHandler ]
]

{ #category : #'api - hooks' }
ToAnchoredWindowManager >> onUninstalledIn: anElement [

	element removeEventHandler: elementEventHandler.
	elementEventHandler := nil.
	element := nil
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onWindowClosed [

	self currentWindow ifNil: [ ^self ].
	self currentWindow root removeChildren.
	currentWindow manager: nil.
	currentWindow := nil
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onWindowOpened [


]

{ #category : #'window handling' }
ToAnchoredWindowManager >> popupWindowEvent: anEvent [

	(currentWindow notNil and: [ currentWindow isOpened ]) ifTrue: [
		^ self ].
	currentWindow ifNil: [ self newWindowEvent: anEvent ].
	" currentWindow can be nil in case the element is disabled "
	currentWindow ifNil: [ ^ self ].
	currentWindow popupEvent: anEvent
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

{ #category : #'window handling' }
ToAnchoredWindowManager >> removeWindow [

	self currentWindow ifNil: [ ^ self ].
	self currentWindow isOpened ifTrue: [ ^ self currentWindow close ].
	self onWindowClosed
]

{ #category : #accessing }
ToAnchoredWindowManager >> sizeHook [
	
	^ sizeHook
]

{ #category : #accessing }
ToAnchoredWindowManager >> sizeHook: aValuable [
	
	sizeHook := aValuable.
	self currentWindow ifNil: [ ^ self ].
	self applySizeHookFromEvent: nil
]

{ #category : #accessing }
ToAnchoredWindowManager >> windowClass [

	^ ToAnchoredWindow 
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> windowClosedEvent: anEvent [

	self onWindowClosed
]

{ #category : #accessing }
ToAnchoredWindowManager >> windowClosedEventClass [

	^ self subclassResponsibility  
]

{ #category : #accessing }
ToAnchoredWindowManager >> windowOpenRequestClass [

	^ ToAnchoredWindowOpenRequest 
]

{ #category : #'event handling' }
ToAnchoredWindowManager >> windowOpenedEvent: anEvent [

	self onWindowOpened 
]

{ #category : #accessing }
ToAnchoredWindowManager >> windowOpenedEventClass [

	^ self subclassResponsibility 
]
