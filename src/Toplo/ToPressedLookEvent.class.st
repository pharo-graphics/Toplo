Class {
	#name : #ToPressedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToPressedLookEvent >> sendToLook: aLook [

	aLook pressedLookEvent: self
]
