Class {
	#name : #ToClickLookEvent,
	#superclass : #ToElementMouseRelatedLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToClickLookEvent >> sendToLook: aLook [

	aLook clickLookEvent: self
]
