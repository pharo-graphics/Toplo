Class {
	#name : #ToAnchoredWindowAnchorRootStep,
	#superclass : #ToAnchoredWindowOpeningStep,
	#category : #'Toplo-Core-Window'
}

{ #category : #running }
ToAnchoredWindowAnchorRootStep >> nextStepFor: aWindow onEvent: anEvent [

	| p |
	p := aWindow correctedPositionWithinAnchorRoot.
	p ~= aWindow measuredPosition ifTrue: [
		aWindow position: p ].
	aWindow lastPopupEvent: nil.
	aWindow toFront.
	aWindow visibility: BlVisibility visible.
	^ nil
]
