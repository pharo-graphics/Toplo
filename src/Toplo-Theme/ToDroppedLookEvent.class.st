Class {
	#name : #ToDroppedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToDroppedLookEvent >> sendTo: anObject [

	anObject droppedLookEvent: self
]
