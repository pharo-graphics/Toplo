Class {
	#name : #ToClosedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToClosedLookEvent >> sendToLook: aLook [

	aLook closedLookEvent: self
]
