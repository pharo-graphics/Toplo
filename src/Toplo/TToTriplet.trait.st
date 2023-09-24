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
	innerElement styleTag: #'inner-element'.
	self addChild: innerElement.
	self fitContent.
	filler1 := ToElement new
		           id: #filler1;
		           styleTag: #'triplet-filler-1';
		           size: 0 @ 0;
		           yourself.
	filler2 := ToElement new
		           id: #filler2;
		           styleTag: #'triplet-filler-2';
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

	^ self styleTags includesKey: #justified
]

{ #category : #'t - triplet - configuration' }
TToTriplet >> justified: aBoolean [

	self justified = aBoolean ifTrue: [ ^ self ].
	aBoolean
		ifTrue: [ self addStyleTag: #justified ]
		ifFalse: [ self removeStyleTag: #justified ].
	self updateSkin
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceFirstWith: anElement [

	self first = anElement ifTrue: [ ^ self ].
	self first ifNotNil: [ self first removeFromParent ].
	anElement ifNil: [ ^ self ].
	self first: anElement.
	self innerElement addChild: anElement before: filler1.
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceSecondWith: anElement [

	self second = anElement ifTrue: [ ^ self ].
	self second ifNotNil: [ self second removeFromParent ].
	anElement ifNil: [ ^ self ].
	self second: anElement.
	self innerElement addChild: anElement before: filler2.
]

{ #category : #'t - triplet - accessing' }
TToTriplet >> replaceThirdWith: anElement [

	self third = anElement ifTrue: [ ^ self ].
	self third ifNotNil: [ self third removeFromParent ].
	anElement ifNil: [ ^ self ].
	self third: anElement.
	self innerElement addChild: anElement after: filler2.
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
