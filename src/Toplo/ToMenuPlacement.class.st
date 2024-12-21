Class {
	#name : #ToMenuPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToMenuPlacement >> arrangeWindow: aWindow forElement: anElement fromEvent: anEvent in: aRoot [

	| pos |
	pos := anElement isSubmenu
		       ifTrue: [ (anElement bounds inParent: aRoot) topRight ]
		       ifFalse: [ (anElement bounds inParent: aRoot) bottomLeft ].
	aWindow position: pos
]
