Trait {
	#name : #TToTagElement,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag-Core'
}

{ #category : #'t - tag element' }
TToTagElement >> addRemoveButton [

	| ic |
	self removeButton ifNotNil: [ ^ self ].
	ic := ToRemoveIconicButton new.
	ic addStamp: #'parent-tag' withValue: self.
	self endElement: ic
]

{ #category : #'t - tag element' }
TToTagElement >> backgroundColor: aColorOrNil [

	aColorOrNil
		ifNil: [ self removeStamp: #backgroundColor ]
		ifNotNil: [ self addStamp: #backgroundColor withValue: aColorOrNil ]
]

{ #category : #'t - tag element' }
TToTagElement >> bordered: aBoolean [

	self
		deprecated: 'Use #borderless: '
		transformWith:
		'`@rcvr bordered: `@arg' -> '`@rcvr borderless: `@arg not'.
	self borderless: aBoolean not
]

{ #category : #'t - tag element' }
TToTagElement >> borderless: aBoolean [

	aBoolean
		ifTrue: [ self addStamp: #borderless ]
		ifFalse: [ self removeStamp: #borderless ]
]

{ #category : #'t - tag element' }
TToTagElement >> foregroundColor: aColorOrNil [

	aColorOrNil
		ifNil: [ self removeStamp: #foregroundColor ]
		ifNotNil: [ self addStamp: #foregroundColor withValue: aColorOrNil ]
]

{ #category : #'t - tag element' }
TToTagElement >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable := aBoolean.
	self requestNewConfigurationPass
]

{ #category : #'t - tag element' }
TToTagElement >> removeButton [

	^ self childWithId: #'remove-iconic-button' ifNone: [  ]
]

{ #category : #'t - tag element' }
TToTagElement >> removeRemoveButton [

	self endElement: nil

]
