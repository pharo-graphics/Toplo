Trait {
	#name : #TToCheckableWidgetWithIndeterminate,
	#instVars : [
		'hasIndeterminateState'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - checking accessing state' }
TToCheckableWidgetWithIndeterminate >> hasIndeterminateState [

	^ hasIndeterminateState ifNil: [ hasIndeterminateState := false ]
]

{ #category : #'t - checking accessing state' }
TToCheckableWidgetWithIndeterminate >> hasIndeterminateState: aBoolean [

	aBoolean = self hasIndeterminateState ifTrue: [ ^ self ].
	hasIndeterminateState := aBoolean.
	self announce: 	(ToStatesDefinitionChangedAnnouncement new widget: self)

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
