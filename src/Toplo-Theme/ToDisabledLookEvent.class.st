Class {
	#name : #ToDisabledLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToDisabledLookEvent >> sendToLook: aLook [

	aLook disabledLookEvent: self
]
