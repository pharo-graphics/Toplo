Class {
	#name : #ToInitialLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToInitialLookEvent >> sendToLook: aLook [

	aLook initialLookEvent: self
]
