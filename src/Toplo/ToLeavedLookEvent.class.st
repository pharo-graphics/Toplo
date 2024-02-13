Class {
	#name : #ToLeavedLookEvent,
	#superclass : #ToTransientLookEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToLeavedLookEvent >> sendTo: anObject [

	anObject leavedLookEvent: self 
]
