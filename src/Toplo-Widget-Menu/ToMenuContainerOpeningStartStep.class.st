Class {
	#name : #ToMenuContainerOpeningStartStep,
	#superclass : #ToAnchoredWindowOpeningStartStep,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #running }
ToMenuContainerOpeningStartStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [
	

	^ super
		  nextStepFor: aWindow
		  onEvent: anEvent
		  onLayout: aBounds
		  context: aBlElementBoundsUpdateContext
]
