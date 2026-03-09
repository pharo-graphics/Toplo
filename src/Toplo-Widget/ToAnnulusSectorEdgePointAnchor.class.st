Class {
	#name : #ToAnnulusSectorEdgePointAnchor,
	#superclass : #BlElementLocationAnchor,
	#category : #'Toplo-Widget-Circular'
}

{ #category : #applying }
ToAnnulusSectorEdgePointAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| pt |
	pt := self valueInBounds: aRectangle.
	^ BlBounds origin: pt extent: aRectangle extent
]

{ #category : #applying }
ToAnnulusSectorEdgePointAnchor >> valueInBounds: aBounds [

	^ self element edgePoint + aBounds topLeft
]
