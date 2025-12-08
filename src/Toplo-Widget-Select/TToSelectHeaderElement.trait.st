Trait {
	#name : #TToSelectHeaderElement,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'t - select inner container' }
TToSelectHeaderElement >> filterTextField [

	self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectHeaderElement >> filterTextField: aTextField [

	self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectHeaderElement >> installFilterTextField [ 

	self filterTextField: self newFilterTextField.
	self filterTextField elevation: (BlRelativeElevation elevation: 16).
	self filterTextField constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	self addChild: self filterTextField
]

{ #category : #'t - select inner container' }
TToSelectHeaderElement >> isFiltrable [

	^ self selectElement isFiltrable
]

{ #category : #'t - select inner container' }
TToSelectHeaderElement >> manager [

	^ self selectElement manager
]

{ #category : #'t - select inner container' }
TToSelectHeaderElement >> newFilterTextField [

	^ ToSelectFilterTextField new on: self selectElement
]

{ #category : #'t - select inner container' }
TToSelectHeaderElement >> selectElement [

	^ self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectHeaderElement >> selectElement: aSelectElement [

	self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectHeaderElement >> updateFromPopupListSelection [

	^ self subclassResponsibility 
]

{ #category : #'t - select inner container' }
TToSelectHeaderElement >> windowManager [

	self
		deprecated: 'Use #manager instead'
		transformWith: '`@rcvr windowManager' -> '`@rcvr manager'.
	^ self manager
]
