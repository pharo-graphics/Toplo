Class {
	#name : #ToIndeterminateLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToIndeterminateLookEvent >> sendTo: anObject [

	anObject indeterminateLookEvent: self
]
