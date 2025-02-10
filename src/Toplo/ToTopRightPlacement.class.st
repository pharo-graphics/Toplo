Class {
	#name : #ToTopRightPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToTopRightPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element |
	root := aWindow anchorRoot.
	element := aWindow element.
	aWindow root width: element width.
	aWindow position: (element bounds inParent: root) topRight - (0 @ (aWindow root measuredHeight))
]
