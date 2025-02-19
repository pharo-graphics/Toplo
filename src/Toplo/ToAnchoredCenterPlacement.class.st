Class {
	#name : #ToAnchoredCenterPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Support'
}

{ #category : #'api - displaying' }
ToAnchoredCenterPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theAnchor theRoot etopLeft ewidth eheight w h x y |
	theAnchor := anElement element.
	theRoot := anElement anchorRoot.
	etopLeft := (theAnchor bounds inParent: theRoot) bounds topLeft.
	ewidth := theAnchor width / 2.0.
	eheight := theAnchor height / 2.0.
	w := anElement root measuredWidth / 2.0.
	h := anElement root measuredHeight / 2.0.
	x := etopLeft x + ewidth - w.
	y := etopLeft y + eheight - h.
	anElement position: x @ y
]
