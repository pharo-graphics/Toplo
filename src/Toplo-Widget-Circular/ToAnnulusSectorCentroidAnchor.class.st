Class {
	#name : #ToAnnulusSectorCentroidAnchor,
	#superclass : #BlElementLocationAnchor,
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #applying }
ToAnnulusSectorCentroidAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| pt |
	pt := self valueInBounds: aRectangle.
	^ BlBounds origin: pt extent: aRectangle extent
]

{ #category : #applying }
ToAnnulusSectorCentroidAnchor >> valueInBounds: aBounds [

	^ self element centroid + aBounds topLeft
]
