Class {
	#name : #ToMousePressedLookEvent,
	#superclass : #ToElementMouseRelatedLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToMousePressedLookEvent >> sendToLook: aLook [

	aLook mousePressedLookEvent: self
]
