Class {
	#name : #ToLabeledLeftColumnStrategy,
	#superclass : #ToLabeledWithInterspaceStrategy,
	#instVars : [
		'width'
	],
	#category : #'Toplo-Core-Labeled'
}

{ #category : #initialization }
ToLabeledLeftColumnStrategy >> initialize [ 

	super initialize.
	width := 0
]

{ #category : #'t - labeled presentation' }
ToLabeledLeftColumnStrategy >> leftColumnWidth [

	^ self width
]

{ #category : #layout }
ToLabeledLeftColumnStrategy >> onMeasure: anExtentMeasurementSpec in: aLabeled [

	" return true if the measure is up-to-date "

	" note that cell spacing is not compatible with left column sizing "
	" get the left side element and then its width "
	| left lw w |
	left := aLabeled isLabelFirst
		        ifTrue: [ aLabeled label ]
		        ifFalse: [ aLabeled element ].

	lw := left ifNil: [ 0 ] ifNotNil: [ left measuredWidth ].
	" now measure the gap according to leftColumnWidth "
	w := self width - lw max: 0.

	interspace measuredWidth = w ifTrue: [ ^ true ].
	interspace size: w @ 0.
	^ false
]

{ #category : #accessing }
ToLabeledLeftColumnStrategy >> width [

	^ width
]

{ #category : #accessing }
ToLabeledLeftColumnStrategy >> width: anInteger [

	width := anInteger
]
