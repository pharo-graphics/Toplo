Trait {
	#name : 'TToElementWithPlaceholder',
	#category : 'Toplo-Widget-Pane',
	#package : 'Toplo-Widget-Pane'
}

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> hidePlaceholder [

	self placeholderLayer ifNil: [ ^ self ].
	self placeholderLayer parentDo: [ :p |
		self placeholderLayer detach.
		self removeChild: self placeholderLayer.
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

	^ self userData at: #placeholderLayer ifAbsent: [  ]
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> placeholderLayer: aPanePlaceholderLayer [

	self placeholderLayer ifNotNil: [
		self placeholderLayer parentDo: [ :layer |
			self hidePlaceholder.
			self rawPlaceholderLayer: aPanePlaceholderLayer.
			self showPlaceholder.
			^ self ] ].
	self rawPlaceholderLayer: aPanePlaceholderLayer
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> rawPlaceholderLayer: aPlaceHolderLayer [

	self userData at: #placeholderLayer put: aPlaceHolderLayer
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> showPlaceholder [

	self placeholderLayer ifNil: [ ^ self ].
	self placeholderLayer parentDo: [ :p | ^ self ].
	
	self placeholderLayer attachTo: self.
	self addChild: self placeholderLayer.
	
	self dispatchEvent: ToPlaceholderAddedEvent new
]
