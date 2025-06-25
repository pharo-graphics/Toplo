Class {
	#name : #ToElementBottomAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementBottomAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ aRectangle translateBy: 0 @ (aValue - aRectangle bottom)
]

{ #category : #applying }
ToElementBottomAnchor >> readRectangle: aRectangle [ 

	^ aRectangle bottom + element margin bottom
]
