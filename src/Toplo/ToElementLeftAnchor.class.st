Class {
	#name : #ToElementLeftAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementLeftAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	x := aValue - (self readRectangle: aRectangle).
	y := aRectangle top.
	^ Rectangle
		  origin: x @ y
		  corner: (x + aRectangle width) @ (y + aRectangle height)
]

{ #category : #applying }
ToElementLeftAnchor >> readRectangle: aRectangle [

	^ aRectangle left 
]
