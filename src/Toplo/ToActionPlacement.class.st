Class {
	#name : #ToActionPlacement,
	#superclass : #ToElementCustomPlacement,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Support'
}

{ #category : #accessing }
ToActionPlacement >> action: aValuable [
	" aValuable takes the anElement and the event as arguments "

	action := aValuable
]

{ #category : #'api - displaying' }
ToActionPlacement >> positionElement: aWindow onEvent: anEvent context: aBlElementBoundsUpdater [

	action cull: aWindow cull: anEvent cull: aBlElementBoundsUpdater
]
