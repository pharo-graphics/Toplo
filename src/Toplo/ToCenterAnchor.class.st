Class {
	#name : #ToCenterAnchor,
	#superclass : #ToElementAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToCenterAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| w h x1 y1 |
	w := aRectangle width // 2.
	h := aRectangle height // 2.
	x1 := aValue x - w.
	y1 := aValue y - h.
	^ Rectangle
		  origin: x1 @ y1
		  corner: (x1 + aRectangle width) @ (y1 + aRectangle height)
]

{ #category : #applying }
ToCenterAnchor >> valueForChild: aChildElement withBoundsRectangle: aRectangle [
	^ aRectangle center
]
