Trait {
	#name : #TToCheckableWidget,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - toggle group' }
TToCheckableWidget >> addToGroup: aToggleGroup [

	aToggleGroup add: self.
	self group: aToggleGroup 
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> check [
	(self group notNil and: [ self isChecked ]) ifTrue: [ ^ self ].
	self switchToStateNamed: #checked
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> check: aBoolean [

	aBoolean ifTrue: [ self check ] ifFalse: [ self uncheck  ]

]

{ #category : #'t - toggle group' }
TToCheckableWidget >> group [

	^ self explicitRequirement
]

{ #category : #'t - toggle group' }
TToCheckableWidget >> group: aToggleGroup [

	self explicitRequirement
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> isChecked [

	^ self currentState notNil and: [ self currentState name = #checked ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> isUnchecked [

	^ self currentState notNil and: [ self currentState name = #unchecked ]
]

{ #category : #'t - toggle group' }
TToCheckableWidget >> removeFromGroup [

	self group remove: self
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> uncheck [

	self group ifNotNil: [ ^ self ].
	self switchToStateNamed: #unchecked
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> uncheckFromGroup [

	self switchToStateNamed: #unchecked
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> whenCheckedDo: aBlock [

	(self stateNamed: #checked) whenEnterDo: [:ann | aBlock cull: ann widget ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> whenUncheckedDo: aBlock [

	(self stateNamed: #unchecked ) whenEnterDo: [:ann | aBlock cull: ann widget ]
]
