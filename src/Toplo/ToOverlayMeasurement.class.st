Class {
	#name : #ToOverlayMeasurement,
	#superclass : #ToWindowMeasurement,
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToOverlayMeasurement >> measureWindow: aWindow onEvent: anEvent [

	aWindow size: aWindow element measuredWidth @ aWindow element measuredHeight
]
