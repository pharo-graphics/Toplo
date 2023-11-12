Class {
	#name : #ToSelectedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToSelectedLookEvent >> sendTo: anObject [

	anObject selectedLookEvent: self
]
