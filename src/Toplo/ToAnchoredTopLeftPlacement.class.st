Class {
	#name : #ToAnchoredTopLeftPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredTopLeftPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root theAnchor |
	root := anElement anchorRoot.
	theAnchor := anElement anchorElement.
	anElement position: (theAnchor bounds inParent: root) topLeft
		- (anElement measuredWidth @ anElement measuredHeight)
]
