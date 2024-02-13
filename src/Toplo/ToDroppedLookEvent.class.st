Class {
	#name : #ToDroppedLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToDroppedLookEvent >> sendTo: anObject [

	anObject droppedLookEvent: self
]
