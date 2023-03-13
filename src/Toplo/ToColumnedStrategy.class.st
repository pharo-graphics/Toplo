Class {
	#name : #ToColumnedStrategy,
	#superclass : #Object,
	#category : #'Toplo-Core-Pair'
}

{ #category : #layout }
ToColumnedStrategy >> childrenIn: aColumned [

	^ aColumned elements
]

{ #category : #accessing }
ToColumnedStrategy >> columnWidth [

	^ 0
]

{ #category : #accessing }
ToColumnedStrategy >> isJustified [

	^ false
]

{ #category : #layout }
ToColumnedStrategy >> onMeasure: anExtentMeasurementSpec in: aColumned [

	" return true if the measure is up-to-date "

	" note that cell spacing is not compatible with left column sizing "
	" get the left side element and then its width "
	| first lw w |
	
	first := aColumned direction isLeftToRight
		        ifTrue: [ aColumned first ]
		        ifFalse: [ aColumned second ].

	lw := first ifNil: [ 0 ] ifNotNil: [ first measuredWidth ].
	" now measure the gap according to leftColumnWidth "
	w := self width - lw max: 0 - aColumned padding left.

	aColumned measuredWidth = w ifTrue: [ ^ true ].
	aColumned size: w @ 5.
	^ false
]

{ #category : #layout }
ToColumnedStrategy >> updateChildrenIn: aPair [

	| subs |
	
	subs := self childrenIn: aPair.
	aPair children asArray = subs ifTrue: [ ^ self ].
	aPair eventDispatcher disableLayoutChanged.
	aPair removeChildren.
	aPair eventDispatcher enableLayoutChanged.
	aPair addChildren: subs
]
