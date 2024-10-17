Trait {
	#name : #TToSelectInnerContainerElement,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> installTextInputElement [ 

	self textInputElement: ToSelectTextInputElement new.
	self textInputElement onInstalledIn: self.
	self textInputElement constraintsDo: [ :c |
		c linear vertical alignCenter.
		c flow vertical alignCenter ].
	self addChild: self textInputElement
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> isFiltrable [

	^ self selectElement isFiltrable
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
TToSelectInnerContainerElement >> textInputElement [

	self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> textInputElement: aTextInputElement [

	self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> windowManager [

	self
		deprecated: 'Use #popupWindowManager'
		transformWith: '`@rcvr windowManager' -> '`@rcvr popupWindowManager'.
	^ self selectElement popupWindowManager
]
