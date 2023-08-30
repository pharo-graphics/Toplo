Class {
	#name : #ToSelectedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToSelectedLookEvent >> sendToLook: aLook [

	aLook selectedLookEvent: self
]
