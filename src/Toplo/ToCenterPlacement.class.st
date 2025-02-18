Class {
	#name : #ToCenterPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToCenterPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theElem theRoot etopLeft ewidth eheight w h x y |
	theElem := anElement element.
	theRoot := anElement anchorRoot.
	etopLeft := (theElem bounds inParent: theRoot) bounds topLeft.
	ewidth := theElem width / 2.0.
	eheight := theElem height / 2.0.
	w := anElement root measuredWidth / 2.0.
	h := anElement root measuredHeight / 2.0.
	x := etopLeft x + ewidth - w.
	y := etopLeft y + eheight - h.
	anElement position: x @ y
]
