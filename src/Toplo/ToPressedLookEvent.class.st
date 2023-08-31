Class {
	#name : #ToPressedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToPressedLookEvent >> sendToLook: aLook [

	aLook pressedLookEvent: self
]
