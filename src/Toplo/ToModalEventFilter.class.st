Class {
	#name : #ToModalEventFilter,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'contextStack',
		'modalElement'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'api - accessing' }
ToModalEventFilter >> eventsToHandle [

	^ { BlUIEvent }
]

{ #category : #'api - event managing' }
ToModalEventFilter >> handleEvent: anEvent [
	" 
	do nothing if the original event target is inside my target 
	"
	(self isOutsideEvent: anEvent) ifFalse: [ ^ self ].
	" ok, the event is outside. Consuming it to stop the dispatching  "
	anEvent consume
]

{ #category : #initialization }
ToModalEventFilter >> initialize [ 

	super initialize.
	contextStack := Stack new
]

{ #category : #testing }
ToModalEventFilter >> isOutsideEvent: anEvent [
	" does the event occurs on the element itsef ?"
	
	^ modalElement isOutsideEvent: anEvent
]

{ #category : #accessing }
ToModalEventFilter >> modalElement: anElement [

	modalElement := anElement
]

{ #category : #'api - hooks' }
ToModalEventFilter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self pushRoot: anElement 
]

{ #category : #'api - hooks' }
ToModalEventFilter >> onUninstalledIn: anElement [

	contextStack removeAll.
	super onUninstalledIn: anElement.

]

{ #category : #'context managing' }
ToModalEventFilter >> popRoot [

	contextStack pop
]

{ #category : #'context managing' }
ToModalEventFilter >> pushRoot: anElement [

	contextStack push: (Array streamContents: [ :stream |
			 stream nextPutAll: anElement children ])
]

{ #category : #'api - event managing' }
ToModalEventFilter >> wantsEvent: anEvent [

	^ self eventsToHandle anySatisfy: [ :cls |
		  anEvent class == cls or: [ anEvent class inheritsFrom: cls ] ]
]
