Class {
	#name : #ToTopLeftDownPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToTopLeftDownPlacement >> arrangeWindow: aWindow forElement: anElement fromEvent: anEvent in: aRootElement [

	aWindow position: (anElement bounds inParent: aRootElement) topLeft.

]
