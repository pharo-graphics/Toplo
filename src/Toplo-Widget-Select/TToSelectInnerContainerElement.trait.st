Trait {
	#name : #TToSelectInnerContainerElement,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> filterTextField [

	self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> filterTextField: aTextField [

	self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> installFilterTextField [ 

	self filterTextField: self newFilterTextField.
	self filterTextField constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	self addChild: self filterTextField
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> isFiltrable [

	^ self selectElement isFiltrable
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> newFilterTextField [

	^ ToSelectFilterTextField new on: self selectElement
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> selectElement [

	self
		deprecated: 'Use #dropdownButton instead'
		transformWith: '`@rcvr selectElement' -> '`@rcvr dropdownButton'.
	^ self dropdownButton
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> selectElement: aSelectElement [

	self
		deprecated: 'Use #dropdownButton: instead'
		transformWith: '`@rcvr selectElement: `@arg' -> '`@rcvr dropdownButton: `@arg'.
	self dropdownButton: aSelectElement

]
