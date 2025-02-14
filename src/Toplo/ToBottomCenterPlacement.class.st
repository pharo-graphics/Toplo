Class {
	#name : #ToBottomCenterPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToBottomCenterPlacement >> positionWindow: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| theElem theRoot etopLeft ewidth w x |
	theElem := aWindow element.
	theRoot := aWindow anchorRoot.
	etopLeft := (theElem bounds inParent: theRoot) bounds topLeft.
	ewidth := theElem measuredWidth / 2.0.
	w := aWindow measuredWidth / 2.0.
	x := etopLeft x + ewidth - w.
	aWindow position: x @ (etopLeft y + theElem height)
]
