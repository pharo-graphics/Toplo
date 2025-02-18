Class {
	#name : #ToTopCenterPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToTopCenterPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theElem theRoot etopLeft ewidth w x |
	theElem := anElement element.
	theRoot := anElement anchorRoot.
	etopLeft := (theElem bounds inParent: theRoot) bounds topLeft.
	ewidth := theElem width / 2.0.
	w := anElement measuredWidth / 2.0.
	x := etopLeft x + ewidth - w.
	anElement position: x @ (etopLeft y - anElement measuredHeight)
]
