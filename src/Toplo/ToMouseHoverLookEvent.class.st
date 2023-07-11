Class {
	#name : #ToMouseHoverLookEvent,
	#superclass : #ToElementMouseRelatedLookEvent,
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #sending }
ToMouseHoverLookEvent >> sendToLook: aLook [

	aLook mouseHoverLookEvent: self
]
