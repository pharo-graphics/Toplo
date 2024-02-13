Class {
	#name : #ToClosedLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToClosedLookEvent >> sendTo: anObject [

	anObject closedLookEvent: self
]
