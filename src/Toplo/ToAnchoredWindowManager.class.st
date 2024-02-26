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

{ #category : #accessing }
ToAnchoredWindowManager >> elementEventHandler [

	^ elementEventHandler
]

{ #category : #accessing }
ToAnchoredWindowManager >> elementEventHandlerClass [

	^ ToAnchorEventHandler 
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
	request := self windowRequestClass new
		           sourceEvent: anEvent;
		           yourself.
	self element dispatchEvent: request.
	self currentWindow: (self windowClass new
			 manager: self;
			 yourself).
	builder value: self currentWindow value: request.
	^ self currentWindow
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onCloseRequest [

	
]

{ #category : #accessing }
ToAnchoredWindowManager >> onInstalledIn: anElement [

	element := anElement.
	element ifNotNil: [
		element addEventHandler: self newElementEventHandler ]
]

{ #category : #accessing }
ToAnchoredWindowManager >> onUninstalledIn: anElement [

	element removeEventHandler: elementEventHandler.
	elementEventHandler := nil.
	element := nil
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onWindowClosed [

	self onWindowRemoved
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onWindowOpened [


]

{ #category : #'window handling' }
ToAnchoredWindowManager >> onWindowRemoved [

	self currentWindow root removeChildren.
	currentWindow manager: nil.
	currentWindow := nil
]

{ #category : #accessing }
ToAnchoredWindowManager >> positionHook [

	^ positionHook
]

{ #category : #accessing }
ToAnchoredWindowManager >> positionHook: aValuable [
	" aValuable takes the event as first argument and the element as second argument. 
	Computes the window position according to the element position "
	
	positionHook := aValuable.
	self currentWindow ifNil: [ ^ self ].
	self applyPositionHookFromEvent: nil
]

{ #category : #'window handling' }
ToAnchoredWindowManager >> removeWindow [

	self currentWindow ifNil: [ ^ self ].
	self currentWindow isOpened ifTrue: [ ^ self currentWindow close ].
	self onWindowRemoved
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

{ #category : #accessing }
ToAnchoredWindowManager >> windowRequestClass [

	^ ToWindowOpenRequest 
]
