Class {
	#name : #ToMouseUpOutsideEventFilter,
	#superclass : #ToEventOutsideEventFilter,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'mouse handlers' }
ToMouseUpOutsideEventFilter >> dispatchOutsideEventOn: anEvent [

	element dispatchEvent: (ToMouseUpOutsideEvent new
			 sourceEvent: anEvent;
			 emitter: self;
			 fillFromTime: element space time;
			 yourself)
]

{ #category : #'api - accessing' }
ToMouseUpOutsideEventFilter >> eventsToHandle [

	^ { BlMouseUpEvent }
]

{ #category : #'api - event managing' }
ToMouseUpOutsideEventFilter >> handleEvent: anEvent [

	anEvent sendTo: self
]

{ #category : #'mouse handlers' }
ToMouseUpOutsideEventFilter >> mouseUpEvent: anEvent [
	" 
	do nothing if the original event target is inside my target 
	"

	holder ifNil: [ ^ self ].
	holder isAttachedToSceneGraph ifFalse: [ " if my target is removed
		This can be the case if the parent is removed "
			holder removeEventFilter: self.
			^ self ].

	(self isOutsideEvent: anEvent) ifFalse: [ ^ self ].

	" ok, the event is outside. Consuming should be done outside "
	self dispatchOutsideEventOn: anEvent
]

{ #category : #'api - event managing' }
ToMouseUpOutsideEventFilter >> wantsEvent: anEvent [

	^ anEvent isKindOf: BlMouseUpEvent
]
