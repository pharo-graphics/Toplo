Class {
	#name : #ToAnchoredWindowOpeningStep,
	#superclass : #Object,
	#category : #'Toplo-Core-Window'
}

{ #category : #running }
ToAnchoredWindowOpeningStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [

	self subclassResponsibility 
]
