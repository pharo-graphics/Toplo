Class {
	#name : #ToMenuPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToMenuPlacement >> arrangeWindowFromManager: aManager onEvent: anEvent [

	| window root element pos |
	window := aManager currentWindow.
	root := aManager anchorRoot.
	element := aManager element.

	pos := element isSubmenu
		       ifTrue: [ (element bounds inParent: root) topRight ]
		       ifFalse: [ (element bounds inParent: root) bottomLeft ].
	window position: pos
]
