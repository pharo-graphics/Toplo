Class {
	#name : #ToLabeledJustifiedStrategy,
	#superclass : #ToLabeledWithInterspaceStrategy,
	#category : #'Toplo-Core-Labeled'
}

{ #category : #initialization }
ToLabeledJustifiedStrategy >> initialize [

	super initialize.
	interspace constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]

]

{ #category : #testing }
ToLabeledJustifiedStrategy >> isJustified [

	^ true
]

{ #category : #layout }
ToLabeledJustifiedStrategy >> onMeasure: anExtentMeasurementSpec in: aLabeled [

	" nothing to do, interspace is setup in #initialize "

	^ true 
]
