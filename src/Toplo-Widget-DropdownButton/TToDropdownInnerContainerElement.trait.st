Trait {
	#name : #TToDropdownInnerContainerElement,
	#category : #'Toplo-Widget-DropdownButton'
}

{ #category : #'t - dropdown inner container' }
TToDropdownInnerContainerElement >> dropdownButton [ 

	^ self explicitRequirement 
]

{ #category : #'t - dropdown inner container' }
TToDropdownInnerContainerElement >> dropdownButton: aDropdownButton [

	^ self explicitRequirement 
]

{ #category : #'t - dropdown inner container' }
TToDropdownInnerContainerElement >> onSelectionChangedInPopupListElement: anEvent [

	self refreshFromPopupListSelection.
	self requestLayout
]

{ #category : #'t - dropdown inner container' }
TToDropdownInnerContainerElement >> popupWindowManager [

	^ self dropdownButton popupWindowManager
]

{ #category : #'t - dropdown inner container' }
TToDropdownInnerContainerElement >> refreshFromPopupListSelection [

	^ self explicitRequirement 
]

{ #category : #'t - dropdown inner container' }
TToDropdownInnerContainerElement >> windowManager [

	self
		deprecated: 'Use #popupWindowManager'
		transformWith: '`@rcvr windowManager' -> '`@rcvr popupWindowManager'.
	^ self selectElement popupWindowManager
]
