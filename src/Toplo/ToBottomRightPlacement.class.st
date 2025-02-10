Class {
	#name : #ToBottomRightPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToBottomRightPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element |
	root := aWindow anchorRoot.
	element := aWindow element.
	aWindow root width: element width.
	aWindow position: (element bounds inParent: root) bottomRight 
]
