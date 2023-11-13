Trait {
	#name : 'TToCheckable',
	#category : 'Toplo-Widget-Button-Checkable',
	#package : 'Toplo-Widget-Button',
	#tag : 'Checkable'
}

{ #category : 't - checkable  - protocol' }
TToCheckable >> check [

	self checked: true
]

{ #category : 't - checkable - accessing' }
TToCheckable >> checked [

	^ self userData at: #checked ifAbsentPut: [ false ]
]

{ #category : 't - checkable - accessing' }
TToCheckable >> checked: aBooleanOrIndeterminate [
	" change the checkable state. nil means indeterminate. "

	| request prev |
	aBooleanOrIndeterminate ifNil: [
		Error signal: 'nil not allowed' ].
	(aBooleanOrIndeterminate isSymbol and: [ self withIndeterminate not ]) ifTrue: [
		Error signal: 'a symbol not allowed except when indeterminate is explicitly allowed ' ].
	prev := self rawChecked.
	request := ToCheckableCheckRequest new
		           checked: aBooleanOrIndeterminate;
		           yourself.
	" give a chance to the button group to verify and change the result of the checking"
	self dispatchEvent: request.
	" update with the result that has been eventually changed by the group according to its strategy"
	self privateChecked: request checked.
	prev = self checked ifTrue: [ ^ self ].
	" dispatch an event usable by group as it is dispatched only once for all buttons of a group "
	self dispatchEvent: ToCheckableChangedEvent new
]

{ #category : 't - checkable - testing' }
TToCheckable >> isChecked [

	" since checked can be nil, test is with = "
	^ self checked = true
]

{ #category : 't - checkable - testing' }
TToCheckable >> isIndeterminate [

	^ self checked isSymbol
]

{ #category : 't - checkable - testing' }
TToCheckable >> isUnchecked [

	" since checked can be nil, test is with = "
	^ self checked = false
]

{ #category : 't - checkable - private protocol' }
TToCheckable >> nextCheckValue [

	self withIndeterminate ifTrue: [ " unchecked -> indeterminate -> checked"
		self isIndeterminate ifTrue: [ ^ true ].
		self isChecked ifTrue: [ ^ false ].
		^ #indeterminate ].
	^ self checked not
]

{ #category : 't - checkable - private protocol' }
TToCheckable >> privateChecked: aBooleanOrIndeterminate [

	| prev request |
	request := aBooleanOrIndeterminate.
	self rawChecked = request ifTrue: [ ^ self ].
	prev := self checked.
	self userData at: #checked put: request.
	self dispatchEvent: (ToCheckableCheckedEvent current: request previous: prev)
]

{ #category : 't - checkable - accessing' }
TToCheckable >> rawChecked [

	^ self userData at: #checked ifAbsent: [ ]
]

{ #category : 't - checkable - private protocol' }
TToCheckable >> switchToNextCheckStateOnClick [

	self checked: self nextCheckValue 
]

{ #category : 't - checkable  - protocol' }
TToCheckable >> uncheck [

	self checked: false
]

{ #category : 't - checkable  - protocol' }
TToCheckable >> withIndeterminate [

	^ self userData at: #withIndeterminate ifAbsentPut: [  false ]
]

{ #category : 't - checkable  - protocol' }
TToCheckable >> withIndeterminate: aBoolean [

	self userData at: #withIndeterminate put: aBoolean
]
