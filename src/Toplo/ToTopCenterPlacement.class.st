Class {
	#name : #ToTopCenterPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToTopCenterPlacement >> arrangeWindow: aWindow onEvent: anEvent [
	"		| root element |
	root := aWindow anchorRoot.
	element := aWindow element.
	aWindow root width: element width.
	aWindow position: (element bounds inParent: root) topLeft - (0 @ (aWindow root measuredHeight))
"

	| theElem theRoot etopLeft ewidth w x |
	self flag: 'not working: the window width is alway zero...'.
	theElem := aWindow element.
	theRoot := aWindow anchorRoot.
	etopLeft := (theElem bounds inParent: theRoot) bounds topLeft.
	ewidth := theElem width / 2.0.
	aWindow root hFitContent.
	"aWindow width: theElem width."
	
		w := aWindow root measuredWidth / 2.0.
		x := etopLeft x + ewidth - w.
		aWindow position: x @ (etopLeft y - aWindow root measuredHeight) 
]
