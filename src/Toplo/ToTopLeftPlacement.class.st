Class {
	#name : #ToTopLeftPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToTopLeftPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element |
	root := aWindow anchorRoot.
	element := aWindow element.
	aWindow position: (element bounds inParent: root) topLeft
		- (aWindow measuredWidth @ aWindow measuredHeight)
]
