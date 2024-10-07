Trait {
	#name : #TToTagElement,
	#category : #'Toplo-Widget-Tag-Core'
}

{ #category : #adding }
TToTagElement >> addRemoveButton [

	| but |
	self removeButton ifNotNil: [ ^ self ].
	but := ToButton new.
	but applySkinInstallerOnFirstRequest: true.
	but addStamp: #'parent-tag' withValue: self.
	but addStamp: #circle.
	but addStamp: #iconic.
	but icon: (ToImage inner: (self iconNamed: #windowClose)).
	but constraintsDo: [ :c | c linear vertical alignCenter ].
	but whenClickedDo: [ :event |
		self fireEvent: ToInnerElementRemovedEvent new.
		self removeFromParent ].
	but id: #removeButton.
	self addChild: but after: self endContainer
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

{ #category : #accessing }
TToTagElement >> rawRemovable [

	^ self explicitRequirement
]

{ #category : #accessing }
TToTagElement >> rawRemovable: aBoolean [

	self explicitRequirement
]

{ #category : #configurating }
TToTagElement >> removable: aBoolean [

	aBoolean
		ifTrue: [ self addRemoveButton ]
		ifFalse: [ self removeRemoveButton ]
]

{ #category : #accessing }
TToTagElement >> removeButton [

	^ self childWithId: #removeButton ifNone: [  ]
]

{ #category : #adding }
TToTagElement >> removeRemoveButton [

	self icon: nil

]
