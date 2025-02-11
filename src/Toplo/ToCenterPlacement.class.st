Class {
	#name : #ToCenterPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToCenterPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| theElem theRoot etopLeft ewidth eheight w h x y |
	theElem := aWindow element.
	theRoot := aWindow anchorRoot.
	etopLeft := (theElem bounds inParent: theRoot) bounds topLeft.
	ewidth := theElem width / 2.0.
	eheight := theElem height / 2.0.
	w := aWindow root measuredWidth / 2.0.
	h := aWindow root measuredHeight / 2.0.
	x := etopLeft x + ewidth - w.
	y := etopLeft y + eheight - h.
	aWindow position: x @ y
]
