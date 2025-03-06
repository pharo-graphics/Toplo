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

	^ self checkableData allowIndeterminate
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> allowIndeterminate: aBoolean [

	self checkableData allowIndeterminate: aBoolean
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> check [

	self checked: true
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checkableData [

	^ self userData at: #checkableData ifAbsent: [  ]
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checkableData: aCheckableData [

	self userData at: #checkableData put: aCheckableData
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checkableEventHandler [

	^ self checkableData ifNotNil: [ :cd | cd eventHandler ]
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checkableEventHandler: anEventHandler [

	self checkableData eventHandler: anEventHandler
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> checkableEventHandlerClass [

	^ ToCheckableEventHandler
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checked [

	^ self checkableData checked
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> checked: aBooleanOrIndeterminate [

	self checkableData checked: aBooleanOrIndeterminate 
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> ensureCheckableData [

	self checkableData ifNil: [
		self checkableData: (ToCheckableData new
				 owner: self;
				 yourself) ]
]

{ #category : #'t - checkable - group' }
TToCheckable >> group [

	^ self checkableData ifNotNil: [ :cd | cd group ]
]

{ #category : #'t - checkable - group' }
TToCheckable >> group: aCheckableGroup [

	self allowIndeterminate ifTrue: [
		Error signal:
			'Invalid checkable use: indeterminate state is not allowed with a checkable group' ].
	self checkableData group: aCheckableGroup
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> initializeAsCheckable [

	self ensureCheckableData.
	self checkableEventHandler: self newCheckableEventHandler .
	self addEventHandler: self checkableEventHandler
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isCheckable [

	^ self checkableData notNil
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isChecked [

	^ self checkableData isChecked
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isIndeterminate [

	^ self checkableData isIndeterminate
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isUnchecked [

	^ self checkableData  isUnchecked
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> linkClass [

	^ ToCheckableLink
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> newCheckableEventHandler [

	^ self checkableEventHandlerClass new
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> privateChecked: aBoolean [

	self checkableData privateChecked: aBoolean
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

	self checkableData switchToNextCheckState
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> uncheck [

	self checked: false
]

{ #category : #'t - checkable - group' }
TToCheckable >> unregisterFromGroup [

	self group ifNotNil: [:grp | grp unregister: self ]
]
