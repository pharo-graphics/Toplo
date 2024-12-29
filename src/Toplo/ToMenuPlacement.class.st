Class {
	#name : #ToMenuPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToMenuPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element pos |
	root := aWindow anchorRoot.
	element := aWindow element.

	pos := element isSubmenu
		       ifTrue: [ (element bounds inParent: root) topRight ]
		       ifFalse: [ (element bounds inParent: root) bottomLeft ].
	aWindow position: pos
]
