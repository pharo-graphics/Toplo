Class {
	#name : #ToOpenLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToOpenLookEvent >> sendToLook: aLook [

	aLook openLookEvent: self
]
