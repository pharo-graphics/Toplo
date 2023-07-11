Class {
	#name : #ToMouseLeavedLookEvent,
	#superclass : #ToElementMouseRelatedLookEvent,
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #sending }
ToMouseLeavedLookEvent >> sendToLook: aLook [

	aLook mouseLeavedLookEvent: self
]
