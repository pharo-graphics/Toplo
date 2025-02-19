Class {
	#name : #ToAnchoredBottomLeftPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredBottomLeftPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root theAnchor |
	root := anElement anchorRoot.
	theAnchor := anElement anchorElement.
	anElement position: (theAnchor bounds inParent: root) bottomLeft
		- (anElement measuredWidth @ 0)
]
