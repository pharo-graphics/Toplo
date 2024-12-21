Class {
	#name : #ToPickedPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToPickedPlacement >> arrangeWindow: aWindow forElement: anElement fromEvent: anEvent in: aRootElement [

	anEvent ifNil: [ ^ self ].
	aWindow position: anEvent position
]
