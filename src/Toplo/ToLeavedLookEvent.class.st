Class {
	#name : #ToLeavedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToLeavedLookEvent >> sendToLook: aLook [

	aLook leavedLookEvent: self
]
