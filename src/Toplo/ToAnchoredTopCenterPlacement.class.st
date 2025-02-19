Class {
	#name : #ToAnchoredTopCenterPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredTopCenterPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theAnchor theRoot etopLeft ewidth w x |
	theAnchor := anElement anchorElement.
	theRoot := anElement anchorRoot.
	etopLeft := (theAnchor bounds inParent: theRoot) bounds topLeft.
	ewidth := theAnchor width / 2.0.
	w := anElement measuredWidth / 2.0.
	x := etopLeft x + ewidth - w.
	anElement position: x @ (etopLeft y - anElement measuredHeight)
]
