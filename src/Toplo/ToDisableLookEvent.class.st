Class {
	#name : #ToDisableLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToDisableLookEvent >> sendToLook: aLook [

	aLook disableLookEvent: self
]
