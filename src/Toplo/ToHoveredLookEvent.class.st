Class {
	#name : #ToHoveredLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-LookEvents'
}

{ #category : #sending }
ToHoveredLookEvent >> sendToLook: aLook [

	aLook hoveredLookEvent: self
]
