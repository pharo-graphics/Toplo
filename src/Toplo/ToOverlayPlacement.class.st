Class {
	#name : #ToOverlayPlacement,
	#superclass : #ToTopLeftDownPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToOverlayPlacement >> arrangeWindow: aWindow forElement: anElement fromEvent: anEvent in: aRootElement [

	super arrangeWindow: aWindow forElement: anElement fromEvent: anEvent in: aRootElement.
	aWindow size: anElement measuredWidth @ anElement measuredHeight.
]
