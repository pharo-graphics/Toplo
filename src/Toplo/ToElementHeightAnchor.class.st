Class {
	#name : #ToElementHeightAnchor,
	#superclass : #ToElementAxisAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementHeightAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	^ Rectangle
		  origin: aRectangle origin + element margin topLeft + element margin bottomRight
		  extent: aRectangle width @ aValue
]

{ #category : #testing }
ToElementHeightAnchor >> isMeasurement [

	^ true
]

{ #category : #applying }
ToElementHeightAnchor >> readRectangle: aRectangle [ 

	^ aRectangle height + element margin height
]
