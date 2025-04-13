Trait {
	#name : #TToRemovableItemElement,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'t - removable item element' }
TToRemovableItemElement >> addRemoveButton [

	self shouldBeImplemented 
]

{ #category : #'t - removable item element' }
TToRemovableItemElement >> bordered: aBoolean [

	self
		deprecated: 'Use #borderless: '
		transformWith:
		'`@rcvr bordered: `@arg' -> '`@rcvr borderless: `@arg not'.
	self borderless: aBoolean not
]

{ #category : #'t - removable item element' }
TToRemovableItemElement >> isRemovable [

	^ removable ifNil: [ false ]
]

{ #category : #'t - removable item element' }
TToRemovableItemElement >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable := aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - removable item element' }
TToRemovableItemElement >> removeButton [

	^ self shouldBeImplemented 
]

{ #category : #'t - removable item element' }
TToRemovableItemElement >> removeButtonDo: aValuable [

	self removeButton ifNil: [ ^ self ].
	aValuable value: self removeButton
]

{ #category : #'t - removable item element' }
TToRemovableItemElement >> removeRemoveButton [

	self shouldBeImplemented 
]
