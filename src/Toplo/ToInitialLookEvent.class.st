Class {
	#name : #ToInitialLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToInitialLookEvent >> sendToLook: aLook [

	aLook initialLookEvent: self
]
