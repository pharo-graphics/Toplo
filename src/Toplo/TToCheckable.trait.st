Trait {
	#name : #TToCheckable,
	#instVars : [
		'#group',
		'#checked => ObservableSlot'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - toggle group' }
TToCheckable >> addToGroup: aToggleGroup [

	aToggleGroup add: self.
	self group: aToggleGroup 
]

{ #category : #'t - checkable  protocol' }
TToCheckable >> check [

	self group ifNotNil: [ :g |
		g checked: self.
		^ self ].
	self privateCheck
]

{ #category : #'t - checkable  protocol' }
TToCheckable >> check: aBoolean [

	aBoolean
		ifTrue: [ self check ]
		ifFalse: [ self uncheck ]
]

{ #category : #'t - checkable  protocol' }
TToCheckable >> checked [

	^ checked 
]

{ #category : #'t - checkable  protocol' }
TToCheckable >> checked: aBoolean [

	checked = aBoolean ifTrue: [ ^ self ].
	checked := aBoolean
]

{ #category : #'t - toggle group' }
TToCheckable >> group [

	^ group
]

{ #category : #'t - toggle group' }
TToCheckable >> group: aToggleGroup [

	group := aToggleGroup
]

{ #category : #'t - checkable initializing' }
TToCheckable >> initializeCheckable [

	checked := false.
	self whenCheckedChangedDo: [ :new :prev | self dispatchEvent: (ToCheckableCheckEvent current: new previous: prev) ]

]

{ #category : #'t - checkable  protocol' }
TToCheckable >> privateCheck [

	checked := true
]

{ #category : #'t - checkable  protocol' }
TToCheckable >> privateUncheck [

	checked := false
]

{ #category : #'t - toggle group' }
TToCheckable >> removeFromGroup [

	self group remove: self
]

{ #category : #'t - checkable  protocol' }
TToCheckable >> uncheck [

	self group ifNotNil: [ :g | g unchecked: self. ^ self ].
	self privateUncheck
]

{ #category : #'t - change hook' }
TToCheckable >> whenCheckedChangedDo: aBlock [

	"set a block to perform after that the slot has been changed, and its action performed"

	self property: #checked whenChangedDo: aBlock
]
