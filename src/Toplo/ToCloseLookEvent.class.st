Class {
	#name : #ToCloseLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToCloseLookEvent >> sendToLook: aLook [

	aLook closeLookEvent: self
]
