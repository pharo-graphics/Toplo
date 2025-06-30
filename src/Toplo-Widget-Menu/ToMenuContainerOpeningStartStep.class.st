Class {
	#name : #ToMenuContainerOpeningStartStep,
	#superclass : #ToAnchoredWindowOpeningStartStep,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #running }
ToMenuContainerOpeningStartStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [
	" if there is not enough place then turn as a scrollable menu container "

	^ super
		  nextStepFor: aWindow
		  onEvent: anEvent
		  onLayout: aBounds
		  context: aBlElementBoundsUpdateContext
]
