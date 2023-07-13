Class {
	#name : #ToInitialLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToInitialLookEvent >> sendToLook: aLook [

	aLook initialLookEvent: self
]
