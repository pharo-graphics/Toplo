Class {
	#name : #ToOutsideEventFilter,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'element',
		'elementToCheck',
		'eventsToHandle',
		'oneShot'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'instance creation' }
ToOutsideEventFilter class >> newOneShotInstance [

	^ self new
		  oneShot: true;
		  yourself
]

{ #category : #'mouse handlers' }
ToOutsideEventFilter >> dispatchOutsideEventOn: anEvent [

	element dispatchEvent: (anEvent asOutsideEvent
			 sourceEvent: anEvent;
			 emitter: self;
			 yourself)
]

{ #category : #accessing }
ToOutsideEventFilter >> element: anElement [

	element := anElement
]

{ #category : #accessing }
ToOutsideEventFilter >> elementToCheck [

	^ elementToCheck ifNil: [ elementToCheck := element ]
]

{ #category : #accessing }
ToOutsideEventFilter >> elementToCheck: anElement [

	elementToCheck := anElement
]

{ #category : #'api - accessing' }
ToOutsideEventFilter >> eventsToHandle [

	^ eventsToHandle ifNil: [ eventsToHandle := #(  ) ]
]

{ #category : #'api - accessing' }
ToOutsideEventFilter >> eventsToHandle: anEventClasseArray [

	eventsToHandle := anEventClasseArray
]

{ #category : #'api - event managing' }
ToOutsideEventFilter >> handleEvent: anEvent [
	" 
	do nothing if the original event target is inside my target 
	"
	| target |
	target := anEvent currentTarget.
	(self isOutsideEvent: anEvent) ifTrue: [ " ok, the event is outside. Consuming should be done outside "
		self dispatchOutsideEventOn: anEvent ].
	oneShot ifFalse: [ ^ self ].
	target removeEventFilter: self
]

{ #category : #initialization }
ToOutsideEventFilter >> initialize [ 

	super initialize.
	oneShot := false
]

{ #category : #'mouse handlers' }
ToOutsideEventFilter >> isOutsideEvent: anEvent [
	" does the event occurs on the element itsef ?"

	^ self elementToCheck isOutsideEvent: anEvent
]

{ #category : #accessing }
ToOutsideEventFilter >> oneShot: aBoolean [

	oneShot := aBoolean
]

{ #category : #'api - event managing' }
ToOutsideEventFilter >> wantsEvent: anEvent [

	^ self eventsToHandle anySatisfy: [ :cls |
		  anEvent class == cls or: [ anEvent class inheritsFrom: cls ] ]
]
