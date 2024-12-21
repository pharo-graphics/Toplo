Class {
	#name : #ToBottomLeftDownPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToBottomLeftDownPlacement >> arrangeWindow: aWindow forElement: anElement fromEvent: anEvent in: aRootElement [

	aWindow position: (anElement bounds inParent: aRootElement) bottomLeft
]
