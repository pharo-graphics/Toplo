Class {
	#name : #ToMouseLeavedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToMouseLeavedLookEvent >> sendToLook: aLook [

	aLook mouseLeavedLookEvent: self
]
