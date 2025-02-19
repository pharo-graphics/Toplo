Class {
	#name : #ToSameWidthMeasurement,
	#superclass : #ToElementMeasurement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToSameWidthMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	anExtentMeasurementSpec widthSpec size:
		anElement anchorElement measuredWidth
]
