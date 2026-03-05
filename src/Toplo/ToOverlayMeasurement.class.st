Class {
	#name : #ToOverlayMeasurement,
	#superclass : #ToElementCustomMeasurement,
	#category : #'Toplo-Layout-Support'
}

{ #category : #api }
ToOverlayMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	anExtentMeasurementSpec widthSpec beExact: anElement anchorElement measuredWidth.
	anExtentMeasurementSpec heightSpec beExact: anElement anchorElement measuredHeight
]
