Class {
	#name : #ToInitialLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #sending }
ToInitialLookEvent >> sendToLook: aLook [

	aLook initialLookEvent: self
]
