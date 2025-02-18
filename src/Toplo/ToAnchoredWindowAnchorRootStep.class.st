Class {
	#name : #ToAnchoredWindowAnchorRootStep,
	#superclass : #ToAnchoredWindowOpeningStep,
	#category : #'Toplo-Core-Window'
}

{ #category : #running }
ToAnchoredWindowAnchorRootStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [

	| p |
	p := aWindow correctedPositionWithinAnchorRoot.
	p ~= aWindow measuredPosition ifTrue: [
		aWindow position: p "extent: aWindow measuredExtent context: aBlElementBoundsUpdateContext"].
	aWindow toFront.
	aWindow visibility: BlVisibility visible.
	^ nil
]
