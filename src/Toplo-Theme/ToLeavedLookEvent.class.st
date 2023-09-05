Class {
	#name : #ToLeavedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToLeavedLookEvent >> sendToLook: aLook [

	aLook leavedLookEvent: self
]
