Trait {
	#name : #TToCheckableGroupHolder,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> allowUnchecking [

	^ self group allowUnchecking
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> checkedList [

	^ self group checkedList
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> checkingStrategy: aCheckingStrategy [

	self group checkingStrategy: aCheckingStrategy
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> group [

	^ self rawGroup
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> group: aGroup [

	self rawGroup: aGroup
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> hasNoneStrategy [

	^ self group hasNoneStrategy
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> rawGroup [ 

	^ self explicitRequirement
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> rawGroup: aGroup [

	self explicitRequirement
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> register: aCheckable [

	self group register: aCheckable
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> registerAll: aCollection [

	self group registerAll: aCollection
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> registeredCheckables [

	^ self group registeredCheckables
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> uncheckedList [

	^ self group uncheckedList
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> unregister: aCheckable [

	self group unregister: aCheckable
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> unregisterAll [

	self group unregisterAll
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> withStrictCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupStrictStrategy new
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> withUncheckingStrategy [

	self  checkingStrategy: ToCheckableGroupWithUncheckStrategy new
]

{ #category : #'t - checkable group holder' }
TToCheckableGroupHolder >> withoutCheckingStrategy [

	self  checkingStrategy: ToCheckableGroupNoneStrategy new
]
