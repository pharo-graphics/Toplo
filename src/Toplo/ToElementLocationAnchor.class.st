Class {
	#name : #ToElementLocationAnchor,
	#superclass : #ToElementAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementLocationAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	| w h x1 y1 pt |
	pt := self readRectangle: aRectangle.
	w := pt x.
	h := pt y.
	x1 := aValue x - w.
	y1 := aValue y - h.
	^ Rectangle
		  origin: x1 @ y1
		  corner: (x1 + aRectangle width) @ (y1 + aRectangle height)
]
