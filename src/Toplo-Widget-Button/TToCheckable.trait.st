Trait {
	#name : #TToCheckable,
	#category : 'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable  - protocol' }
TToCheckable >> check [

	self checked: true
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checked [

	^ self userData at: #checked ifAbsentPut: [
		  self withIndeterminate
			  ifTrue: [  ]
			  ifFalse: [ false ] ]
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checked: aBooleanOrNil [
	" change the checkable state. nil means indeterminate. "

	| request |
	(aBooleanOrNil isNil and: [ self withIndeterminate not ]) ifTrue: [
		Error signal: 'nil not allowed except when indeterminate is explicitly allowed ' ].
	request := ToCheckableCheckRequest new
		           checked: aBooleanOrNil;
		           yourself.
	" give a chance to the button group to verify and change the result of the checking"
	self dispatchEvent: request.
	" update with the result that has been eventually changed by the group according to its strategy"
	self privateChecked: request checked.
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isChecked [

	" since checked can be nil, test is with = "
	^ self checked = true
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isIndeterminate [

	^ self checked isNil
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isUnchecked [

	" since checked can be nil, test is with = "
	^ self checked = false
]

{ #category : #'t - checkable - private protocol' }
TToCheckable >> nextCheckValue [

	self withIndeterminate ifTrue: [ " unchecked -> indeterminate -> checked"
		self isIndeterminate ifTrue: [ ^ true ].
		self isChecked ifTrue: [ ^ false ].
		^ nil ].
	^ self checked not
]

{ #category : #'t - checkable - private protocol' }
TToCheckable >> privateChecked: aBooleanOrNil [

	| prev |
	self checked = aBooleanOrNil ifTrue: [ ^ self ].
	prev := self checked.
	self userData at: #checked put: aBooleanOrNil.
	self dispatchEvent: (ToCheckableCheckedEvent current: self checked previous: prev)
]

{ #category : #'t - checkable - private protocol' }
TToCheckable >> switchToNextCheckStateOnClick [

	self checked: self nextCheckValue 
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> uncheck [

	self checked: false
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> withIndeterminate [

	^ self userData at: #withIndeterminate ifAbsentPut: [  false ]
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> withIndeterminate: aBoolean [

	self userData at: #withIndeterminate put: aBoolean
]
