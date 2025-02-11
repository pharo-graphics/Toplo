Class {
	#name : #ToAnchoredWindowArrangingStep,
	#superclass : #ToAnchoredWindowOpeningStep,
	#category : #'Toplo-Core-Window'
}

{ #category : #running }
ToAnchoredWindowArrangingStep >> nextStepFor: aWindow onEvent: anEvent [

	| bnds |
	bnds := aWindow measuredBounds asRectangle.
	aWindow positionWindowOnEvent: anEvent.
	aWindow measuredBounds asRectangle = bnds ifTrue: [
		^ ToAnchoredWindowAnchorRootStep new ].
	^ self
]
