Class {
	#name : #ToClickLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToClickLookEvent >> sendToLook: aLook [

	aLook clickLookEvent: self
]
