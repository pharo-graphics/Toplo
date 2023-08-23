Class {
	#name : #ToTripletWithExactInterspaceStrategy,
	#superclass : #ToTripletWithInterspaceStrategy,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #accessing }
ToTripletWithExactInterspaceStrategy >> height: anInteger [

	interspace constraintsDo: [ :c |
		c horizontal exact: 0.
		c vertical exact: anInteger ]
]

{ #category : #accessing }
ToTripletWithExactInterspaceStrategy >> interspaceHeight [

	^ interspace requestedHeight 
]

{ #category : #accessing }
ToTripletWithExactInterspaceStrategy >> interspaceWidth [

	^ interspace requestedWidth
]

{ #category : #layout }
ToTripletWithExactInterspaceStrategy >> onMeasure: anExtentMeasurementSpec in: aTriplet [

	" nothing to do, interspace is with exact size "

	^ true 
]

{ #category : #accessing }
ToTripletWithExactInterspaceStrategy >> width: anInteger [

	interspace constraintsDo: [ :c |
		c horizontal exact: anInteger.
		c vertical exact: 0 ]
]
