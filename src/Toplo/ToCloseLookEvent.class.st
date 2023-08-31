Class {
	#name : #ToCloseLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToCloseLookEvent >> sendToLook: aLook [

	aLook closeLookEvent: self
]
