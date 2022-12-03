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

	self switchToStateNamed: self checkedStateName 
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> checkedIconImage [

	^ self explicitRequirement 
]

{ #category : #'t - initialization checkable' }
TToCheckableWidget >> checkedStateName [

	^ #checked
]

{ #category : #'t - initialization checkable' }
TToCheckableWidget >> defaultCheckedState [

	^ ToWidgetState new
		  name: self checkedStateName;
		  widgetStencil: [ :widget | widget iconImage: self checkedIconImage ];
		  yourself
]

{ #category : #'t - initialization checkable' }
TToCheckableWidget >> defaultIndeterminateState [

	^ ToWidgetState new
		  name: self indeterminateStateName;
		  widgetStencil: [ :widget |  widget iconImage: self inderterminateIconImage ];
		  yourself
]

{ #category : #'t - initialization checkable' }
TToCheckableWidget >> defaultStatesWithIndeterminate [

	^ { 
		  self defaultIndeterminateState.
		  self defaultCheckedState.
		  self defaultUncheckedState }
]

{ #category : #'t - initialization checkable' }
TToCheckableWidget >> defaultStatesWithoutIndeterminate [

	^ { 
		  (ToWidgetState new
			   name: self uncheckedStateName;
			   widgetStencil: [ :button | 
				   button iconImage: self uncheckedIconImage ];
			   yourself).
		  (ToWidgetState new
			   name: self checkedStateName;
			   widgetStencil: [ :button | 
				   button iconImage: self checkedIconImage ];
			   yourself) }
]

{ #category : #'t - initialization checkable' }
TToCheckableWidget >> defaultUncheckedState [

	^ ToWidgetState new
		  name: self uncheckedStateName;
		  widgetStencil: [ :widget | widget iconImage: self uncheckedIconImage ];
		  yourself
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> inderterminateIconImage [

	^ self explicitRequirement 
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> indeterminate [

	self switchToStateNamed: self indeterminateStateName 
]

{ #category : #'t - initialization checkable' }
TToCheckableWidget >> indeterminateStateName [

	^ #unchecked
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

	self switchToStateNamed: self uncheckedStateName 
]

{ #category : #'t - accessing checkable' }
TToCheckableWidget >> uncheckedIconImage [

	^ self explicitRequirement 
]

{ #category : #'t - initialization checkable' }
TToCheckableWidget >> uncheckedStateName [

	^ #unchecked
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> whenCheckedDo: aBlock [

	(self stateNamed: self checkedStateName) changeAction: aBlock
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> whenIndeterminateDo: aBlock [

	(self stateNamed: self indeterminateStateName ) changeAction: aBlock
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> whenUncheckedDo: aBlock [

	(self stateNamed: self uncheckedStateName ) changeAction: aBlock
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> withIndeterminate [

	self setUpStatesWith: self defaultStatesWithIndeterminate
]

{ #category : #'t - checking protocol' }
TToCheckableWidget >> withoutIndeterminate [

	self setUpStatesWith: self defaultStatesWithoutIndeterminate
]
