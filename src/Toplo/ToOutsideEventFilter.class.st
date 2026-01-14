Class {
	#name : #ToOutsideEventFilter,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'elementStack',
		'eventsToHandle',
		'oneShot',
		'elementsToCheck'
	],
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'instance creation' }
ToOutsideEventFilter class >> newOneShotInstance [

	^ self new
		  oneShot: true;
		  yourself
]

{ #category : #'api - event managing' }
ToOutsideEventFilter >> checkElementStackOnEvent: anEvent [

	elementStack ifEmpty: [ ^ self discardOnEvent: anEvent ].
	[ elementStack top isAttachedToSceneGraph ] whileFalse: [
			elementStack pop.
			elementStack ifEmpty: [ ^ self discardOnEvent: anEvent ] ].
	elementStack ifEmpty: [ ^ self discardOnEvent: anEvent ]
]

{ #category : #'api - event managing' }
ToOutsideEventFilter >> discardOnEvent: anEvent [

	anEvent currentTarget removeEventFilter: self
]

{ #category : #'mouse handlers' }
ToOutsideEventFilter >> dispatchOutsideEventOn: anEvent [

	elementStack top dispatchEvent: (anEvent asOutsideEvent
			 sourceEvent: anEvent;
			 emitter: self;
			 yourself)
]

{ #category : #accessing }
ToOutsideEventFilter >> element: anElement [

	self pushElement: anElement
]

{ #category : #accessing }
ToOutsideEventFilter >> elementToCheck: anElement [
 
	elementsToCheck := Array with: anElement
]

{ #category : #accessing }
ToOutsideEventFilter >> elementsToCheck [

	^ elementsToCheck ifNil: [ elementStack asArray ]
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

	self checkElementStackOnEvent: anEvent.
	elementStack ifEmpty: [ ^ self ].
	(self isOutsideEvent: anEvent) ifTrue: [ " ok, the event is outside. Consuming should be done outside "
		self dispatchOutsideEventOn: anEvent ].
	oneShot ifFalse: [ ^ self ].
	self discardOnEvent: anEvent
]

{ #category : #initialization }
ToOutsideEventFilter >> initialize [ 

	super initialize.
	oneShot := false.
	elementStack := Stack new
]

{ #category : #'mouse handlers' }
ToOutsideEventFilter >> isOutsideEvent: anEvent [
	" does the event occurs on the element itsef ?"

	^ self elementsToCheck allSatisfy: [ :e | e isOutsideEvent: anEvent ]
]

{ #category : #accessing }
ToOutsideEventFilter >> oneShot: aBoolean [

	oneShot := aBoolean
]

{ #category : #accessing }
ToOutsideEventFilter >> popElement [

	elementStack pop
]

{ #category : #accessing }
ToOutsideEventFilter >> pushElement: anElement [

	elementStack push: anElement
]

{ #category : #'api - event managing' }
ToOutsideEventFilter >> wantsEvent: anEvent [

	^ self eventsToHandle anySatisfy: [ :cls |
		  anEvent class == cls or: [ anEvent class inheritsFrom: cls ] ]
]
