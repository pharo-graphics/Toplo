Class {
	#name : #ToElementRightAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementRightAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	x := aValue - (self readRectangle: aRectangle).
	y := aRectangle top.
	^ Rectangle
		  origin: x @ y
		  corner: (x + aRectangle width) @ (y + aRectangle height)
]

{ #category : #applying }
ToElementRightAnchor >> readRectangle: aRectangle [ 

	^ aRectangle right
]
