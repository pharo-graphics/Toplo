Class {
	#name : #ToPairJustifiedStrategy,
	#superclass : #ToPairWithInterspaceStrategy,
	#category : #'Toplo-Core-Pair'
}

{ #category : #initialization }
ToPairJustifiedStrategy >> initialize [

	super initialize.
	interspace constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]

]

{ #category : #testing }
ToPairJustifiedStrategy >> isJustified [

	^ true
]

{ #category : #layout }
ToPairJustifiedStrategy >> onMeasure: anExtentMeasurementSpec in: aLabeled [

	" nothing to do, interspace is setup in #initialize "

	^ true 
]
