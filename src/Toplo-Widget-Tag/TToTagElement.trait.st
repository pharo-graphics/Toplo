Trait {
	#name : #TToTagElement,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag-Core'
}

{ #category : #adding }
TToTagElement >> addRemoveButton [

	| ic |
	self removeButton ifNotNil: [ ^ self ].
	ic := ToRemoveIconicButton new.
	ic addStamp: #'parent-tag' withValue: self.
	self endElement: ic
]

{ #category : #accessing }
TToTagElement >> backgroundColor: aColorOrNil [

	aColorOrNil
		ifNil: [ self removeStamp: #backgroundColor ]
		ifNotNil: [ self addStamp: #backgroundColor withValue: aColorOrNil ]
]

{ #category : #accessing }
TToTagElement >> bordered: aBoolean [

	self addStamp: #bordered withValue: aBoolean
]

{ #category : #accessing }
TToTagElement >> foregroundColor: aColorOrNil [

	aColorOrNil
		ifNil: [ self removeStamp: #foregroundColor ]
		ifNotNil: [ self addStamp: #foregroundColor withValue: aColorOrNil ]
]

{ #category : #configurating }
TToTagElement >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable := aBoolean.
	self requestNewConfigurationPass
]

{ #category : #accessing }
TToTagElement >> removeButton [

	^ self childWithId: #'remove-iconic-button' ifNone: [  ]
]

{ #category : #adding }
TToTagElement >> removeRemoveButton [

	self endElement: nil

]
