Class {
	#name : #ToBottomRightPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToBottomRightPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root element |
	root := anElement anchorRoot.
	element := anElement element.
	anElement position: (element bounds inParent: root) bottomRight 
]
