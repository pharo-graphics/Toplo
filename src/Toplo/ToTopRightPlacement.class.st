Class {
	#name : #ToTopRightPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToTopRightPlacement >> positionWindow: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root element |
	root := aWindow anchorRoot.
	element := aWindow element.
	aWindow position: (element bounds inParent: root) topRight
		- (0 @ aWindow measuredHeight)
]
