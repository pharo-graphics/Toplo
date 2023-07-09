Class {
	#name : #ToMouseLeavedLookEvent,
	#superclass : #ToElementMouseRelatedLookEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToMouseLeavedLookEvent >> sendToLook: aLook [

	aLook mouseLeavedLookEvent: self
]
