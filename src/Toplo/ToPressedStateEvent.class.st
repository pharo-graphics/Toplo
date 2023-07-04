Class {
	#name : #ToPressedStateEvent,
	#superclass : #ToElementStateEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToPressedStateEvent >> sendToLook: aLook [

	aLook pressedStateEvent: self
]
