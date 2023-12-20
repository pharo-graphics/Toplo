Class {
	#name : 'ToAnchoredWindowManager',
	#superclass : 'Object',
	#instVars : [
		'currentWindow',
		'element',
		'builder',
		'elementEventHandler',
		'windowClosedHandler',
		'positionHook',
		'widthHook',
		'heightHook'
	],
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'position hook' }
ToAnchoredWindowManager >> applyHeightHookFromEvent: anEvent [

	self currentWindow ifNil: [ Error signal: 'No current window' ].
	self heightHook ifNil: [ ^ self ].
	self currentWindow height: (self heightHook value: anEvent value: self element)
]

{ #category : 'position hook' }
ToAnchoredWindowManager >> applyPositionHookFromEvent: anEvent [

	self currentWindow ifNil: [ Error signal: 'No current window'. ].
	self currentWindow position: (self positionHook value: anEvent value: self element)
]

{ #category : 'position hook' }
ToAnchoredWindowManager >> applyWidthHookFromEvent: anEvent [

	self currentWindow ifNil: [ Error signal: 'No current window' ].
	self widthHook ifNil: [ ^ self ].
	self currentWindow width: (self widthHook value: anEvent value: self element)
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> builder [

	^ builder
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> builder: aWindowBuilderValuable [

	builder := aWindowBuilderValuable
]

{ #category : 'window handling' }
ToAnchoredWindowManager >> closeWindow [

	self currentWindow ifNil: [ ^ self ].
	self currentWindow close
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> currentWindow [

	^ currentWindow
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> currentWindow: aWindowElement [

	currentWindow := aWindowElement
]

{ #category : 'initialization' }
ToAnchoredWindowManager >> defaultBuilder [
	" return a valuable used to build the window. The window is passed as first argument and the argument is request event "

	^ [ :theWindow :theRequest | ]

	
]

{ #category : 'initialization' }
ToAnchoredWindowManager >> defaultHeightHook [

	^ nil
]

{ #category : 'initialization' }
ToAnchoredWindowManager >> defaultPositionHook [

	^ [ :event :theElement| theElement bounds inSpace bounds topLeft ]
]

{ #category : 'initialization' }
ToAnchoredWindowManager >> defaultWidthHook [

	^ nil
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> element [

	^ element
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> element: anElement [

	element ifNotNil: [
		element removeEventHandler: elementEventHandler.
		elementEventHandler := nil ].
	element := anElement.
	element ifNotNil: [
		element addEventHandler: self newElementEventHandler ]
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> elementEventHandler [

	^ elementEventHandler
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> elementEventHandlerClass [

	^ ToAnchorEventHandler 
]

{ #category : 'testing' }
ToAnchoredWindowManager >> hasWindow [

	^ self currentWindow notNil
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> heightHook [
	
	^ heightHook
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> heightHook: aValuable [
	
	heightHook := aValuable.
	self currentWindow ifNil: [  ^self ].
	self applyHeightHookFromEvent: nil
]

{ #category : 'initialization' }
ToAnchoredWindowManager >> initialize [ 

	super initialize.
	self positionHook: self defaultPositionHook.
	self heightHook: self defaultHeightHook.
	self widthHook: self defaultWidthHook.
	self builder: self defaultBuilder.

	
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> newElementEventHandler [

	elementEventHandler := self elementEventHandlerClass new.
	elementEventHandler windowManager: self.
	^ elementEventHandler
]

{ #category : 'window handling' }
ToAnchoredWindowManager >> newWindowEvent: anEvent [

	| request |
	self currentWindow ifNotNil: [
		^ Error signal: 'Asking for a window building twice' ].
	self element ifNil: [ ^ Error signal: 'An element is required for building a window' ].
	self builder ifNil: [ ^ Error signal: 'A window builder is required for building a window' ].
	request := self windowRequestClass new
		           sourceEvent: anEvent;
		           yourself.
	self element dispatchEvent: request.
	self currentWindow: (self windowClass new
			 manager: self;
			 yourself).
	builder value: self currentWindow value: request.
	windowClosedHandler := BlEventHandler
		                       on: ToWindowClosedEvent
		                       do: [ self onWindowClosed ].
	self currentWindow addEventHandler: windowClosedHandler.
	^ self currentWindow
]

{ #category : 'window handling' }
ToAnchoredWindowManager >> onWindowClosed [

	self currentWindow removeEventHandler: windowClosedHandler.
	windowClosedHandler := nil.
	currentWindow manager: nil.
	currentWindow := nil
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> positionHook [

	^ positionHook
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> positionHook: aValuable [
	" aValuable takes the event as first argument and the element as second argument. 
	Computes the window position according to the element position "
	
	positionHook := aValuable.
	self currentWindow ifNil: [ ^ self ].
	self applyPositionHookFromEvent: nil
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> sizeHook [
	
	^ nil
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> widthHook [
	
	^ widthHook
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> widthHook: aValuable [
	
	widthHook := aValuable.
	self currentWindow ifNil: [  ^self ].
	self applyWidthHookFromEvent: nil
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> windowClass [

	^ ToAnchoredWindow 
]

{ #category : 'accessing' }
ToAnchoredWindowManager >> windowRequestClass [

	^ ToWindowRequest 
]
