Class {
	#name : #ToTripletWithSpacingStrategy,
	#superclass : #ToTripletWithInterspaceStrategy,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #accessing }
ToTripletWithSpacingStrategy >> height: anInteger [

	interspace constraintsDo: [ :c |
		c horizontal exact: 0.
		c vertical exact: anInteger ]
]

{ #category : #layout }
ToTripletWithSpacingStrategy >> onMeasure: anExtentMeasurementSpec in: aLabeled [

	" nothing to do, interspace is with exact size "

	^ true 
]

{ #category : #accessing }
ToTripletWithSpacingStrategy >> width: anInteger [

	interspace constraintsDo: [ :c |
		c horizontal exact: anInteger.
		c vertical exact: 0 ]
]
