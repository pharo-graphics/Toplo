Trait {
	#name : 'TToElementWithPlaceholder',
	#instVars : [
		'placeholderLayer'
	],
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> hidePlaceholder [

	placeholderLayer ifNil: [ ^ self ].
	placeholderLayer parentDo: [ :p |
		self removeLayer: placeholderLayer.
		self dispatchEvent: ToPlaceholderRemovedEvent new ]
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> placeholder [

	^ self placeholderLayer
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> placeholder: anElement [

	self placeholderLayer: (anElement ifNotNil: [:ph | ph asPlaceholderLayer ])
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> placeholderLayer [

	^ placeholderLayer
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> placeholderLayer: aPanePlaceholderLayer [

	self placeholderLayer ifNotNil: [
		self placeholderLayer parentDo: [ :layer |
			self hidePlaceholder.
			placeholderLayer := aPanePlaceholderLayer.
			self showPlaceholder.
			^ self ] ].
	placeholderLayer := aPanePlaceholderLayer
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> showPlaceholder [

	placeholderLayer ifNil: [ ^ self ].
	placeholderLayer parentDo: [ :p | ^ self ].
	self addLayer: placeholderLayer.
	self dispatchEvent: (ToPlaceholderAddedEvent new)
]
