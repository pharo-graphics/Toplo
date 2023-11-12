Class {
	#name : #ToLeavedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToLeavedLookEvent >> sendTo: anObject [

	anObject leavedLookEvent: self 
]
