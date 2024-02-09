Class {
	#name : #ToReleasedLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToReleasedLookEvent >> sendTo: anObject [

	anObject releasedLookEvent: self
]
