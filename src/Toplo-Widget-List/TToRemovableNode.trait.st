Trait {
	#name : #TToRemovableNode,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - removable item element' }
TToRemovableNode >> addRemoveButton [

	self shouldBeImplemented 
]

{ #category : #'t - removable item element' }
TToRemovableNode >> bordered: aBoolean [

	self
		deprecated: 'Use #borderless: '
		transformWith:
		'`@rcvr bordered: `@arg' -> '`@rcvr borderless: `@arg not'.
	self borderless: aBoolean not
]

{ #category : #'t - removable item element' }
TToRemovableNode >> isRemovable [

	^ removable ifNil: [ false ]
]

{ #category : #'t - removable item element' }
TToRemovableNode >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable := aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - removable item element' }
TToRemovableNode >> removeButton [

	^ self shouldBeImplemented 
]

{ #category : #'t - removable item element' }
TToRemovableNode >> removeButtonDo: aValuable [

	self removeButton ifNil: [ ^ self ].
	aValuable value: self removeButton
]

{ #category : #'t - removable item element' }
TToRemovableNode >> removeRemoveButton [

	self shouldBeImplemented 
]
