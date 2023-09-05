Class {
	#name : #ToSelectedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToSelectedLookEvent >> sendToLook: aLook [

	aLook selectedLookEvent: self
]
