Class {
	#name : #ToAnyUIEventOutsideEventFilter,
	#superclass : #ToEventOutsideEventFilter,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'event handling' }
ToAnyUIEventOutsideEventFilter >> anyUIEventOutsideEvent: anEvent [
	" 
	do nothing if the original event target is inside my target 
	"

	holder ifNil: [ ^ self ].
	holder isAttachedToSceneGraph ifFalse: [ " if my target is removed
		This can be the case if the parent is removed "
			holder removeEventFilter: self.
			^ self ].
	anEvent isMouseMove ifTrue: [ ^ self ].
	(self isOutsideEvent: anEvent) ifFalse: [ ^ self ].

	" ok, the event is outside. Consuming should be done outside "
	self dispatchOutsideEventOn: anEvent
]

{ #category : #'mouse handlers' }
ToAnyUIEventOutsideEventFilter >> dispatchOutsideEventOn: anEvent [

	element dispatchEvent: (ToAnyUIEventOutsideEvent new
			 sourceEvent: anEvent;
			 emitter: self;
			 fillFromTime: element space time;
			 yourself)
]

{ #category : #'api - accessing' }
ToAnyUIEventOutsideEventFilter >> eventsToHandle [

	^ { BlUIEvent }
]

{ #category : #'api - event managing' }
ToAnyUIEventOutsideEventFilter >> handleEvent: anEvent [

	self anyUIEventOutsideEvent: anEvent
]

{ #category : #'api - event managing' }
ToAnyUIEventOutsideEventFilter >> wantsEvent: anEvent [

	^ anEvent isKindOf: BlUIEvent
]
