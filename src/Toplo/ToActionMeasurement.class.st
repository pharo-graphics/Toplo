Class {
	#name : #ToActionMeasurement,
	#superclass : #ToElementMeasurement,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #accessing }
ToActionMeasurement >> action: aValuable [
	" aValuable takes the anElement and the event as arguments "

	action := aValuable
]

{ #category : #api }
ToActionMeasurement >> onMeasure: anExtentMeasurementSpec element: anElement onEvent: anEvent [

	action value: anElement value: anEvent 
]
