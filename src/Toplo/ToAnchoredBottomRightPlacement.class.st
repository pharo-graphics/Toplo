Class {
	#name : #ToAnchoredBottomRightPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredBottomRightPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root theAnchor |
	root := anElement anchorRoot.
	theAnchor := anElement anchorElement.
	anElement position: (theAnchor bounds inParent: root) bottomRight
]
