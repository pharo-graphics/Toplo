Class {
	#name : #ToSameWidthMeasurement,
	#superclass : #ToWindowMeasurement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToSameWidthMeasurement >> measureWindow: aWindow onEvent: anEvent [

	aWindow width: aWindow element measuredWidth 
]
