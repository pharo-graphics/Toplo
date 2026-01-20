Trait {
	#name : #TToElementWithPlaceholder,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> hidePlaceholder [

	self placeholderLayer ifNotNil: [ :ph |
		ph visibility: BlVisibility gone ]
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
			ph detachFromParent ].
	aValuable ifNil: [ ^ self ].
	ph := self newPlaceholder.
	self userData at: #placeholder put: ph.
	ph id: #toploPlaceholder.
	ph addEventHandlerOn: ToAddedToSpaceEvent do: [ :event |
			ph padding: self padding.
			ph margin: self margin ].
	aValuable value: ph value: self.
	ph visibility: BlVisibility gone.
	ph attachToParent: self.
	ph elevation: self placeholderElevation
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

	^ self userData at: #placeholder ifAbsent: [  ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderString: aString [
	"Syntactic sugar to set a string has a placeholder message"

	aString ifNil: [
		self placeholderBuilder: nil.
		^ self ].

	self placeholderBuilder: [ :placeholder :e | 
		| lab |
		lab := ToLabel text: aString.
		lab multiLine: true.
		lab constraintsDo: [ :c | c linear vertical alignCenter ].
		placeholder addChild: lab ]
]

{ #category : #'t - element with placeholder' }
TToElementWithPlaceholder >> placeholderText: aText [
	"Syntactic sugar to set a string has a placeholder message"

	aText ifNil: [
		self placeholderBuilder: nil.
		^ self ].

	self placeholderBuilder: [ :placeholder :theElement |
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
