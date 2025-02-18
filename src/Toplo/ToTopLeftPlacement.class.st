Class {
	#name : #ToTopLeftPlacement,
	#superclass : #ToElementPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToTopLeftPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root element |
	root := anElement anchorRoot.
	element := anElement element.
	anElement position: (element bounds inParent: root) topLeft
		- (anElement measuredWidth @ anElement measuredHeight)
]
