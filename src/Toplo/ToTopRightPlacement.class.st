Class {
	#name : #ToTopRightPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToTopRightPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element |
	root := aWindow anchorRoot.
	element := aWindow element.
	aWindow position: (element bounds inParent: root) topRight
		- (0 @ aWindow measuredHeight)
]
