Class {
	#name : #ToElementWidthAnchor,
	#superclass : #ToElementAxisAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementWidthAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ Rectangle origin: aRectangle origin extent: aValue @ aRectangle height
]

{ #category : #testing }
ToElementWidthAnchor >> isMeasurement [

	^ true
]

{ #category : #applying }
ToElementWidthAnchor >> valueInBounds: aBounds [

	^ aBounds width
]
