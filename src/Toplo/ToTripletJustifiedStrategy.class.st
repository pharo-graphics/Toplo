Class {
	#name : #ToTripletJustifiedStrategy,
	#superclass : #ToTripletWithInterspaceStrategy,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #initialization }
ToTripletJustifiedStrategy >> initialize [

	super initialize.
	interspace constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]

]

{ #category : #testing }
ToTripletJustifiedStrategy >> isJustified [

	^ true
]

{ #category : #layout }
ToTripletJustifiedStrategy >> onMeasure: anExtentMeasurementSpec in: aLabeled [

	" nothing to do, interspace is setup in #initialize "

	^ true 
]
