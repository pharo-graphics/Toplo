Class {
	#name : #ToMenuPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'api - displaying' }
ToMenuPlacement >> positionWindow: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [
	" The window placing is at top right or bottom left according to menu or the menubar "

	| root element pos rootMenuOrMenuPane |
	root := aWindow anchorRoot.
	element := aWindow element.
	rootMenuOrMenuPane := element rootMenuItemContainer.
	pos := (element isSubmenu or: [
		        rootMenuOrMenuPane notNil and: [
			        rootMenuOrMenuPane isVertical ] ])
		       ifTrue: [ (element measuredBounds inParent: root) topRight ]
		       ifFalse: [ (element measuredBounds inParent: root) bottomLeft ].
	aWindow position: pos
]
