Class {
	#name : #ToOpenedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToOpenedLookEvent >> sendToLook: aLook [

	aLook openedLookEvent: self
]
