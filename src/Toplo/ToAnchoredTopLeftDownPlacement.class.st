Class {
	#name : #ToAnchoredTopLeftDownPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredTopLeftDownPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root theAnchor pos |
	root := anElement anchorRoot.
	theAnchor := anElement anchorElement.
	pos := (theAnchor bounds inParent: root) topLeft.
	anElement position: pos
]
