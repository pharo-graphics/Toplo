Class {
	#name : #ToPairColumnStrategy,
	#superclass : #ToPairWithInterspaceStrategy,
	#instVars : [
		'width'
	],
	#category : #'Toplo-Core-Pair'
}

{ #category : #'t - labeled presentation' }
ToPairColumnStrategy >> columnWidth [

	^ self width
]

{ #category : #initialization }
ToPairColumnStrategy >> initialize [ 

	super initialize.
	width := 0
]

{ #category : #layout }
ToPairColumnStrategy >> onMeasure: anExtentMeasurementSpec in: aPair [

	" return true if the measure is up-to-date "

	" note that cell spacing is not compatible with left column sizing "
	" get the left side element and then its width "
	| first lw w |
	
	first := aPair direction isLeftToRight
		        ifTrue: [ aPair first ]
		        ifFalse: [ aPair second ].

	lw := first ifNil: [ 0 ] ifNotNil: [ first measuredWidth ].
	" now measure the gap according to leftColumnWidth "
	w := self width - lw max: 0.

	interspace measuredWidth = w ifTrue: [ ^ true ].
	interspace size: w @ 5.
	^ false
]

{ #category : #accessing }
ToPairColumnStrategy >> width [

	^ width
]

{ #category : #accessing }
ToPairColumnStrategy >> width: anInteger [

	width := anInteger
]
