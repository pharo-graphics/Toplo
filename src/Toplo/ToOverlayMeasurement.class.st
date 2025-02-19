Class {
	#name : #ToOverlayMeasurement,
	#superclass : #ToElementMeasurement,
	#category : #'Toplo-Core-Support'
}

{ #category : #api }
ToOverlayMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	anExtentMeasurementSpec widthSpec beExact: anElement anchorElement measuredWidth.
	anExtentMeasurementSpec heightSpec beExact: anElement anchorElement measuredHeight
]
