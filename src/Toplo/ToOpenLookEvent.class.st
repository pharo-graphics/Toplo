Class {
	#name : #ToOpenLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToOpenLookEvent >> sendToLook: aLook [

	aLook openLookEvent: self
]
