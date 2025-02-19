Class {
	#name : #ToAnchoredSameWidthMeasurement,
	#superclass : #ToElementMeasurement,
	#category : #'Toplo-Core-Support'
}

{ #category : #api }
ToAnchoredSameWidthMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	anExtentMeasurementSpec widthSpec beExact:
		anElement anchorElement measuredWidth
]
