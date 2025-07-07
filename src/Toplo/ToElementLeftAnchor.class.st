Class {
	#name : #ToElementLeftAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementLeftAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| x y |
	x := aValue - (self valueInBounds: aRectangle).
	y := aRectangle top.
	^ Rectangle
		  origin: x @ y
		  corner: (x + aRectangle width) @ (y + aRectangle height)
]

{ #category : #applying }
ToElementLeftAnchor >> valueInBounds: aBounds [

	^ aBounds left
]
