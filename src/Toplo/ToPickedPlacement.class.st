Class {
	#name : #ToPickedPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToPickedPlacement >> positionWindow: aWindow onEvent: anEvent [

	anEvent ifNil: [ ^ self ].
	aWindow position: anEvent position
]
