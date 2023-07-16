Class {
	#name : #ToMousePressedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToMousePressedLookEvent >> sendToLook: aLook [

	aLook mousePressedLookEvent: self
]
