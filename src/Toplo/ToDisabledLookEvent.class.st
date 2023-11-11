Class {
	#name : #ToDisabledLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToDisabledLookEvent >> sendTo: anObject [

	anObject disabledLookEvent: self
]
