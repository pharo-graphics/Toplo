Class {
	#name : #ToUnfocusedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToUnfocusedLookEvent >> sendTo: anObject [

	anObject unfocusedLookEvent: self
]
