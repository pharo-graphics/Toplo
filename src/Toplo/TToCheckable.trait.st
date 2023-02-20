Trait {
	#name : #TToCheckable,
	#instVars : [
		'group'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - toggle group' }
TToCheckable >> addToGroup: aToggleGroup [

	aToggleGroup add: self.
	self group: aToggleGroup 
]

{ #category : #'t - checking protocol' }
TToCheckable >> check [
	self group ifNotNil: [ ^ self ].
	self privateCheck
]

{ #category : #'t - checking protocol' }
TToCheckable >> check: aBoolean [

	aBoolean ifTrue: [ self check ] ifFalse: [ self uncheck  ]

]

{ #category : #'t - toggle group' }
TToCheckable >> group [

	^ group
]

{ #category : #'t - toggle group' }
TToCheckable >> group: aToggleGroup [

	group := aToggleGroup
]

{ #category : #'t - checking protocol' }
TToCheckable >> isChecked [

	^ self currentState notNil and: [ self currentState name = #checked ]
]

{ #category : #'t - checking protocol' }
TToCheckable >> isUnchecked [

	^ self currentState notNil and: [ self currentState name = #unchecked ]
]

{ #category : #'t - checking protocol' }
TToCheckable >> privateCheck [
	self switchToStateNamed: #checked
]

{ #category : #'t - checking protocol' }
TToCheckable >> privateUncheck [

	self switchToStateNamed: #unchecked
]

{ #category : #'t - toggle group' }
TToCheckable >> removeFromGroup [

	self group remove: self
]

{ #category : #'t - checking protocol' }
TToCheckable >> startChecked [

	self isChecked ifTrue: [ ^ self ].
	self startState: (self stateNamed: #checked)
]

{ #category : #'t - checking protocol' }
TToCheckable >> startUnchecked [

	self isChecked ifFalse: [ ^ self ].
	self startState: (self stateNamed: #unchecked)
]

{ #category : #'t - checking protocol' }
TToCheckable >> uncheck [

	self group ifNotNil: [ ^ self ].
	self privateUncheck
]

{ #category : #'t - checking protocol' }
TToCheckable >> whenCheckedDo: aBlock [

	(self stateNamed: #checked) whenEnterDo: [:ann | aBlock cull: ann widget ]
]

{ #category : #'t - checking protocol' }
TToCheckable >> whenUncheckedDo: aBlock [

	(self stateNamed: #unchecked ) whenEnterDo: [:ann | aBlock cull: ann widget ]
]
