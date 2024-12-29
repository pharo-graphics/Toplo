Class {
	#name : #ToBottomLeftDownPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToBottomLeftDownPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element |
	root := aWindow anchorRoot.
	element := aWindow element.
	aWindow position: (element bounds inParent: root) bottomLeft
]
