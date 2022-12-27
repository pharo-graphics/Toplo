Trait {
	#name : #TToCheckableWithIndeterminate,
	#instVars : [
		'hasIndeterminateState'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - checking accessing state' }
TToCheckableWithIndeterminate >> hasIndeterminateState [

	^ hasIndeterminateState ifNil: [ hasIndeterminateState := false ]
]

{ #category : #'t - checking accessing state' }
TToCheckableWithIndeterminate >> hasIndeterminateState: aBoolean [

	aBoolean = self hasIndeterminateState ifTrue: [ ^ self ].
	hasIndeterminateState := aBoolean.
	self announce: 	(ToStatesDefinitionChangedAnnouncement new widget: self)

]

{ #category : #'t - checking protocol' }
TToCheckableWithIndeterminate >> indeterminate [

	self hasIndeterminateState ifFalse: [ ^ self ].
	self switchToStateNamed: #indeterminate
]

{ #category : #'t - checking protocol' }
TToCheckableWithIndeterminate >> isIndeterminate [

	^ self currentState notNil and: [ self currentState name = #indeterminate ]
]

{ #category : #'t - checking protocol' }
TToCheckableWithIndeterminate >> startIndeterminate [

	self isIndeterminate ifTrue: [ ^ self ].
	self startState: (self stateNamed: #indeterminate)
]

{ #category : #'t - checking protocol' }
TToCheckableWithIndeterminate >> whenIndeterminateDo: aBlock [

	(self stateNamed: #indeterminate ) whenEnterDo: [:ann | aBlock cull: ann widget ]
]

{ #category : #'t - checking protocol' }
TToCheckableWithIndeterminate >> withIndeterminate [

	self hasIndeterminateState: true
]

{ #category : #'t - checking protocol' }
TToCheckableWithIndeterminate >> withoutIndeterminate [

	self hasIndeterminateState: false
]
