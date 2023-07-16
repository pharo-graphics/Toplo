Class {
	#name : #ToClickLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToClickLookEvent >> sendToLook: aLook [

	aLook clickLookEvent: self
]
