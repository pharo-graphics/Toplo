Trait {
	#name : #TToCheckableGroupUser,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> checkedList [

	^ self group checkedList
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> checkingStrategy: aCheckingStrategy [

	self group checkingStrategy: aCheckingStrategy
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> group [

	^ self userData at: #group ifAbsentPut: [ ToCheckableGroup new ]
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> hasNoneStrategy [

	^ self group hasNoneStrategy
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> register: aCheckable [

	self group register: aCheckable
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> registerAll: aCollection [

	self group registerAll: aCollection
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> registeredCheckables [

	^ self group registeredCheckables
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> uncheckedList [

	^ self group uncheckedList
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> unregister: aCheckable [

	self group unregister: aCheckable
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> unregisterAll [

	self group unregisterAll
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> withNoneCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupNoneStrategy new
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> withStrictCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupStrictStrategy new
]

{ #category : #'t - checkable group user' }
TToCheckableGroupUser >> withWeakCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupWeakStrategy new
]
