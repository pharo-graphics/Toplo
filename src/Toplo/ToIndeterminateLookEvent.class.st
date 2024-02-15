Class {
	#name : #ToIndeterminateLookEvent,
	#superclass : #ToIntrasicStateLookEvent,
	#category : 'Toplo-Core-LookEvents'
}

{ #category : #sending }
ToIndeterminateLookEvent >> sendTo: anObject [

	anObject indeterminateLookEvent: self
]
