Trait {
	#name : #TToCheckableWidget,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - toggle group' }
TToCheckableWidget >> addToGroup: aToggleGroup [

	aToggleGroup add: self
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> check [

	self switchToStateNamed: #checked
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> indeterminate [

	self switchToStateNamed: #indeterminate
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> isChecked [

	^ self currentState notNil and: [ self currentState name = #checked ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> isIndeterminate [

	^ self currentState notNil and: [ self currentState name = #indeterminate ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> isUnchecked [

	^ self currentState notNil and: [ self currentState name = #unchecked ]
]

{ #category : #'t - toggle group' }
TToCheckableWidget >> removeFromGroup: aToggleGroup [

	aToggleGroup remove: self
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> uncheck [

	self switchToStateNamed: #unchecked
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> whenCheckedDo: aBlock [

	(self stateNamed: #checked) whenEnterDo: [:ann | aBlock cull: ann widget ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> whenIndeterminateDo: aBlock [

	(self stateNamed: #indeterminate ) whenEnterDo: [:ann | aBlock cull: ann widget ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> whenUncheckedDo: aBlock [

	(self stateNamed: #unchecked ) whenEnterDo: [:ann | aBlock cull: ann widget ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> withIndeterminate [

	self dresserDoOrDefer: [ :d | d withIndeterminateIn: self ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> withoutIndeterminate [

	self dresserDoOrDefer: [ :d | d withoutIndeterminateIn: self ]
]
