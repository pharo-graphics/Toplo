Trait {
	#name : #TToCheckableWidgetWithIndeterminate,
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - checking accessing state' }
TToCheckableWidgetWithIndeterminate >> hasIndeterminateState [

	^ self explicitRequirement 
]

{ #category : #'t - checking accessing state' }
TToCheckableWidgetWithIndeterminate >> hasIndeterminateState: aBoolean [

	self explicitRequirement 
]

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> indeterminate [

	self hasIndeterminateState ifFalse: [ ^ self ].
	self switchToStateNamed: #indeterminate
]

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> isIndeterminate [

	^ self currentState notNil and: [ self currentState name = #indeterminate ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> startIndeterminate [

	self isIndeterminate ifTrue: [ ^ self ].
	self startState: (self stateNamed: #indeterminate)
]

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> whenIndeterminateDo: aBlock [

	(self stateNamed: #indeterminate ) whenEnterDo: [:ann | aBlock cull: ann widget ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> withIndeterminate [

	self hasIndeterminateState: true
]

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> withoutIndeterminate [

	self hasIndeterminateState: false
]
