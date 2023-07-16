Class {
	#name : #ToFocusLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToFocusLookEvent >> sendToLook: aLook [

	aLook focusLookEvent: self
]
