Class {
	#name : #ToActionMeasurement,
	#superclass : #ToWindowMeasurement,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #accessing }
ToActionMeasurement >> action: aValuable [
	" aValuable takes the window and the event as arguments "

	action := aValuable
]

{ #category : #api }
ToActionMeasurement >> arrangeWindow: aWindow onEvent: anEvent [

	action value: aWindow value: anEvent 
]
