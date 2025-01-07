Class {
	#name : #ToMenuPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #api }
ToMenuPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element pos rootMenuOrMenuBar |
	root := aWindow anchorRoot.
	element := aWindow element.
	rootMenuOrMenuBar := element rootMenuWindowOrMenuBar.

	pos := (element isSubmenu or: [
		        rootMenuOrMenuBar notNil and: [
			        rootMenuOrMenuBar isVertical ] ])
		       ifTrue: [ (element bounds inParent: root) topRight ]
		       ifFalse: [ (element bounds inParent: root) bottomLeft ].
	aWindow position: pos
]
