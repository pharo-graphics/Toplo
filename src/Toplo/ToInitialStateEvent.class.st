Class {
	#name : #ToInitialStateEvent,
	#superclass : #ToElementStateEvent,
	#category : #'Toplo-Theme-Skins'
}

{ #category : #sending }
ToInitialStateEvent >> sendToLook: aLook [

	aLook initialStateEvent: self
]
