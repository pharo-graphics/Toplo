Class {
	#name : #ToBottomLeftPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToBottomLeftPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element |
	root := aWindow anchorRoot.
	element := aWindow element.
	aWindow position: (element bounds inParent: root) bottomLeft
		- (aWindow measuredWidth @ 0)
]
