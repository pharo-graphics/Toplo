Class {
	#name : #ToElementBottomAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementBottomAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	y := aValue - (self readRectangle: aRectangle).
	x := aRectangle left.
	^ Rectangle
		  origin: x @ y
		  extent: aRectangle extent
]

{ #category : #applying }
ToElementBottomAnchor >> readRectangle: aRectangle [ 

	^ aRectangle bottom
]
