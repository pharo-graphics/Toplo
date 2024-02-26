Trait {
	#name : #TToElementWithPlaceholder,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> currentPlaceholderLayer [

	^ self userData at: #currentPlaceholderLayer ifAbsent: [  ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> hasPlaceholderMinHeight [

	^ self userData includesKey: #placeholderMinHeight
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> hasPlaceholderMinWidth [

	^ self userData includesKey: #placeholderMinWidth
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> hidePlaceholder [

	self currentPlaceholderLayer ifNil: [ ^ self ].
	self currentPlaceholderLayer detach.
	self removeChild: self currentPlaceholderLayer.
	self dispatchEvent: (ToPlaceholderHiddenEvent new
			 placeholder: self currentPlaceholderLayer;
			 yourself).
	self userData removeKey: #currentPlaceholderLayer
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> isShowingPlaceholder [

	^ self currentPlaceholderLayer notNil
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> isShowingPlaceholder: aBoolean [

	self isShowingPlaceholder = aBoolean ifTrue: [ ^ self ].

	aBoolean
		ifTrue: [ self showPlaceholder ]
		ifFalse: [ self hidePlaceholder ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> newPlaceholder [

	^ self placeholderClass new
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderBuilder: aValuable [

	" aValuable takes 2 args: 1 the placeholder to build, 2 the element. 
	If nil, the current builder is removed"
	self rawPlaceholderBuilder: aValuable 
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderClass [

	^ ToPlaceholderLayer
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderElevation [

	^ self elevation
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderEventHandler [

	^ self userData at: #placeholderEventHandler ifAbsent: [  ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderEventHandler: anEventHandler [

	^ self userData at: #placeholderEventHandler put: anEventHandler
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderMinHeight [

	^ self userData at: #placeholderMinHeight ifAbsent: [ 0 ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderMinHeight: aNumber [

	^ self userData at: #placeholderMinHeight put: aNumber
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderMinWidth [

	^ self userData at: #placeholderMinWidth ifAbsent: [ 0 ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderMinWidth: aNumber [

	^ self userData at: #placeholderMinWidth put: aNumber
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderText: aText [
	"Syntaxic sugar to set a string has a placeholder message"

	aText ifNil: [ self placeholderBuilder: nil.
		^ self ].

	self placeholderBuilder: [ :placeholder :e |
		placeholder padding: e padding.
		placeholder addChild: (ToAttributedLabel new
				 text: aText;
				 yourself) ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> rawPlaceholderBuilder [

	" if not nil, a valuable that takes 2 args: 1 the placeholder to build, 2 the element"
	
	^ self userData at: #placeholderBuilder ifAbsent: [  ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> rawPlaceholderBuilder: aValuable [
	" aValuaable takes 2 args: 1 the placeholder to build, 2 the element. If nil, the current builder is removed"

	aValuable ifNil: [
		self isShowingPlaceholder ifTrue: [ self hidePlaceholder ].
		self userData removeKey: #placeholderBuilder ifAbsent: [  ].
		self placeholderEventHandler ifNotNil: [ :handler |
			self removeEventHandler: handler.
			self placeholderEventHandler: nil ].
		^ self ].
	self userData at: #placeholderBuilder put: aValuable.
	aValuable ifNotNil: [
		self placeholderEventHandler:
			ToElementWithPlaceholderEventHandler new.
		self addEventHandler: self placeholderEventHandler ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> showPlaceholder [

	self currentPlaceholderLayer ifNotNil: [ ^ self ].
	self rawPlaceholderBuilder ifNotNil: [ :builder |
		| ph |
		ph := self newPlaceholder.
		builder value: ph value: self.
		self userData at: #currentPlaceholderLayer put: ph.
		ph attachTo: self.
		ph elevation: self placeholderElevation.
		self addChild: ph.
		self dispatchEvent: (ToPlaceholderShownEvent new
				 placeholder: ph;
				 yourself) ]
]
