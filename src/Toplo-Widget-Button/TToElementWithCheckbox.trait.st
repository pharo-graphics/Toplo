Trait {
	#name : #TToElementWithCheckbox,
	#category : 'Toplo-Widget-Button-Core'
}

{ #category : #'t - checkbox - group' }
TToElementWithCheckbox >> addToGroup: aToggleGroup [

	self checkbox addToGroup: aToggleGroup
]

{ #category : #'t - checkbox - accessing' }
TToElementWithCheckbox >> checkbox [

	^ self explicitRequirement
]

{ #category : #'t - checkbox - group' }
TToElementWithCheckbox >> group [

	^ self checkbox group
]

{ #category : #'t - checkbox - group' }
TToElementWithCheckbox >> group: aCheckableGroup [

	self checkbox group: aCheckableGroup
]

{ #category : #'t - checkbox - group' }
TToElementWithCheckbox >> removeFromGroup [

	self checkbox removeFromGroup
]
