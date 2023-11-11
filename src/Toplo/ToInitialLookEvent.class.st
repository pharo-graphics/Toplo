Class {
	#name : #ToInitialLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToInitialLookEvent >> sendTo: anObject [

	anObject initialLookEvent: self
]
