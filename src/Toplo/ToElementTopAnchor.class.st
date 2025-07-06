Class {
	#name : #ToElementTopAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementTopAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	y := aValue - (self readRectangle: aRectangle).
	x := aRectangle left.
	^ Rectangle
		  origin: x @ y
		  corner: (x + aRectangle width) @ (y + aRectangle height)
]

{ #category : #applying }
ToElementTopAnchor >> readRectangle: aRectangle [ 

	^ aRectangle top 
]
