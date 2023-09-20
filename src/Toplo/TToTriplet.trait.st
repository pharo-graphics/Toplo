Trait {
	#name : 'TToTriplet',
	#instVars : [
		'innerElement'
	],
	#category : 'Toplo-Core-Triplet',
	#package : 'Toplo',
	#tag : 'Core-Triplet'
}

{ #category : 't - triplet - accessing' }
TToTriplet >> first [

	^ self explicitRequirement 
]

{ #category : 't - triplet - accessing' }
TToTriplet >> first: anElement [

	self explicitRequirement 
]

{ #category : 't - triplet - initialization' }
TToTriplet >> initializeTriplet [

	self layout: BlLinearLayout horizontal.
	self justified: false.
	innerElement := ToElement new layout: BlLinearLayout horizontal; fitContent.
	innerElement styleTag: #'inner-element'.
	self addChild: innerElement.
	self fitContent 

]

{ #category : 't - triplet - accessing' }
TToTriplet >> innerElement [

	^ innerElement
]

{ #category : 't - triplet - configuration' }
TToTriplet >> interspace: anInteger [

	self innerElement layout interspace: anInteger.
	self requestLayout
]

{ #category : 't - triplet - configuration' }
TToTriplet >> justified [

	^ self styleTags includes: #justified
]

{ #category : 't - triplet - configuration' }
TToTriplet >> justified: aBoolean [

	| prev |
	self justified = aBoolean ifTrue: [ ^ self ].
	prev := self justified.
	aBoolean
		ifTrue: [ self addStyleTag: #justified ]
		ifFalse: [ self removeStyleTag: #justified ].
	self dispatchEvent: (ToPropertyChangedEvent new
			 slotName: #justified;
			 holder: self;
			 previous: prev;
			 current: self justified;
			 yourself).
	self updateSkin
]

{ #category : 't - triplet - accessing' }
TToTriplet >> replaceFirstWith: anElement [

	self first = anElement ifTrue: [ ^ self ].
	self first ifNotNil: [ self first removeFromParent ].
	self first: anElement.
]

{ #category : 't - triplet - accessing' }
TToTriplet >> replaceSecondWith: anElement [

	self second = anElement ifTrue: [ ^ self ].
	self second ifNotNil: [ self second removeFromParent ].
	self second: anElement
]

{ #category : 't - triplet - accessing' }
TToTriplet >> replaceThirdWith: anElement [

	self third = anElement ifTrue: [ ^ self ].
	self third ifNotNil: [ self third removeFromParent ].
	self third: anElement
]

{ #category : 't - triplet - accessing' }
TToTriplet >> second [

	^ self explicitRequirement 
]

{ #category : 't - triplet - accessing' }
TToTriplet >> second: anElement [

	self explicitRequirement 
]

{ #category : 't - triplet - accessing' }
TToTriplet >> third [

	^ self explicitRequirement 
]

{ #category : 't - triplet - accessing' }
TToTriplet >> third: anElement [

	self explicitRequirement 

]
