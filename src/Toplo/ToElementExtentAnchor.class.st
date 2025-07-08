Class {
	#name : #ToElementExtentAnchor,
	#superclass : #ToElementAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementExtentAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ Rectangle origin: aRectangle origin extent: aValue
]

{ #category : #testing }
ToElementExtentAnchor >> isMeasurement [

	^ true
]

{ #category : #applying }
ToElementExtentAnchor >> valueInBounds: aBounds [

	^ aBounds extent
]
