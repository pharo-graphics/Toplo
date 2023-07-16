Class {
	#name : #ToEnableLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToEnableLookEvent >> sendToLook: aLook [

	aLook enableLookEvent: self
]
