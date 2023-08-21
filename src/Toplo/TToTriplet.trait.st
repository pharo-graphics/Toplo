Trait {
	#name : #TToTriplet,
	#instVars : [
		'tripletStrategy'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'t - triplet - configuration' }
TToTriplet >> beJustified [

	self tripletStrategy: ToTripletJustifiedStrategy new
 
]

{ #category : #'t - triplet - configuration' }
TToTriplet >> columnWidth [

	^ tripletStrategy
		  ifNil: [ 0 ]
		  ifNotNil: [ :strat | strat columnWidth ]
]

{ #category : #'t - triplet - configuration' }
TToTriplet >> columnWidth: anInteger [

	self tripletStrategy: (ToTripletColumnStrategy new width: anInteger)
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> first [

	^ self explicitRequirement 
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> first: anElement [

	self explicitRequirement 
]

{ #category : #'t - triplet - initialization' }
TToTriplet >> initializeTriplet [

	self tripletStrategy: ToTripletWithoutInterspaceStrategy new.
	self fitContent
]

{ #category : #'t - triplet - testing' }
TToTriplet >> isJustified [

	^ tripletStrategy ifNil: [ false ] ifNotNil: [ :strat | strat isJustified ]
]

{ #category : #'t - triplet - layout' }
TToTriplet >> onMeasure: anExtentMeasurementSpec [

	" send to super before to ensure the children are already measured "

	super onMeasure: anExtentMeasurementSpec.
	(self tripletStrategy onMeasure: anExtentMeasurementSpec in: self) 
		ifFalse: [ " re-launch measuring if necessary" 
			self onMeasure: anExtentMeasurementSpec ]
]

{ #category : #'t - triplet - private' }
TToTriplet >> privateUpdateChildren [

	| subs |
	tripletStrategy ifNil: [ ^ self ].
	subs := self tripletStrategy childrenIn: self.
	self skinDo: [ :s | subs := s adaptNextChildrenArray: subs in: self].
	self children asArray = subs ifTrue: [ ^ self ].
	self removeChildren.
	self addChildren: subs.

]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceFirstWith: anElement [

	self first = anElement ifTrue: [ ^ self ].
	self first ifNotNil: [ self first removeFromParent ].
	self first: anElement.
	self privateUpdateChildren
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceSecondWith: anElement [

	self second = anElement ifTrue: [ ^ self ].
	self second ifNotNil: [ self second removeFromParent ].
	self second: anElement.
	self privateUpdateChildren
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceThirdWith: anElement [

	self third = anElement ifTrue: [ ^ self ].
	self third ifNotNil: [ self third removeFromParent ].
	self third: anElement.
	self privateUpdateChildren
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> second [

	^ self explicitRequirement 
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> second: anElement [

	self explicitRequirement 
]

{ #category : #'t - triplet - configuration' }
TToTriplet >> spacingHeight: anInteger [

	self tripletStrategy spacingHeight = anInteger ifTrue: [ ^ self ].
	self tripletStrategy: (ToTripletWithExactInterspaceStrategy new height: anInteger)
]

{ #category : #'t - triplet - configuration' }
TToTriplet >> spacingWidth: anInteger [

	self tripletStrategy spacingWidth = anInteger ifTrue: [ ^ self ].
	self tripletStrategy: (ToTripletWithExactInterspaceStrategy new width: anInteger)
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> third [

	^ self explicitRequirement 
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> third: anElement [

	self explicitRequirement 

]

{ #category : #'t - triplet - accessing' }
TToTriplet >> tripletStrategy [

	^ tripletStrategy ifNil: [ tripletStrategy := ToTripletWithoutInterspaceStrategy new]
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> tripletStrategy: aPairStrategy [

	tripletStrategy ifNotNil: [ :s | s onUninstalledIn: self ].
	tripletStrategy := aPairStrategy.
	tripletStrategy ifNotNil: [ :s | s onInstalledIn: self ].
	self privateUpdateChildren
]
