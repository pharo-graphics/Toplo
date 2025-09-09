Class {
	#name : #ToAnchoredWindowArrangingStep,
	#superclass : #ToAnchoredWindowLayoutStep,
	#category : #'Toplo-Core-Window'
}

{ #category : #running }
ToAnchoredWindowArrangingStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [

	aWindow
		positionOnEvent: anEvent
		context: aBlElementBoundsUpdateContext.
	^ ToAnchoredWindowAnchorRootStep new
]
