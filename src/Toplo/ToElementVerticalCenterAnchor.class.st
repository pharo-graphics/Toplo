Class {
	#name : #ToElementVerticalCenterAnchor,
	#superclass : #ToElementAxisAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementVerticalCenterAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| h y1 |
	h := aRectangle height // 2.
	y1 := aValue - h.
	^ Rectangle
		  origin: aRectangle origin x @ y1
		  corner: aRectangle corner x @ (y1 + aRectangle height)
]

{ #category : #applying }
ToElementVerticalCenterAnchor >> valueInBounds: aBounds [

	^ aBounds center y
]
