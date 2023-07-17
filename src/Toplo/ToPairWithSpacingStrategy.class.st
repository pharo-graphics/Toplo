Class {
	#name : #ToPairWithSpacingStrategy,
	#superclass : #ToPairWithInterspaceStrategy,
	#category : #'Toplo-Core-Pair'
}

{ #category : #accessing }
ToPairWithSpacingStrategy >> height: anInteger [

	interspace constraintsDo: [ :c |
		c horizontal exact: 0.
		c vertical exact: anInteger ]
]

{ #category : #layout }
ToPairWithSpacingStrategy >> onMeasure: anExtentMeasurementSpec in: aLabeled [

	" nothing to do, interspace is with exact size "

	^ true 
]

{ #category : #accessing }
ToPairWithSpacingStrategy >> width: anInteger [

	interspace constraintsDo: [ :c |
		c horizontal exact: anInteger.
		c vertical exact: 0 ]
]
