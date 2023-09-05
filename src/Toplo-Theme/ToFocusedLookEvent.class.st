Class {
	#name : #ToFocusedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToFocusedLookEvent >> sendToLook: aLook [

	aLook focusedLookEvent: self
]
