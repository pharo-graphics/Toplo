Class {
	#name : #ToAnchoredBottomCenterPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredBottomCenterPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theAnchor theRoot etopLeft ewidth w x |
	theAnchor := anElement anchorElement.
	theRoot := anElement anchorRoot.
	etopLeft := (theAnchor bounds inParent: theRoot) bounds topLeft.
	ewidth := theAnchor measuredWidth / 2.0.
	w := anElement measuredWidth / 2.0.
	x := etopLeft x + ewidth - w.
	anElement position: x @ (etopLeft y + theAnchor height)
]
