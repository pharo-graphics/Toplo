Class {
	#name : #ToPickedPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToPickedPlacement >> arrangeWindowFromManager: aManager onEvent: anEvent [

	| window |
	window := aManager currentWindow.

	anEvent ifNil: [ ^ self ].
	window position: anEvent position
]
