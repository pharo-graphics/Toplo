Class {
	#name : #ToFocusedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToFocusedLookEvent >> sendToLook: aLook [

	aLook focusedLookEvent: self
]
