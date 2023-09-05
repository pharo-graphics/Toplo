Class {
	#name : #ToPressedLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToPressedLookEvent >> sendToLook: aLook [

	aLook pressedLookEvent: self
]
