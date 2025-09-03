Class {
	#name : #ToAnchoredWindowAnchorRootStep,
	#superclass : #ToAnchoredWindowLayoutStep,
	#category : #'Toplo-Core-Window'
}

{ #category : #running }
ToAnchoredWindowAnchorRootStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [

	aWindow manager ifNil: [ ^ self ].
	aWindow position: aWindow correctedPositionWithinAnchorRoot.
	aWindow toFront.
	aWindow spaceDo: [ :sp | aWindow popupTimestamp: sp time now ].
	aWindow visibility: BlVisibility visible.
	^ nil
]
