Class {
	#name : #ToElementCenterAnchor,
	#superclass : #ToElementAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementCenterAnchor >> applyOnRectangle: aRectangle withValue: aValue withMargin: anInsets [

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
ToElementCenterAnchor >> read: aRectangle withMargin: margin [

	^ aRectangle center
]
