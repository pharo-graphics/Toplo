Class {
	#name : #ToAnchoredWindowOpeningStartStep,
	#superclass : #ToAnchoredWindowOpeningStep,
	#category : #'Toplo-Core-Window'
}

{ #category : #running }
ToAnchoredWindowOpeningStartStep >> nextStepFor: aWindow onEvent: anEvent [

	aWindow visibility: BlVisibility hidden.
	^ ToAnchoredWindowArrangingStep new
]
