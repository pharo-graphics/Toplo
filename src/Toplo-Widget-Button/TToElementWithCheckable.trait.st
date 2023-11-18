Trait {
	#name : 'TToElementWithCheckable',
	#category : 'Toplo-Widget-Button-Core',
	#package : 'Toplo-Widget-Button',
	#tag : 'Core'
}

{ #category : 't - checkable - group' }
TToElementWithCheckable >> addToGroup: aGroup [

	aGroup add: self checkable.
	self checkable group: aGroup 
]

{ #category : 't - checkable  - protocol' }
TToElementWithCheckable >> check [

	self checked: true
]

{ #category : 't - checkable - accessing' }
TToElementWithCheckable >> checkable [

	^ self explicitRequirement 
]

{ #category : 't - checkable - accessing' }
TToElementWithCheckable >> checked [

	^ self checkable checked
]

{ #category : 't - checkable - accessing' }
TToElementWithCheckable >> checked: aBooleanOrNil [
	" change the checkable state. nil means indeterminate. "

	self checkable checked: aBooleanOrNil
]

{ #category : 't - checkable - group' }
TToElementWithCheckable >> group [

	^ self checkable group
]

{ #category : 't - checkable - group' }
TToElementWithCheckable >> group: aCheckableGroup [

	self checkable group: aCheckableGroup
]

{ #category : 't - checkable - testing' }
TToElementWithCheckable >> isChecked [

	" since checked can be nil, test is with = "
	^ self checkable isChecked
]

{ #category : 't - checkable - testing' }
TToElementWithCheckable >> isIndeterminate [

	^ self checkable isIndeterminate
]

{ #category : 't - checkable - testing' }
TToElementWithCheckable >> isUnchecked [

	" since checked can be nil, test is with = "
	^ self checkable isUnchecked 
]

{ #category : 't - checkable - private protocol' }
TToElementWithCheckable >> privateChecked: aBooleanOrNil [

	self checkable privateChecked: aBooleanOrNil
]

{ #category : 't - checkable - group' }
TToElementWithCheckable >> removeFromGroup [

	self checkable removeFromGroup
]

{ #category : 't - checkable  - protocol' }
TToElementWithCheckable >> uncheck [

	self checked: false
]

{ #category : 't - checkable  - protocol' }
TToElementWithCheckable >> withIndeterminate [

	^ self checkable withIndeterminate
]

{ #category : 't - checkable  - protocol' }
TToElementWithCheckable >> withIndeterminate: aBoolean [

	self checkable withIndeterminate: aBoolean
]
