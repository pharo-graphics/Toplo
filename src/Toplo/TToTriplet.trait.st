Trait {
	#name : #TToTriplet,
	#instVars : [
		'justified',
		'innerElement'
	],
	#category : #'Toplo-Core-Triplet'
}

{ #category : #'t - triplet - configuration' }
TToTriplet >> beJustified [

	justified ifTrue: [ ^ self ].
	justified := true.
	self dispatchEvent: (ToPropertyChangedEvent new slotName: #justified; holder: self; previous: false; current: true; yourself)

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

	justified := false.
	innerElement := ToElement new layout: BlLinearLayout horizontal; fitContent.
	self layout: BlLinearLayout horizontal.
	self addChild: innerElement.
	self fitContent 

]

{ #category : #'t - triplet - accessing' }
TToTriplet >> innerElement [

	^ innerElement
]

{ #category : #'t - triplet - configuration' }
TToTriplet >> interspace: anInteger [

	self innerElement layout interspace: anInteger.
	self requestLayout
]

{ #category : #'t - triplet - testing' }
TToTriplet >> isJustified [

	^ justified ifNil: [ justified := false ]
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceFirstWith: anElement [

	self first = anElement ifTrue: [ ^ self ].
	self first ifNotNil: [ self first removeFromParent ].
	self first: anElement.
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceSecondWith: anElement [

	self second = anElement ifTrue: [ ^ self ].
	self second ifNotNil: [ self second removeFromParent ].
	self second: anElement
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceThirdWith: anElement [

	self third = anElement ifTrue: [ ^ self ].
	self third ifNotNil: [ self third removeFromParent ].
	self third: anElement
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
