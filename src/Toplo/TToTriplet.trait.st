Trait {
	#name : #TToTriplet,
	#instVars : [
		'tripletStrategy',
		'columnWidth'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'t - triplet - configuration' }
TToTriplet >> beJustified [

	self tripletStrategy: ToTripletJustifiedStrategy new
 
]

{ #category : #'t - triplet - configuration' }
TToTriplet >> columnWidth [

	^ columnWidth
]

{ #category : #'t - triplet - configuration' }
TToTriplet >> columnWidth: anInteger [

	columnWidth := anInteger.
	(self layout isKindOf: ToTripletLinearLayout) ifFalse: [
		self layout: ToTripletLinearLayout new ].
	self layout frontAlignmentSpacing: anInteger
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

	self tripletStrategy: ToTripletLinearStrategy new.
	columnWidth := 0
]

{ #category : #'t - triplet - configuration' }
TToTriplet >> interspace: anInteger [

	self tripletStrategy: ToTripletLinearStrategy new.
	self layout interspace: anInteger.
	self requestLayout
]

{ #category : #'t - triplet - testing' }
TToTriplet >> isJustified [

	^ self tripletStrategy isJustified
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
	subs := self tripletStrategy childrenIn: self.
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

	^ tripletStrategy ifNil: [ tripletStrategy := ToTripletLinearStrategy new]
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> tripletStrategy: aPairStrategy [

	tripletStrategy ifNotNil: [ :s | s onUninstalledIn: self ].
	tripletStrategy := aPairStrategy.
	tripletStrategy ifNotNil: [ :s | s onInstalledIn: self. self privateUpdateChildren ]
]
