Trait {
	#name : #TToCheckableGroupHolder,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> checkedList [

	^ self group checkedList
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> checkingStrategy: aCheckingStrategy [

	self group checkingStrategy: aCheckingStrategy
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> group [

	^ self rawGroup
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> group: aGroup [

	self rawGroup: aGroup
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> hasNoneStrategy [

	^ self group hasNoneStrategy
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> rawGroup [ 

	^ self explicitRequirement
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> rawGroup: aGroup [

	self explicitRequirement
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> register: aCheckable [

	self group register: aCheckable
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> registerAll: aCollection [

	self group registerAll: aCollection
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> registeredCheckables [

	^ self group registeredCheckables
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> uncheckedList [

	^ self group uncheckedList
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> unregister: aCheckable [

	self group unregister: aCheckable
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> unregisterAll [

	self group unregisterAll
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> withStrictCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupStrictStrategy new
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> withWeakCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupWeakStrategy new
]

{ #category : #'t - checkable holder' }
TToCheckableGroupHolder >> withoutCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupNoneStrategy new
]
