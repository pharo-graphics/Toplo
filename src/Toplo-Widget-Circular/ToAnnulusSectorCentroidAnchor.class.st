Class {
	#name : #ToAnnulusSectorCentroidAnchor,
	#superclass : #BlElementLocationAnchor,
	#instVars : [
		'offset'
	],
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #applying }
ToAnnulusSectorCentroidAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| pt |
	pt := self valueInBounds: aRectangle.
	^ BlBounds origin: pt extent: aRectangle extent
]

{ #category : #accessing }
ToAnnulusSectorCentroidAnchor >> offset [

	^ offset ifNil: [ offset := 0 ]
]

{ #category : #accessing }
ToAnnulusSectorCentroidAnchor >> offset: aNumber [

	offset := aNumber
]

{ #category : #applying }
ToAnnulusSectorCentroidAnchor >> pointFromCentroid: centroid awayFromCenter: center atDistance: d [

	| direction unit |
	direction := centroid - center.
	direction isZero ifTrue: [ ^ centroid ].

	unit := direction normalized.
	^ centroid + (unit * d)
]

{ #category : #applying }
ToAnnulusSectorCentroidAnchor >> valueInBounds: aBounds [

	^ self
		  pointFromCentroid: self element centroid
		  awayFromCenter: aBounds center
		  atDistance: self offset
]
