Class {
	#name : #ToPickedPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #'api - displaying' }
ToPickedPlacement >> positionWindow: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [

	anEvent ifNil: [ ^ self ].
	aWindow position: anEvent position
]
