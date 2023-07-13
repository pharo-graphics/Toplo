Class {
	#name : #ToMouseLeavedLookEvent,
	#superclass : #ToElementMouseRelatedLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToMouseLeavedLookEvent >> sendToLook: aLook [

	aLook mouseLeavedLookEvent: self
]
