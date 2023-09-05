Class {
	#name : #ToInitialLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToInitialLookEvent >> sendToLook: aLook [

	aLook initialLookEvent: self
]
