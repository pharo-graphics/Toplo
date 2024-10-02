Trait {
	#name : #TToSelectInnerContainerElement,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> isFiltrable [

	^ self selectElement isFiltrable
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> onSelectionChangedInPopupListElement: anEvent [

	self refresh.
	self requestLayout
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> popupWindowManager [

	^ self selectElement popupWindowManager
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> refresh [

	self explicitRequirement 
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
TToSelectInnerContainerElement >> selectedDataTextField [

	^ self textInputElement selectedDataTextField
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> textInputElement [

	self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> textInputElementClass [

	self explicitRequirement 
]

{ #category : #'t - select inner container' }
TToSelectInnerContainerElement >> windowManager [

	self
		deprecated: 'Use #popupWindowManager'
		transformWith: '`@rcvr windowManager' -> '`@rcvr popupWindowManager'.
	^ self selectElement popupWindowManager
]
