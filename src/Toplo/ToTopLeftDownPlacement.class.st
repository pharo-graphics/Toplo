Class {
	#name : #ToTopLeftDownPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToTopLeftDownPlacement >> arrangeWindowFromManager: aManager onEvent: anEvent [

	| window root element pos |
	window := aManager currentWindow.
	root := aManager anchorRoot.
	element := aManager element.
	pos := (element bounds inParent: root) topLeft.
	window position: pos

]
