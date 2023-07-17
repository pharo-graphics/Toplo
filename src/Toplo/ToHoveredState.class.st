Class {
	#name : #ToHoveredState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #'look event sending' }
ToHoveredState >> sendEvent: anEvent toLook: aLook [

	aLook hoveredLookEvent: anEvent
]
