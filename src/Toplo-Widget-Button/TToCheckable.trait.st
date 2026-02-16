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

{ #category : #'t - checkable - accessing' }
TToCheckable >> allowIndeterminate [

	^ self checkableState allowIndeterminate
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> allowIndeterminate: aBoolean [

	self checkableState allowIndeterminate: aBoolean
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> check [

	self checked: true
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checkableEventHandler [

	^ self checkableState ifNotNil: [ :cd | cd eventHandler ]
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checkableEventHandler: anEventHandler [

	self checkableState eventHandler: anEventHandler
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> checkableEventHandlerClass [

	^ ToCheckableEventHandler
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checkableState [

	^ self userData at: #checkableState ifAbsent: [  ]
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checkableState: aCheckableState [

	self userData at: #checkableState put: aCheckableState
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checked [

	^ self checkableState checked
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> checked: aBooleanOrIndeterminate [

	self checkableState requestChecked: aBooleanOrIndeterminate 
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> ensureCheckableState [

	self checkableState ifNil: [
		self checkableState: (ToCheckableState new
				 owner: self;
				 yourself) ]
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> ensureChecked: aBooleanOrIndeterminate [

	self checkableState ensureChecked: aBooleanOrIndeterminate 
]

{ #category : #'t - checkable - group' }
TToCheckable >> group [

	^ self checkableState ifNotNil: [ :cd | cd group ]
]

{ #category : #'t - checkable - group' }
TToCheckable >> group: aCheckableGroup [

	self allowIndeterminate ifTrue: [
		Error signal:
			'Invalid checkable use: indeterminate state is not allowed with a checkable group' ].
	self checkableState group: aCheckableGroup
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> initializeAsCheckable [

	self ensureCheckableState.
	self checkableEventHandler: self newCheckableEventHandler .
	self addEventHandler: self checkableEventHandler
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isCheckable [

	^ self checkableState notNil
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isChecked [

	^ self isCheckable and: [ self checkableState isChecked ]
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isIndeterminate [

	^ self isCheckable and: [ self checkableState isIndeterminate ]
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isUnchecked [

	^ self isCheckable and: [ self checkableState isUnchecked ]
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> newCheckableEventHandler [

	^ self checkableEventHandlerClass new
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> privateChecked: aBoolean [

	self checkableState privateChecked: aBoolean
]

{ #category : #'t - checkable - group' }
TToCheckable >> registerInGroup: aGroup [

	aGroup register: self.
	self group: aGroup
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> releaseCheckable [

	self removeEventHandler: self checkableEventHandler.
	self checkableEventHandler: nil.
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

{ #category : #'t - checkable  - protocol' }
TToCheckable >> switchToNextCheckState [

	self checkableState switchToNextCheckState
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> switchToNextCheckStateOnClick [

	^ self checkableState switchToNextCheckStateOnClick
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> switchToNextCheckStateOnClick: aBoolean [

	self checkableState switchToNextCheckStateOnClick: aBoolean
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> uncheck [

	self checked: false
]

{ #category : #'t - checkable - group' }
TToCheckable >> unregisterFromGroup [

	self group unregister: self.
	self group: nil
]
