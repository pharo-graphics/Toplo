Class {
	#name : #ToAnchoredSameWidthMeasurement,
	#superclass : #ToElementCustomMeasurement,
	#category : #'Toplo-Layout-Support'
}

{ #category : #api }
ToAnchoredSameWidthMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	anExtentMeasurementSpec widthSpec beExact:
		anElement anchorElement measuredWidth
]
