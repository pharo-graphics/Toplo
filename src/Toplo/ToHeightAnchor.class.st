Class {
	#name : #ToHeightAnchor,
	#superclass : #ToAxisAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToHeightAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ Rectangle
		  origin: aRectangle origin x @ (aRectangle origin y + element margin top)
		  extent: aRectangle width @ aValue
]

{ #category : #testing }
ToHeightAnchor >> isMeasurement [

	^ true
]

{ #category : #applying }
ToHeightAnchor >> valueForChild: aChildElement withBoundsRectangle: aRectangle [

	^ aRectangle height - element margin height
]
