Class {
	#name : #ToHorizontalCenterAnchor,
	#superclass : #ToAxisAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToHorizontalCenterAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| w x1 |
	w := aRectangle width // 2.
	x1 := aValue - w.
	^ Rectangle
		  origin: x1 @ aRectangle origin y
		  corner: (x1 + aRectangle width) @ aRectangle corner y
]

{ #category : #applying }
ToHorizontalCenterAnchor >> valueForChild: aChildElement withBoundsRectangle: aRectangle [

	^ aRectangle center x
]
