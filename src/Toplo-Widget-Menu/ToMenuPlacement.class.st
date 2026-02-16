Class {
	#name : #ToMenuPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'api - displaying' }
ToMenuPlacement >> positionElement: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [
	" The window placing is at top right or bottom left according to menu or the menubar "

	| root element pos rootMenuOrMenuPane |
	root := aWindow anchorRoot.
	element := aWindow anchorElement.
	rootMenuOrMenuPane := element rootMenuWindowOrMenuPane.

	pos := (element isSubmenu or: [
		        rootMenuOrMenuPane notNil and: [
			        rootMenuOrMenuPane itemList isOrientable and: [rootMenuOrMenuPane isVertical ] ] ])
		       ifTrue: [
		       (element measuredBounds inParent: root) topRight ]
		       ifFalse: [
		       (element measuredBounds inParent: root) bottomLeft ].
	aWindow position: pos
]
