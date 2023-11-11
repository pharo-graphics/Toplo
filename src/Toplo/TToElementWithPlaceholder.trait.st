Trait {
	#name : 'TToElementWithPlaceholder',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> currentPlaceholderLayer [

	^ self userData at: #currentPlaceholderLayer ifAbsent: [  ]
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> hidePlaceholder [

	self currentPlaceholderLayer ifNil: [ ^ self ].
	self currentPlaceholderLayer detach.
	self removeChild: self currentPlaceholderLayer.
	self dispatchEvent: ToPlaceholderRemovedEvent new.
	self userData removeKey: #currentPlaceholderLayer
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> placeholderBuilder: aValuable [

	" aValuable takes 2 args: 1 the placeholder to build, 2 the element. 
	If nil, the current builder is removed"
	self rawPlaceholderBuilder: aValuable 
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> placeholderClass [

	^ ToPlaceholderLayer
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> placeholderElevation [

	^ self elevation
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> rawPlaceholderBuilder [

	" if not nil, a valuable that takes 2 args: 1 the placeholder to build, 2 the element"
	
	^ self userData at: #placeholderBuilder ifAbsent: [  ]
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> rawPlaceholderBuilder: aValuable [
	" aValuaable takes 2 args: 1 the placeholder to build, 2 the element. If nil, the current builder is removed"

	aValuable ifNil: [
		self userData removeKey: #placeholderBuilder ifAbsent: [  ].
		^ self ].
	self userData at: #placeholderBuilder put: aValuable
]

{ #category : 't - element with placeholder' }
TToElementWithPlaceholder >> showPlaceholder [

	self currentPlaceholderLayer ifNotNil: [ ^ self ].
	self rawPlaceholderBuilder ifNotNil: [ :builder |
		| ph |
		ph := self placeholderClass new.
		builder value: ph value: self.
		self userData at: #currentPlaceholderLayer put: ph.
		ph attachTo: self.
		ph elevation: self placeholderElevation.
		self addChild: ph.
		self dispatchEvent: ToPlaceholderAddedEvent new ]
]
