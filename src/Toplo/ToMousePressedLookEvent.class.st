Class {
	#name : #ToMousePressedLookEvent,
	#superclass : #ToElementMouseRelatedLookEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToMousePressedLookEvent >> sendToLook: aLook [

	aLook mousePressedLookEvent: self
]
