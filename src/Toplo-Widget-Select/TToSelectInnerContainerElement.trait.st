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
TToSelectInnerContainerElement >> onSelectionChangedInPopupListElement: anEvent [

	self refreshFromPopupListSelection.
	self requestLayout
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> popupWindowManager [

	^ self selectElement popupWindowManager
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> refreshFromPopupListSelection [

	^ self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> selectElement [

	^ self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> selectElement: aSelectElement [

	self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> windowManager [

	self
		deprecated: 'Use #popupWindowManager'
		transformWith: '`@rcvr windowManager' -> '`@rcvr popupWindowManager'.
	^ self selectElement popupWindowManager
]
