Class {
	#name : #ToActionMeasurement,
	#superclass : #ToElementCustomMeasurement,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Support'
}

{ #category : #accessing }
ToActionMeasurement >> action: aValuable [
	" aValuable takes the ExtentMeasurementSpec, the element and the event as arguments "

	action := aValuable
]

{ #category : #initialization }
ToActionMeasurement >> initialize [ 

	super initialize.
	action := [ :anExtentMeasurementSpec :element :event | ]
	
]

{ #category : #api }
ToActionMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	action value: anExtentMeasurementSpec value: anElement value: anEvent 
]
