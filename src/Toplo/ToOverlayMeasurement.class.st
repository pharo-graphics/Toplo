Class {
	#name : #ToOverlayMeasurement,
	#superclass : #ToElementMeasurement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToOverlayMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	anElement size: anElement anchorElement measuredWidth
		@ anElement anchorElement measuredHeight
]
