Trait {
	#name : #TToColumned,
	#instVars : [
		'#elements => ObservableSlot',
		'#strategy => ObservableSlot'
	],
	#category : #'Toplo-Core-Pair'
}

{ #category : #'t - columned presentation' }
TToColumned >> beJustified [

	self strategy: ToPairJustifiedStrategy new
 
]

{ #category : #'t - columned presentation' }
TToColumned >> columnWidth [

	^ strategy
		  ifNil: [ 0 ]
		  ifNotNil: [ :strat | strat columnWidth ]
]

{ #category : #'t - columned presentation' }
TToColumned >> columnWidth: anInteger [

	self strategy: (ToPairColumnStrategy new width: anInteger)
]

{ #category : #'t - columned presentation' }
TToColumned >> direction [

	^ self layout direction
]

{ #category : #'t - columned presentation' }
TToColumned >> direction: aLayoutDirection [

	self layout direction: aLayoutDirection.
	self requestLayout
]

{ #category : #'t - columned initialization' }
TToColumned >> initializeColumned [

	self layout: BlLinearLayout horizontal.
	self strategy: ToPairWithoutInterspaceStrategy new.
	self fitContent
]

{ #category : #'t - columned presentation' }
TToColumned >> isJustified [

	^ strategy ifNil: [ false ] ifNotNil: [ :strat | strat isJustified ]
]

{ #category : #layout }
TToColumned >> onMeasure: anExtentMeasurementSpec [

	" send to super before to ensure the children are already measured "

	super onMeasure: anExtentMeasurementSpec.
	(self strategy onMeasure: anExtentMeasurementSpec in: self) 
		ifFalse: [ " re-launch measuring if necessary" 
			self onMeasure: anExtentMeasurementSpec ]
]

{ #category : #'t - columned private' }
TToColumned >> privateUpdateChildren [

	strategy ifNil: [ ^ self ].
	strategy updateChildrenIn: self
]

{ #category : #'t - columned accessing' }
TToColumned >> strategy [

	^ strategy ifNil: [ strategy := ToPairWithoutInterspaceStrategy ]
]

{ #category : #'t - columned accessing' }
TToColumned >> strategy: aPairStrategy [

	strategy := aPairStrategy.
	self privateUpdateChildren
]

{ #category : #'t - columned slot - change hook' }
TToColumned >> whenElementsChangedDo: aBlock [

	"set a block to perform after that the slot has been changed, and its action performed"

	self property: #elements whenChangedDo: aBlock
]

{ #category : #'t - columned slot - change hook' }
TToColumned >> whenStrategyChangedDo: aBlock [

	"set a block to perform after that the slot has been changed, and its action performed"

	self property: #strategy whenChangedDo: aBlock
]
