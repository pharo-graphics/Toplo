Class {
	#name : #ToHoveredLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Core-Theme-Look-Events'
}

{ #category : #sending }
ToHoveredLookEvent >> sendToLook: aLook [

	aLook hoveredLookEvent: self
]
