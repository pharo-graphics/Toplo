Class {
	#name : #ToDragStartedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToDragStartedLookEvent >> sendTo: anObject [

	anObject dragStartedLookEvent: self
]
