Class {
	#name : #ToAnchoredWindowArrangingStep,
	#superclass : #ToAnchoredWindowOpeningStep,
	#category : #'Toplo-Core-Window'
}

{ #category : #running }
ToAnchoredWindowArrangingStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [

	| bnds |
	bnds := aWindow measuredBounds asRectangle.
	aWindow
		positionOnEvent: anEvent
		context: aBlElementBoundsUpdateContext.
	^ ToAnchoredWindowAnchorRootStep new
]
