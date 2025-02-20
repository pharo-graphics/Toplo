Class {
	#name : #ToAnchoredTopRightPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredTopRightPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root theAnchor |
	root := anElement anchorRoot.
	theAnchor := anElement anchorElement.
	anElement position: (theAnchor bounds inParent: root) topRight
		- (0 @ anElement measuredHeight)
]
