Class {
	#name : #ToLabelMultiLineTextElement,
	#superclass : #BlTextElement,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #initialization }
ToLabelMultiLineTextElement >> initializeMeasurement [

	" Need Label measurement to ensure right vertical alignement with labels/menus "
	self flag: 'To be checked'.
	self labelMeasurement
]
