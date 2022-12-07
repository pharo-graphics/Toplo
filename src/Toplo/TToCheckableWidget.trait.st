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

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> checkedIconImage [

	^ self userData at: #checkedIconImage ifAbsent: [  ]
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> checkedIconImage: anIconImage [

	^ self userData at: #checkedIconImage put: anIconImage
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> checkedState [

	^ self userData at: #checkedState ifAbsent: [  ]
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> checkedState: aState [

	^ self userData at: #checkedState put: aState
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> indeterminate [

	self switchToStateNamed: #indeterminate
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> indeterminateIconImage [

	^ self userData at: #indeterminateIconImage ifAbsent: [  ]
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> indeterminateIconImage: anInconImage [

	^ self userData at: #indeterminateIconImage put: anInconImage
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> indeterminateState [

	^ self userData at: #indeterminateState ifAbsent: [  ]
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> indeterminateState: aState [

	^ self userData at: #indeterminateState put: aState
]

{ #category : #'t - initialization checkable' }
TToCheckableWidget >> initializeAsCheckable [

	self withoutIndeterminate
	
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> isChecked [

	^ self currentState notNil and: [ self currentState name = self checkedStateName ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> isIndeterminate [

	^ self currentState notNil and: [ self currentState name = self indeterminateStateName ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> isUnchecked [

	^ self currentState notNil and: [ self currentState name = self uncheckedStateName ]
]

{ #category : #'t - toggle group' }
TToCheckableWidget >> removeFromGroup: aToggleGroup [

	aToggleGroup remove: self
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> uncheck [

	self switchToStateNamed: #unchecked
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> uncheckedIconImage [

	^ 	self userData at: #uncheckedIconImage ifAbsent: [  ]
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> uncheckedIconImage: anInconImage [

	^ 	self userData at: #uncheckedIconImage put: anInconImage
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> uncheckedState [

	^ self userData at: #uncheckedState ifAbsent: [  ]
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> uncheckedState: aState [

	^ self userData at: #uncheckedState put: aState
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

	self setUpStatesWith: { 
		  self indeterminateState.
		  self checkedState.
		  self uncheckedState }
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> withoutIndeterminate [

	self setUpStatesWith: { 
		  self uncheckedState.
		  self checkedState }
]
