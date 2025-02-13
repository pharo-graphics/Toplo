Class {
	#name : #ToSameWidthMeasurement,
	#superclass : #ToWindowMeasurement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToSameWidthMeasurement >> onMeasure: anExtentMeasurementSpec window: aWindow onEvent: anEvent [

	anExtentMeasurementSpec widthSpec size: aWindow element measuredWidth
]
