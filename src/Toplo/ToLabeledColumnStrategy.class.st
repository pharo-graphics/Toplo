Class {
	#name : #ToLabeledColumnStrategy,
	#superclass : #ToLabeledWithInterspaceStrategy,
	#instVars : [
		'width'
	],
	#category : #'Toplo-Core-Labeled'
}

{ #category : #'t - labeled presentation' }
ToLabeledColumnStrategy >> columnWidth [

	^ self width
]

{ #category : #initialization }
ToLabeledColumnStrategy >> initialize [ 

	super initialize.
	width := 0
]

{ #category : #layout }
ToLabeledColumnStrategy >> onMeasure: anExtentMeasurementSpec in: aLabeled [

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
ToLabeledColumnStrategy >> width [

	^ width
]

{ #category : #accessing }
ToLabeledColumnStrategy >> width: anInteger [

	width := anInteger
]
