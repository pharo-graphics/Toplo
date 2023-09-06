Trait {
	#name : #TToCheckbox,
	#instVars : [
		'group',
		'checkedImage',
		'uncheckedImage',
		'indeterminateImage',
		'disabledImage'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - checkbox - group' }
TToCheckbox >> addToGroup: aToggleGroup [

	aToggleGroup add: self.
	self group: aToggleGroup 
]

{ #category : #'t - checkbox  - protocol' }
TToCheckbox >> check [

	self explicitRequirement 
]

{ #category : #'t - checkbox - accessing' }
TToCheckbox >> checked [

	^ self explicitRequirement  
]

{ #category : #'t - checkbox - accessing' }
TToCheckbox >> checked: aBooleanOrNil [
	" change the checkable state. nil means indeterminate. "

	self explicitRequirement 
]

{ #category : #'t - checkbox - accessing' }
TToCheckbox >> checkedImage [

	^ checkedImage
]

{ #category : #'t - checkbox - accessing' }
TToCheckbox >> checkedImage: anImage [

	checkedImage := anImage
]

{ #category : #'t - checkbox - accessing' }
TToCheckbox >> disabledImage [

	^ disabledImage
]

{ #category : #'t - checkbox - accessing' }
TToCheckbox >> disabledImage: anImage [

	disabledImage := anImage
]

{ #category : #'t - checkbox - group' }
TToCheckbox >> group [

	^ group
]

{ #category : #'t - checkbox - group' }
TToCheckbox >> group: aCheckableGroup [

	self withIndeterminate ifTrue: [
		Error signal:
			'Invalid checkable use: indeterminate state is not allowed with a checkable group' ].

	self when: ToCheckableCheckRequest do: [ :event | aCheckableGroup checkRequestEvent: event ].
	group := aCheckableGroup
]

{ #category : #'t - checkbox - accessing' }
TToCheckbox >> indeterminateImage [

	^ indeterminateImage
]

{ #category : #'t - checkbox - accessing' }
TToCheckbox >> indeterminateImage: anImage [

	indeterminateImage := anImage
]

{ #category : #'t - checkbox - testing' }
TToCheckbox >> isChecked [

	^ self explicitRequirement 
]

{ #category : #'t - checkbox - testing' }
TToCheckbox >> isIndeterminate [

	^ self explicitRequirement 
]

{ #category : #'t - checkbox - testing' }
TToCheckbox >> isUnchecked [

	^ self explicitRequirement 
]

{ #category : #'t - checkbox - group' }
TToCheckbox >> removeFromGroup [

	self group remove: self
]

{ #category : #'t - checkbox - private protocol' }
TToCheckbox >> switchToNextState [

	self explicitRequirement 
]

{ #category : #'t - checkbox  - protocol' }
TToCheckbox >> uncheck [

	self explicitRequirement 
]

{ #category : #'t - checkbox - accessing' }
TToCheckbox >> uncheckedImage [

	^ uncheckedImage
]

{ #category : #'t - checkbox - accessing' }
TToCheckbox >> uncheckedImage: anImage [

	uncheckedImage := anImage
]

{ #category : #'t - checkbox  - protocol' }
TToCheckbox >> withIndeterminate [

	self explicitRequirement 
]

{ #category : #'t - checkbox  - protocol' }
TToCheckbox >> withIndeterminate: aBoolean [

	self explicitRequirement 
]
