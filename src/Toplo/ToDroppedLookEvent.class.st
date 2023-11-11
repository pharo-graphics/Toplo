Class {
	#name : #ToDroppedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToDroppedLookEvent >> sendTo: anObject [

	anObject droppedLookEvent: self
]
