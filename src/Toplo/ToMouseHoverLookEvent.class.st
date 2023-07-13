Class {
	#name : #ToMouseHoverLookEvent,
	#superclass : #ToElementMouseRelatedLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToMouseHoverLookEvent >> sendToLook: aLook [

	aLook mouseHoverLookEvent: self
]
