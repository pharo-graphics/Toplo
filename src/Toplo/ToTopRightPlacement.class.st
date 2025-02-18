Class {
	#name : #ToTopRightPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToTopRightPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root element |
	root := anElement anchorRoot.
	element := anElement element.
	anElement position: (element bounds inParent: root) topRight
		- (0 @ anElement measuredHeight)
]
