Trait {
	#name : #TToPair,
	#instVars : [
		'first',
		'second',
		'strategy'
	],
	#category : #'Toplo-Core-Pair'
}

{ #category : #'t - pair presentation' }
TToPair >> beJustified [

	self strategy: ToPairJustifiedStrategy new
 
]

{ #category : #'t - pair presentation' }
TToPair >> columnWidth [

	^ strategy
		  ifNil: [ 0 ]
		  ifNotNil: [ :strat | strat columnWidth ]
]

{ #category : #'t - pair presentation' }
TToPair >> columnWidth: anInteger [

	self strategy: (ToPairColumnStrategy new width: anInteger)
]

{ #category : #'t - pair presentation' }
TToPair >> direction [

	^ self layout direction
]

{ #category : #'t - pair presentation' }
TToPair >> direction: aLayoutDirection [

	self layout direction: aLayoutDirection.
	self requestLayout
]

{ #category : #'t - pair accessing' }
TToPair >> first [

	^ first
]

{ #category : #'t - pair accessing' }
TToPair >> first: anElement [

	first = anElement ifTrue: [ ^ self ].
	first := anElement.
	first ifNotNil: [ 
		first constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	self privateUpdateChildren
]

{ #category : #'t - pair initialization' }
TToPair >> initializePair [

	self layout: BlLinearLayout horizontal.
	self strategy: ToPairWithoutInterspaceStrategy new.
	self fitContent
]

{ #category : #'t - pair presentation' }
TToPair >> isJustified [

	^ strategy ifNil: [ false ] ifNotNil: [ :strat | strat isJustified ]
]

{ #category : #layout }
TToPair >> onMeasure: anExtentMeasurementSpec [

	" send to super before to ensure the children are already measured "

	super onMeasure: anExtentMeasurementSpec.
	(self strategy onMeasure: anExtentMeasurementSpec in: self) 
		ifFalse: [ " re-launch measuring if necessary" 
			self onMeasure: anExtentMeasurementSpec ]
]

{ #category : #'t - pair private' }
TToPair >> privateUpdateChildren [

	strategy ifNil: [ ^ self ].
	strategy updateChildrenIn: self
]

{ #category : #'t - pair accessing' }
TToPair >> second [

	^ second
]

{ #category : #'t - pair accessing' }
TToPair >> second: anElement [

	second = anElement ifTrue: [ ^ self ].
	second := anElement.
	second ifNotNil: [ 
		second constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	self privateUpdateChildren
]

{ #category : #'t - pair accessing' }
TToPair >> strategy [

	^ strategy ifNil: [ strategy := ToPairWithoutInterspaceStrategy ]
]

{ #category : #'t - pair accessing' }
TToPair >> strategy: aPairStrategy [

	strategy := aPairStrategy.
	self privateUpdateChildren
]
