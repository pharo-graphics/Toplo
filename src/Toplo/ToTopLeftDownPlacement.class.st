Class {
	#name : #ToTopLeftDownPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToTopLeftDownPlacement >> positionWindow: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root element pos |
	root := aWindow anchorRoot.
	element := aWindow element.
	pos := (element bounds inParent: root) topLeft.
	aWindow position: pos

]
