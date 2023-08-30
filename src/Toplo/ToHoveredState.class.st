Class {
	#name : #ToHoveredState,
	#superclass : #ToElementState,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #'look event sending' }
ToHoveredState >> applyOn: anElement [

	anElement dispatchLookEvent: ToHoveredLookEvent new
]

{ #category : #testing }
ToHoveredState >> isHoveredState [

	^ true
]
