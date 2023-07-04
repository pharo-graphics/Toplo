Class {
	#name : #ToHoverStateEvent,
	#superclass : #ToElementStateEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToHoverStateEvent >> sendToLook: aLook [

	aLook hoverStateEvent: self
]
