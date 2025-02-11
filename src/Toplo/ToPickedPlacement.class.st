Class {
	#name : #ToPickedPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToPickedPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	anEvent ifNil: [ ^ self ].
	aWindow position: anEvent position
]
