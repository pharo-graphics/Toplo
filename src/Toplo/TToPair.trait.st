Trait {
	#name : #TToPair,
	#instVars : [
		'first',
		'second',
		'strategy'
	],
	#category : #'Toplo-Core-Pair'
}

{ #category : #'t - labeled presentation' }
TToPair >> beJustified [

	self strategy: ToPairJustifiedStrategy new
 
]

{ #category : #'t - labeled presentation' }
TToPair >> columnWidth [

	^ strategy
		  ifNil: [ 0 ]
		  ifNotNil: [ :strat | strat columnWidth ]
]

{ #category : #'t - labeled presentation' }
TToPair >> columnWidth: anInteger [

	self strategy: (ToPairColumnStrategy new width: anInteger)
]

{ #category : #accessing }
TToPair >> first [

	^ first
]

{ #category : #accessing }
TToPair >> first: anElement [

	first = anElement ifTrue: [ ^ self ].
	first := anElement.
	first ifNotNil: [ 
		first constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	self privateUpdateChildren
]

{ #category : #'t - labeled initialization' }
TToPair >> initializePair [

	self layout: BlLinearLayout horizontal.
	self strategy: ToPairWithoutInterspaceStrategy new.
	self fitContent
]

{ #category : #'t - labeled presentation' }
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

{ #category : #'t - labeled private' }
TToPair >> privateUpdateChildren [

	strategy ifNil: [ ^ self ].
	strategy updateChildrenIn: self
]

{ #category : #accessing }
TToPair >> second [

	^ second
]

{ #category : #accessing }
TToPair >> second: anElement [

	second = anElement ifTrue: [ ^ self ].
	second := anElement.
	second ifNotNil: [ 
		second constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ] ].

	self privateUpdateChildren
]

{ #category : #'t - labeled accessing' }
TToPair >> strategy [

	^ strategy ifNil: [ strategy := ToLabeledWithoutInterspaceStrategy ]
]

{ #category : #'t - labeled accessing' }
TToPair >> strategy: aPairStrategy [

	strategy := aPairStrategy.
	self privateUpdateChildren
]
