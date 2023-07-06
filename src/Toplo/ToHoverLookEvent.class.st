Class {
	#name : #ToHoverLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToHoverLookEvent >> sendToLook: aLook [

	aLook hoverLookEvent: self
]
