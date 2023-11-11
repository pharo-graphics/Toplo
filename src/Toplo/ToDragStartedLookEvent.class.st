Class {
	#name : #ToDragStartedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToDragStartedLookEvent >> sendTo: anObject [

	anObject dragStartedLookEvent: self
]
