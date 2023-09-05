Class {
	#name : #ToHoveredLookEvent,
	#superclass : #ToElementLookEvent,
	#category : #'Toplo-Theme-Look-Event'
}

{ #category : #sending }
ToHoveredLookEvent >> sendToLook: aLook [

	aLook hoveredLookEvent: self
]
