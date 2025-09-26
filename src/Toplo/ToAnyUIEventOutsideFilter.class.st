Class {
	#name : #ToAnyUIEventOutsideFilter,
	#superclass : #ToOutsideEventFilter,
	#category : #'Toplo-Support-EventGenerator'
}

{ #category : #'event handling' }
ToAnyUIEventOutsideFilter >> anyUIEventOutsideEvent: anEvent [
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

{ #category : #'api - accessing' }
ToAnyUIEventOutsideFilter >> eventsToHandle [

	^ { BlUIEvent }
]

{ #category : #'api - event managing' }
ToAnyUIEventOutsideFilter >> handleEvent: anEvent [

	self anyUIEventOutsideEvent: anEvent
]

{ #category : #'api - event managing' }
ToAnyUIEventOutsideFilter >> wantsEvent: anEvent [

	^ anEvent isKindOf: BlUIEvent
]
