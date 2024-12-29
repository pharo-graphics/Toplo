Class {
	#name : #ToPickedPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToPickedPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	anEvent ifNil: [ ^ self ].
	aWindow position: anEvent position
]
