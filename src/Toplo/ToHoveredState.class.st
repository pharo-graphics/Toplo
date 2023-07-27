Class {
	#name : #ToHoveredState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #testing }
ToHoveredState >> isHoveredState [

	^ true
]

{ #category : #'look event sending' }
ToHoveredState >> sendEvent: anEvent toLook: aLook [

	aLook hoveredLookEvent: anEvent
]
