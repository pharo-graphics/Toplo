Trait {
	#name : #TToCheckableWidgetWithIndeterminate,
	#traits : 'TToCheckableWidget',
	#classTraits : 'TToCheckableWidget classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> indeterminate [

	self switchToStateNamed: #indeterminate
]

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> isIndeterminate [

	^ self currentState notNil and: [ self currentState name = #indeterminate ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> whenIndeterminateDo: aBlock [

	(self stateNamed: #indeterminate ) whenEnterDo: [:ann | aBlock cull: ann widget ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> withIndeterminate [

	self dresserDoOrDefer: [ :d | d withIndeterminateIn: self ]
]

{ #category : #'t - checking protocol' }
TToCheckableWidgetWithIndeterminate >> withoutIndeterminate [

	self dresserDoOrDefer: [ :d | d withoutIndeterminateIn: self ]
]
