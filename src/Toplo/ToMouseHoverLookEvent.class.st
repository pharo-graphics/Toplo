Class {
	#name : #ToMouseHoverLookEvent,
	#superclass : #ToElementMouseRelatedLookEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToMouseHoverLookEvent >> sendToLook: aLook [

	aLook mouseHoverLookEvent: self
]
