Trait {
	#name : #TToCheckable,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - checkable - group private' }
TToCheckable >> addCheckableEventHandlers [

	| requestHandler changedHandler |
	requestHandler := BlEventHandler
		                  on: ToCheckableCheckRequest
		                  do: [ :event | 
			                  self group ifNotNil: [ :grp |
				                  grp checkRequestEvent: event ] ].
	changedHandler := BlEventHandler
		                  on: ToCheckableChangedEvent
		                  do: [ :event |
			                  self group ifNotNil: [ :grp |
				                  grp checkableChangedEvent: event ] ].
	self userData at: #requestHandler put: requestHandler.
	self userData at: #changedHandler put: changedHandler.
	self addEventHandler: requestHandler.
	self addEventHandler: changedHandler
]

{ #category : #'t - checkable - group' }
TToCheckable >> addToGroup: aGroup [

	aGroup add: self.
	self group: aGroup 
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> check [

	self checked: true
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checked [

	^ self rawChecked
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checked: aBooleanOrIndeterminate [

	| current request |
	aBooleanOrIndeterminate ifNil: [ Error signal: 'nil not allowed' ].
	(aBooleanOrIndeterminate isSymbol and: [ self withIndeterminate not ]) ifTrue: [
		Error signal:
			'a symbol not allowed except when indeterminate is explicitly allowed ' ].
	self isDisabled ifTrue: [ ^ self ].
	current := self rawChecked.
	request := ToCheckableCheckRequest new.
	request checked: aBooleanOrIndeterminate.
	self
		dispatchEvent: request;
		privateChecked: request checked.
	current = self checked ifTrue: [ ^ self ].
	self dispatchEvent: ToCheckableChangedEvent new
]

{ #category : #'t - checkable - group' }
TToCheckable >> group [

	^ self rawGroup
]

{ #category : #'t - checkable - group' }
TToCheckable >> group: aCheckableGroup [

	self withIndeterminate ifTrue: [
		Error signal:
			'Invalid checkable use: indeterminate state is not allowed with a checkable group' ].
	self rawGroup: aCheckableGroup.
	aCheckableGroup
		ifNil: [ self removeCheckableEventHandlers ]
		ifNotNil: [ self addCheckableEventHandlers ]
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isChecked [

	" since checked can be nil, test is with = "
	^ self checked = true
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isIndeterminate [

	^ self checked isSymbol
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
		^ #indeterminate ].
	^ self checked not
]

{ #category : #'t - checkable - state generator' }
TToCheckable >> onSkinStateGeneratorAdded: aSkinStateGenerator [

	super onSkinStateGeneratorAdded: aSkinStateGenerator.
	self dispatchEvent: (ToCheckableCheckEvent current: self isChecked previous: nil)
]

{ #category : #'t - checkable - private protocol' }
TToCheckable >> privateChecked: aBooleanOrIndeterminate [

	| prev request |
	request := aBooleanOrIndeterminate.
	self rawChecked = request ifTrue: [ ^ self ].
	prev := self checked.
	self rawChecked: request.
	" finally dispatch the event used to generate the state for the skin "
	self dispatchEvent: (ToCheckableCheckEvent current: request previous: prev)
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> rawChecked [

	^ self explicitRequirement 
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> rawChecked: anObject [

	self explicitRequirement 
]

{ #category : #'t - checkable - group' }
TToCheckable >> rawGroup [

	^ self explicitRequirement 
]

{ #category : #'t - checkable - group' }
TToCheckable >> rawGroup: aGroup [

	^ self explicitRequirement 
]

{ #category : #'t - checkable - group private' }
TToCheckable >> removeCheckableEventHandlers [

	| requestHandler changedHandler |
	requestHandler := self userData at: #requestHandler ifAbsent: [  ].
	changedHandler := self userData at: #changedHandler ifAbsent: [  ].
	requestHandler ifNotNil: [
		self removeEventHandler: requestHandler.
		self userData removeKey: #requestHandler ].
	changedHandler ifNotNil: [
		self removeEventHandler: changedHandler.
		self userData removeKey: #changedHandler ]
]

{ #category : #'t - checkable - group' }
TToCheckable >> removeFromGroup [

	self group remove: self
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

	^ self explicitRequirement 
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> withIndeterminate: aBoolean [

	self explicitRequirement 
]
