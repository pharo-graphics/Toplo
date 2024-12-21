Class {
	#name : #ToOverlayPlacement,
	#superclass : #ToTopLeftDownPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToOverlayPlacement >> arrangeWindowFromManager: aManager onEvent: anEvent [

	| window element |
	window := aManager currentWindow.
	element := aManager element.

	super arrangeWindowFromManager: aManager onEvent: anEvent.
	window size: element measuredWidth @ element measuredHeight
]
