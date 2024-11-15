Trait {
	#name : #TToCheckableGroupOwner,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> checkedList [

	^ self group checkedList
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> checkingStrategy: aCheckingStrategy [

	self group checkingStrategy: aCheckingStrategy
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> group [

	^ self rawGroup
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> group: aGroup [

	self rawGroup: aGroup
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> hasNoneStrategy [

	^ self group hasNoneStrategy
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> rawGroup [ 

	^ self explicitRequirement
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> rawGroup: aGroup [

	self explicitRequirement
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> register: aCheckable [

	self group register: aCheckable
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> registerAll: aCollection [

	self group registerAll: aCollection
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> registeredCheckables [

	^ self group registeredCheckables
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> uncheckedList [

	^ self group uncheckedList
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> unregister: aCheckable [

	self group unregister: aCheckable
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> unregisterAll [

	self group unregisterAll
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> withStrictCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupStrictStrategy new
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> withWeakCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupWeakStrategy new
]

{ #category : #'t - checkable group owner' }
TToCheckableGroupOwner >> withoutCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupNoneStrategy new
]
