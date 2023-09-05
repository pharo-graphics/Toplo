Class {
	#name : #ToCloseLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToCloseLookEvent >> sendToLook: aLook [

	aLook closeLookEvent: self
]
