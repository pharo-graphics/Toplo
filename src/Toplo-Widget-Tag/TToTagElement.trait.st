Trait {
	#name : #TToTagElement,
	#category : #'Toplo-Widget-Tag'
}

{ #category : #adding }
TToTagElement >> addRemoveButton [

	| but |
	but := ToButton new.
	but applySkinInstallerOnFirstRequest: true.
	but defaultRawSkin: ToTagRemoveButtonSkin new.
	but icon: (ToImage inner: (self iconNamed: #windowClose)).
	but constraintsDo: [ :c | c linear vertical alignCenter ].
	but whenClickedDo: [ :event |
		self removeFromParent.
		self dispatchEvent: ToTagRemovedEvent new ].
	but id: #removeButton.
	self startElement: but
]

{ #category : #configurating }
TToTagElement >> beRemovable [

	self addRemoveButton
	
]

{ #category : #configurating }
TToTagElement >> beUnremovable [

	self removeRemoveButton
]

{ #category : #accessing }
TToTagElement >> rawRemovable [

	^ self explicitRequirement
]

{ #category : #accessing }
TToTagElement >> rawRemovable: aBoolean [

	self explicitRequirement
]

{ #category : #accessing }
TToTagElement >> removable: aBoolean [

	self rawRemovable = aBoolean ifTrue: [ ^ self ].
	self rawRemovable: aBoolean.
	self rawRemovable
		ifTrue: [ self beRemovable ]
		ifFalse: [ self beUnremovable ]
]

{ #category : #accessing }
TToTagElement >> removeButton [

	^ self childWithId: #removeButton ifNone: [  ]
]
