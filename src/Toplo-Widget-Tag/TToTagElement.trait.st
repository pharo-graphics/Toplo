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
		self fireEvent: ToInnerElementRemovedEvent new.
		self removeFromParent. ].
	but id: #removeButton.
	self addChild: but after: self endContainer
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
TToTagElement >> bordered: aBoolean [

	self addStamp: #bordered withValue: aBoolean
]

{ #category : #accessing }
TToTagElement >> closeIcon: aBoolean [

	self addStamp: #closeIcon withValue: aBoolean
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
		ifTrue: [ self beRemovable ]
		ifFalse: [ self beUnremovable ]
]

{ #category : #accessing }
TToTagElement >> removeButton [

	^ self childWithId: #removeButton ifNone: [  ]
]

{ #category : #adding }
TToTagElement >> removeRemoveButton [

	self icon: nil

]
