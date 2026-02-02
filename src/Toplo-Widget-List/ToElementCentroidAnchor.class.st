Class {
	#name : #ToElementCentroidAnchor,
	#superclass : #BlElementLocationAnchor,
	#category : #'Toplo-Widget-List-InnerList-Finite-Circular'
}

{ #category : #applying }
ToElementCentroidAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| pt |
	pt := aValue - (aRectangle extent / 2).
	^ BlBounds origin: pt extent: aRectangle extent
]

{ #category : #applying }
ToElementCentroidAnchor >> valueInBounds: aBounds [

	^ self element centroid
]
