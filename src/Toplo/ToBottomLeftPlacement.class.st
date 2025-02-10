Class {
	#name : #ToBottomLeftPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToBottomLeftPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element |
	root := aWindow anchorRoot.
	element := aWindow element.
	aWindow root width: element width.
	aWindow position: (element bounds inParent: root) bottomLeft - (aWindow root measuredWidth @ 0)
]
