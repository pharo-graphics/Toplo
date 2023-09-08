Class {
	#name : #ToClickedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToClickedLookEvent >> sendToLook: aLook [

	aLook clickedLookEvent: self
]
