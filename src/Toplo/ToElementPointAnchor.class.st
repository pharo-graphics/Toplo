Class {
	#name : #ToElementPointAnchor,
	#superclass : #ToElementLocationAnchor,
	#instVars : [
		'point'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #accessing }
ToElementPointAnchor >> point [

	^ point
]

{ #category : #accessing }
ToElementPointAnchor >> point: aPoint [

	point := aPoint
]

{ #category : #applying }
ToElementPointAnchor >> valueInBounds: aBounds [

	^ aBounds topLeft + point
]
