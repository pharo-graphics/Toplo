Class {
	#name : #ToAnchoredWindowOpeningStartStep,
	#superclass : #ToAnchoredWindowOpeningStep,
	#category : #'Toplo-Core-Window'
}

{ #category : #running }
ToAnchoredWindowOpeningStartStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [

	aWindow visibility: BlVisibility hidden.
	^ ToAnchoredWindowArrangingStep new
]
