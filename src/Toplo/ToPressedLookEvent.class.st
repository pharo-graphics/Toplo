Class {
	#name : #ToPressedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToPressedLookEvent >> sendToLook: aLook [

	aLook pressedLookEvent: self
]
