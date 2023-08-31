Class {
	#name : #ToSelectedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToSelectedLookEvent >> sendToLook: aLook [

	aLook selectedLookEvent: self
]
