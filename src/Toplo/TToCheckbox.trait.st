Trait {
	#name : #TToCheckbox,
	#instVars : [
		'group',
		'checkedImage',
		'uncheckedImage',
		'indeterminateImage',
		'disabledImage'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - checkable - group' }
TToCheckbox >> addToGroup: aToggleGroup [

	aToggleGroup add: self.
	self group: aToggleGroup 
]

{ #category : #'t - checkable  - protocol' }
TToCheckbox >> check [

	self explicitRequirement 
]

{ #category : #'t - checkable - accessing' }
TToCheckbox >> checked [

	^ self explicitRequirement  
]

{ #category : #'t - checkable - accessing' }
TToCheckbox >> checked: aBooleanOrNil [
	" change the checkable state. nil means indeterminate. "

	self explicitRequirement 
]

{ #category : #'t - checkable - accessing' }
TToCheckbox >> checkedImage [

	^ checkedImage
]

{ #category : #'t - checkable - accessing' }
TToCheckbox >> checkedImage: anImage [

	checkedImage := anImage
]

{ #category : #'t - checkable - accessing' }
TToCheckbox >> disabledImage [

	^ disabledImage
]

{ #category : #'t - checkable - accessing' }
TToCheckbox >> disabledImage: anImage [

	disabledImage := anImage
]

{ #category : #'t - checkable - group' }
TToCheckbox >> group [

	^ group
]

{ #category : #'t - checkable - group' }
TToCheckbox >> group: aCheckableGroup [

	self withIndeterminate ifTrue: [
		Error signal:
			'Invalid checkable use: indeterminate state is not allowed with a checkable group' ].

	self when: ToCheckableCheckRequest do: [ :event | aCheckableGroup checkRequestEvent: event ].
	group := aCheckableGroup
]

{ #category : #'t - checkable - accessing' }
TToCheckbox >> indeterminateImage [

	^ indeterminateImage
]

{ #category : #'t - checkable - accessing' }
TToCheckbox >> indeterminateImage: anImage [

	indeterminateImage := anImage
]

{ #category : #'t - checkable - testing' }
TToCheckbox >> isChecked [

	^ self explicitRequirement 
]

{ #category : #'t - checkable - testing' }
TToCheckbox >> isIndeterminate [

	^ self explicitRequirement 
]

{ #category : #'t - checkable - testing' }
TToCheckbox >> isUnchecked [

	^ self explicitRequirement 
]

{ #category : #'t - checkable - group' }
TToCheckbox >> removeFromGroup [

	self group remove: self
]

{ #category : #'t - checkable - private protocol' }
TToCheckbox >> switchToNextState [

	self explicitRequirement 
]

{ #category : #'t - checkable  - protocol' }
TToCheckbox >> uncheck [

	self explicitRequirement 
]

{ #category : #'t - checkable - accessing' }
TToCheckbox >> uncheckedImage [

	^ uncheckedImage
]

{ #category : #'t - checkable - accessing' }
TToCheckbox >> uncheckedImage: anImage [

	uncheckedImage := anImage
]

{ #category : #'t - checkable  - protocol' }
TToCheckbox >> withIndeterminate [

	self explicitRequirement 
]

{ #category : #'t - checkable  - protocol' }
TToCheckbox >> withIndeterminate: aBoolean [

	self explicitRequirement 
]
