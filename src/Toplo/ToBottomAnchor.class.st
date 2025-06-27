Class {
	#name : #ToBottomAnchor,
	#superclass : #ToEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToBottomAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ aRectangle translateBy: 0 @ (aValue - aRectangle bottom)
]

{ #category : #applying }
ToBottomAnchor >> valueForChild: aChildElement withBoundsRectangle: aRectangle [

	^ aRectangle bottom + element margin bottom
]
