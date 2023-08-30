Class {
	#name : #ToOpenLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToOpenLookEvent >> sendToLook: aLook [

	aLook openLookEvent: self
]
