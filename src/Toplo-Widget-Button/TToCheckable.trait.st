Trait {
	#name : #TToCheckable,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable - group' }
TToCheckable >> addToGroup: aGroup [

	self
		deprecated: 'send #registerInGroup: instead'
		transformWith:
		'`@receiver addToGroup: `@arg'
		-> '`@receiver registerInGroup: `@arg'.


	self registerInGroup: aGroup
]

{ #category : #'t - checkable - testing' }
TToCheckable >> allowUnchecking [

	^ self group isNil or: [ self group allowUnchecking ]
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

	| current |
	aBooleanOrIndeterminate ifNil: [ Error signal: 'nil not allowed' ].
	(aBooleanOrIndeterminate isSymbol and: [ self withIndeterminate not ])
		ifTrue: [
			Error signal:
				'a symbol not allowed except when indeterminate is explicitly allowed ' ].
	self isDisabled ifTrue: [ ^ self ].
	current := self rawChecked.
	self group ifNotNil: [ :grp |
		(grp allowChangeWith: aBooleanOrIndeterminate forCheckable: self)
			ifFalse: [ ^ self ] ].
	aBooleanOrIndeterminate = current ifTrue: [ ^ self ].
	self privateChecked: aBooleanOrIndeterminate.
	self dispatchEvent: (ToCheckableChangedEvent new
			 checked: self rawChecked;
			 yourself)
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
	self rawGroup: aCheckableGroup
]

{ #category : #'t - checkable - testing' }
TToCheckable >> hasNoneStrategy [

	^ self group isNil or: [ self group hasNoneStrategy ]
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> initializeCheckable [

	self addEventHandler: self newCheckableEventHandler 
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

{ #category : #'t - checkable  - protocol' }
TToCheckable >> newCheckableEventHandler [

	^ ToCheckableEventHandler new
]

{ #category : #'t - checkable - private protocol' }
TToCheckable >> nextCheckValue [

	self withIndeterminate ifTrue: [ " unchecked -> indeterminate -> checked"
		self isIndeterminate ifTrue: [ ^ true ].
		self isChecked ifTrue: [ ^ false ].
		^ #indeterminate ].
	^ self checked not
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

{ #category : #'t - checkable - group' }
TToCheckable >> registerInGroup: aGroup [

	aGroup register: self.
	self group: aGroup
]

{ #category : #'t - checkable - group' }
TToCheckable >> removeFromGroup [

	self
		deprecated: 'send #unregisterFromGroup instead'
		transformWith:
		'`@receiver removeFromGroup'
		-> '`@receiver unregisterFromGroup'.


	self unregisterFromGroup
]

{ #category : #'t - checkable - private protocol' }
TToCheckable >> switchToNextCheckState [

	self checked: self nextCheckValue 
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> uncheck [

	self checked: false
]

{ #category : #'t - checkable - group' }
TToCheckable >> unregisterFromGroup [

	self group remove: self
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> withIndeterminate [

	^ self explicitRequirement 
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> withIndeterminate: aBoolean [

	self explicitRequirement 
]
