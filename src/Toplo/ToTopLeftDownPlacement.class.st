Class {
	#name : #ToTopLeftDownPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToTopLeftDownPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root element pos |
	root := anElement anchorRoot.
	element := anElement anchorElement.
	pos := (element bounds inParent: root) topLeft.
	anElement position: pos
]
