Class {
	#name : #ToTopLeftPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToTopLeftPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element |
	root := aWindow anchorRoot.
	element := aWindow element.
	aWindow root width: element width.
	aWindow position: (element bounds inParent: root) topLeft - (0 @ (aWindow root measuredHeight))
]
