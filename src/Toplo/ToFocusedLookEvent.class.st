Class {
	#name : #ToFocusedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToFocusedLookEvent >> sendToLook: aLook [

	aLook focusedLookEvent: self
]
