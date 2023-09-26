Trait {
	#name : #TToTriplet,
	#instVars : [
		'innerElement',
		'filler1',
		'filler2'
	],
	#category : #'Toplo-Core-Triplet'
}

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

	self layout: BlLinearLayout horizontal.
	self justified: false.
	innerElement := ToElement new
		                layout: BlLinearLayout horizontal;
		                fitContent.
	innerElement stampWith: #'inner-element'.
	self addChild: innerElement.
	self fitContent.
	filler1 := ToElement new
		           id: #filler1;
		           stampWith: #'triplet-filler-1';
		           size: 0 @ 0;
		           yourself.
	filler2 := ToElement new
		           id: #filler2;
		           stampWith: #'triplet-filler-2';
		           size: 0 @ 0;
		           yourself.
	self innerElement addChildren: {
			filler1.
			filler2 }
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

{ #category : #'t - triplet - configuration' }
TToTriplet >> justified [

	^ self localStyleStampIndex includesKey: #justified
]

{ #category : #'t - triplet - configuration' }
TToTriplet >> justified: aBoolean [

	self justified = aBoolean ifTrue: [ ^ self ].
	aBoolean
		ifTrue: [ self stampWith: #justified ]
		ifFalse: [ self removeStyleStampNamed: #justified ].
	self updateSkin
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceFirstWith: anElement [

	self first = anElement ifTrue: [ ^ self ].
	self first ifNotNil: [ self first removeFromParent ].
	anElement ifNil: [ ^ self ].
	self innerElement addChild: anElement before: filler1.
	self first: anElement
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceSecondWith: anElement [

	self second = anElement ifTrue: [ ^ self ].
	self second ifNotNil: [ self second removeFromParent ].
	anElement ifNil: [ ^ self ].
	self innerElement addChild: anElement before: filler2.
	self second: anElement.
	filler2 updateSkin 

]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceThirdWith: anElement [

	self third = anElement ifTrue: [ ^ self ].
	self third ifNotNil: [ self third removeFromParent ].
	anElement ifNil: [ ^ self ].
	self innerElement addChild: anElement after: filler2.
	self third: anElement.
	filler2 updateSkin 
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
