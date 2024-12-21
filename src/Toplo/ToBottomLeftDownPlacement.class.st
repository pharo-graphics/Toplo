Class {
	#name : #ToBottomLeftDownPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToBottomLeftDownPlacement >> arrangeWindowFromManager: aManager onEvent: anEvent [

	| window root element |
	window := aManager currentWindow.
	root := aManager anchorRoot.
	element := aManager element.
	window position: (element bounds inParent: root) bottomLeft
]
