Class {
	#name : #ToDisabledLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToDisabledLookEvent >> sendToLook: aLook [

	aLook disabledLookEvent: self
]
