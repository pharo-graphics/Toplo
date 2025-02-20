Class {
	#name : #ToElementCustomMeasurement,
	#superclass : #Object,
	#category : #'Toplo-Core-Support'
}

{ #category : #api }
ToElementCustomMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement [

	self
		onMeasure: anExtentMeasurementSpec
		element: anElement
		onEvent: nil
]

{ #category : #api }
ToElementCustomMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	self subclassResponsibility 

]
