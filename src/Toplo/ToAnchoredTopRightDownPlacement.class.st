Class {
	#name : #ToAnchoredTopRightDownPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredTopRightDownPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root theAnchor pos |
	root := anElement anchorRoot.
	theAnchor := anElement anchorElement.
	pos := (theAnchor bounds inParent: root) topRight - (anElement width @ 0).
	anElement position: pos
]
