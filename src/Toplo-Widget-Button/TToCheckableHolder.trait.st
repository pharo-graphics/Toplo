Trait {
	#name : #TToCheckableHolder,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable holder' }
TToCheckableHolder >> allowUnchecking [

	^ self group allowUnchecking
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> checkedList [

	^ self group checkedList
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> checkingStrategy: aCheckingStrategy [

	self group checkingStrategy: aCheckingStrategy
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> group [

	^ self rawGroup
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> group: aGroup [

	self rawGroup: aGroup
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> hasNoneStrategy [

	^ self group hasNoneStrategy
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> rawGroup [ 

	^ self explicitRequirement
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> rawGroup: aGroup [

	self explicitRequirement
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> register: aCheckable [

	self group register: aCheckable
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> registerAll: aCollection [

	self group registerAll: aCollection
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> registeredCheckables [

	^ self group registeredCheckables
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> uncheckedList [

	^ self group uncheckedList
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> unregister: aCheckable [

	self group unregister: aCheckable
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> unregisterAll [

	self group unregisterAll
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> withStrictCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupStrictStrategy new
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> withWeakCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupWeakStrategy new
]

{ #category : #'t - checkable holder' }
TToCheckableHolder >> withoutCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupNoneStrategy new
]
