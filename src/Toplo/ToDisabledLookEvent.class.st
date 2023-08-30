Class {
	#name : #ToDisabledLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToDisabledLookEvent >> sendToLook: aLook [

	aLook disabledLookEvent: self
]
