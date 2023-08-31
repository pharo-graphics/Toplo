Class {
	#name : #ToClickLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToClickLookEvent >> sendToLook: aLook [

	aLook clickLookEvent: self
]
