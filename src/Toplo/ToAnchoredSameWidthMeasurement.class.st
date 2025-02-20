Class {
	#name : #ToAnchoredSameWidthMeasurement,
	#superclass : #ToElementCustomMeasurement,
	#category : #'Toplo-Core-Support'
}

{ #category : #api }
ToAnchoredSameWidthMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	anExtentMeasurementSpec widthSpec beExact:
		anElement anchorElement measuredWidth
]
