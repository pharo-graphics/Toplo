Class {
	#name : #ToDragStartedLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToDragStartedLookEvent >> sendTo: anObject [

	anObject dragStartedLookEvent: self
]
