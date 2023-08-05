Trait {
	#name : #TToTriplet,
	#instVars : [
		'strategy'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'t - triplet presentation' }
TToTriplet >> beJustified [

	self strategy: ToTripletJustifiedStrategy new
 
]

{ #category : #'t - triplet presentation' }
TToTriplet >> columnWidth [

	^ strategy
		  ifNil: [ 0 ]
		  ifNotNil: [ :strat | strat columnWidth ]
]

{ #category : #'t - triplet presentation' }
TToTriplet >> columnWidth: anInteger [

	self strategy: (ToTripletColumnStrategy new width: anInteger)
]

{ #category : #'t - triplet accessing' }
TToTriplet >> first [

	^ self explicitRequirement 
]

{ #category : #'t - triplet accessing' }
TToTriplet >> first: anElement [

	self explicitRequirement 
]

{ #category : #initialization }
TToTriplet >> initialize [

	self class initializeSlots: self.
	super initialize.
]

{ #category : #'t - triplet initialization' }
TToTriplet >> initializeTriplet [

	self layout: BlLinearLayout horizontal.
	self strategy: ToTripletWithoutInterspaceStrategy new.
	self fitContent
]

{ #category : #'t - triplet presentation' }
TToTriplet >> isJustified [

	^ strategy ifNil: [ false ] ifNotNil: [ :strat | strat isJustified ]
]

{ #category : #layout }
TToTriplet >> onMeasure: anExtentMeasurementSpec [

	" send to super before to ensure the children are already measured "

	super onMeasure: anExtentMeasurementSpec.
	(self strategy onMeasure: anExtentMeasurementSpec in: self) 
		ifFalse: [ " re-launch measuring if necessary" 
			self onMeasure: anExtentMeasurementSpec ]
]

{ #category : #'t - triplet private' }
TToTriplet >> prepareChild: aChild [

	aChild ifNil: [ ^ self ].
	aChild constraintsDo: [ :c |
		c linear vertical alignCenter.
		c linear horizontal alignCenter ]
]

{ #category : #'t - triplet private' }
TToTriplet >> privateUpdateChildren [

	strategy ifNil: [ ^ self ].
	strategy updateChildrenIn: self
]

{ #category : #'t - triplet accessing' }
TToTriplet >> replaceFirstWith: anElement [

	self first = anElement ifTrue: [ ^ self ].
	self first ifNotNil: [ self first removeFromParent ].
	self first: anElement.
	self prepareChild: self first.
	self privateUpdateChildren
]

{ #category : #'t - triplet accessing' }
TToTriplet >> replaceSecondWith: anElement [

	self second = anElement ifTrue: [ ^ self ].
	self second ifNotNil: [ self second removeFromParent ].
	self second: anElement.
	self prepareChild: self second.
	self privateUpdateChildren
]

{ #category : #'t - triplet accessing' }
TToTriplet >> replaceThirdWith: anElement [

	self third = anElement ifTrue: [ ^ self ].
	self third ifNotNil: [ self third removeFromParent ].
	self third: anElement.
	self prepareChild: self third.
	self privateUpdateChildren
]

{ #category : #'t - triplet accessing' }
TToTriplet >> second [

	^ self explicitRequirement 
]

{ #category : #'t - triplet accessing' }
TToTriplet >> second: anElement [

	self explicitRequirement 
]

{ #category : #'t - triplet presentation' }
TToTriplet >> spacingHeight: anInteger [

	self strategy: (ToTripletWithSpacingStrategy new height: anInteger)
]

{ #category : #'t - triplet presentation' }
TToTriplet >> spacingWidth: anInteger [

	self strategy: (ToTripletWithSpacingStrategy new width: anInteger)
]

{ #category : #'t - triplet accessing' }
TToTriplet >> strategy [

	^ strategy ifNil: [ strategy := ToTripletWithoutInterspaceStrategy new]
]

{ #category : #'t - triplet accessing' }
TToTriplet >> strategy: aPairStrategy [

	strategy := aPairStrategy.
	self privateUpdateChildren
]

{ #category : #'t - triplet accessing' }
TToTriplet >> third [

	^ self explicitRequirement 
]

{ #category : #'t - triplet accessing' }
TToTriplet >> third: anElement [

	self explicitRequirement 

]
