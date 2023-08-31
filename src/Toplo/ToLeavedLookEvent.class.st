Class {
	#name : #ToLeavedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToLeavedLookEvent >> sendToLook: aLook [

	aLook leavedLookEvent: self
]
