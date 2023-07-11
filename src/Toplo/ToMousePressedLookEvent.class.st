Class {
	#name : #ToMousePressedLookEvent,
	#superclass : #ToElementMouseRelatedLookEvent,
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #sending }
ToMousePressedLookEvent >> sendToLook: aLook [

	aLook mousePressedLookEvent: self
]
