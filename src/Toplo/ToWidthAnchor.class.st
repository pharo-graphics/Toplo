Class {
	#name : #ToWidthAnchor,
	#superclass : #ToAxisAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToWidthAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	^ Rectangle
		  origin: aRectangle origin x + element margin left @ aRectangle origin y
		  extent: aValue @ aRectangle height
]

{ #category : #testing }
ToWidthAnchor >> isMeasurement [

	^ true
]

{ #category : #applying }
ToWidthAnchor >> valueForChild: aChildElement withBoundsRectangle: aRectangle [

	^ aRectangle width - element margin width
]
