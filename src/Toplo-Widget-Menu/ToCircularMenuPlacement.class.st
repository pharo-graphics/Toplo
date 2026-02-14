Class {
	#name : #ToCircularMenuPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'api - displaying' }
ToCircularMenuPlacement >> positionElement: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [
	" The window placing is at top right or bottom left according to menu or the menubar "

	| root element pos |
	root := aWindow anchorRoot.
	element := aWindow anchorElement.
	pos := (element measuredBounds inParent: root) bottomLeft.
	aWindow position: pos
]
