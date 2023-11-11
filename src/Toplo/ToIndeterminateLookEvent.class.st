Class {
	#name : #ToIndeterminateLookEvent,
	#superclass : #ToElementLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToIndeterminateLookEvent >> sendTo: anObject [

	anObject indeterminateLookEvent: self
]
