Class {
	#name : #ToTripletColumnStrategy,
	#superclass : #ToTripletWithInterspaceStrategy,
	#instVars : [
		'width'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'t - labeled presentation' }
ToTripletColumnStrategy >> columnWidth [

	^ self width
]

{ #category : #initialization }
ToTripletColumnStrategy >> initialize [ 

	super initialize.
	width := 0
]

{ #category : #layout }
ToTripletColumnStrategy >> onMeasure: anExtentMeasurementSpec in: aPair [
	" return true if the measure is up-to-date "

	" note that cell spacing is not compatible with left column sizing "

	" get the left side element and then its width "

	| first lw w |
	(self hasInterspaceIn: aPair) ifFalse: [ ^ true ].

	first := aPair direction isLeftToRight
		         ifTrue: [ aPair first ]
		         ifFalse: [ aPair second ].

	lw := first ifNil: [ 0 ] ifNotNil: [ first measuredWidth ].
	" now measure the gap according to leftColumnWidth "
	w := self width - lw max: aPair padding left negated.

	interspace measuredWidth = w ifTrue: [ ^ true ].
	interspace size: w @ 0.
	^ false
]

{ #category : #accessing }
ToTripletColumnStrategy >> width [

	^ width
]

{ #category : #accessing }
ToTripletColumnStrategy >> width: anInteger [

	width := anInteger
]
