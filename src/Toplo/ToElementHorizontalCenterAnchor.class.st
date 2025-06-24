Class {
	#name : #ToElementHorizontalCenterAnchor,
	#superclass : #ToElementAxisAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementHorizontalCenterAnchor >> applyOnRectangle: aRectangle withValue: aValue withMargin: anInsets [

	| w x1 |
	w := aRectangle width // 2.
	x1 := aValue - w.
	^ Rectangle
		  origin: x1 @ aRectangle origin y
		  corner: (x1 + aRectangle width) @ aRectangle corner y
]

{ #category : #applying }
ToElementHorizontalCenterAnchor >> read: aRectangle withMargin: margin [

	^ aRectangle center x
]
