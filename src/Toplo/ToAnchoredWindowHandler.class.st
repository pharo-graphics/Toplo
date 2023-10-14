Class {
	#name : 'ToAnchoredWindowHandler',
	#superclass : 'Object',
	#instVars : [
		'currentWindow',
		'element',
		'builder',
		'elementEventHandler',
		'windowClosedHandler',
		'positionHook',
		'sizeHook'
	],
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'position hook' }
ToAnchoredWindowHandler >> applyPositionHookFromEvent: anEvent [

	self currentWindow ifNil: [ ^ self ].
	self currentWindow position: (self positionHook value: anEvent)
]

{ #category : 'position hook' }
ToAnchoredWindowHandler >> applySizeHookFromEvent: anEvent [

	self currentWindow ifNil: [ ^ self ].
	self sizeHook ifNil: [ ^ self ].
	self currentWindow size: (self sizeHook value: anEvent)
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> builder [

	^ builder
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> builder: aWindowBuilderValuable [

	builder := aWindowBuilderValuable
]

{ #category : 'window handling' }
ToAnchoredWindowHandler >> closeWindow [

	currentWindow ifNil: [ ^ self ].
	currentWindow close
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> currentWindow [

	^ currentWindow
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> currentWindow: aWindowElement [

	currentWindow := aWindowElement
]

{ #category : 'initialization' }
ToAnchoredWindowHandler >> defaulPositionHook [

	^ [ :event | element bounds inSpace bounds topLeft ]
]

{ #category : 'initialization' }
ToAnchoredWindowHandler >> defaulSizeHook [

	^ nil
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> element [

	^ element
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> element: anElement [

	element ifNotNil: [
		element removeEventHandler: elementEventHandler.
		elementEventHandler := nil ].
	element := anElement.
	element ifNotNil: [
		element addEventHandler: self newElementEventHandler ]
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> elementEventHandlerClass [

	^ ToAnchorEventHandler 
]

{ #category : 'testing' }
ToAnchoredWindowHandler >> hasWindow [

	^ currentWindow notNil
]

{ #category : 'initialization' }
ToAnchoredWindowHandler >> initialize [ 

	super initialize.
	self positionHook: self defaulPositionHook.
	self sizeHook: self defaulSizeHook.

	
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> newElementEventHandler [

	elementEventHandler := self elementEventHandlerClass new.
	elementEventHandler windowHandler: self.
	^ elementEventHandler
]

{ #category : 'window handling' }
ToAnchoredWindowHandler >> newWindowEvent: anEvent [

	currentWindow ifNotNil: [
		Error signal: 'Asking for a associate window building twice' ].
	element dispatchEvent: (self windowBeforeBuildingEventClass new
			 sourceEvent: anEvent;
			 yourself).
	currentWindow := self newWindowInstance.
	windowClosedHandler := BlEventHandler
		                       on: ToWindowClosedEvent
		                       do: [ self windowClosed ].
	currentWindow addEventHandler: windowClosedHandler.
	^ currentWindow
]

{ #category : 'window handling' }
ToAnchoredWindowHandler >> newWindowInstance [

	| w |
	w := self windowClass new handler: self; yourself.
	builder value: w value: self element.
	^ w
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> positionHook [

	^ positionHook
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> positionHook: aValuable [
	" takes the window as argument. Computes the window position according to the given window anchor element "
	
	positionHook := aValuable.
	self applyPositionHookFromEvent: nil
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> sizeHook [
	
	^ sizeHook
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> sizeHook: aValuable [
	
	sizeHook := aValuable.
	self applySizeHookFromEvent: nil
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> windowBeforeBuildingEventClass [

	^ ToWindowBeforeBuildingEvent 
]

{ #category : 'accessing' }
ToAnchoredWindowHandler >> windowClass [

	^ ToAnchoredWindow 
]

{ #category : 'window handling' }
ToAnchoredWindowHandler >> windowClosed [

	currentWindow removeEventHandler: windowClosedHandler.
	windowClosedHandler := nil.
	currentWindow handler: nil.
	currentWindow := nil
]
