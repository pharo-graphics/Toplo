Trait {
	#name : #TToElementWithPlaceholder,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> hidePlaceholder [

	self placeholderLayer ifNotNil: [ :ph |
		ph visibility: BlVisibility hidden ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> newPlaceholder [

	^ self placeholderClass new
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderBuilder: aValuable [

	| ph |
	ph := self placeholderLayer.
	ph ifNotNil: [
		ph detach.
		ph removeFromParent ].
	aValuable ifNil: [ ^ self ].
	ph := self newPlaceholder.
	ph id: #toploPlaceholder.
	aValuable value: ph value: self.
	ph visibility: BlVisibility hidden.
	ph attachTo: self.
	ph elevation: self placeholderElevation.
	self addChild: ph
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
TToElementWithPlaceholder >> placeholderLayer [

	^ self childWithId: #toploPlaceholder ifNone: [  ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderString: aString [
	"Syntactic sugar to set a string has a placeholder message"

	aString ifNil: [
		self placeholderBuilder: nil.
		^ self ].

	self placeholderBuilder: [ :placeholder :e |
		placeholder padding: e padding.
		placeholder addChild: (ToLabel text: aString) ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderText: aText [
	"Syntactic sugar to set a string has a placeholder message"

	aText ifNil: [
		self placeholderBuilder: nil.
		^ self ].

	self placeholderBuilder: [ :placeholder :theElement |
		placeholder padding: theElement padding.
		placeholder addChild: (ToAttributedLabel new
				 text: aText;
				 yourself) ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> showPlaceholder [

	self placeholderLayer ifNotNil: [ :ph |
		ph visibility: BlVisibility visible.
		self dispatchEvent: (ToPlaceholderShownEvent new
				 placeholder: ph;
				 yourself) ]
]
