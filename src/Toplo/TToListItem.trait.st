Trait {
	#name : #TToListItem,
	#category : #'Toplo-Core'
}

{ #category : #'t - list item' }
TToListItem >> applyConfigurationAsListItem [

	self isHExact ifTrue: [ ^ self ].
	self listHolderDo: [ :h |
			h listElement isHorizontal
				ifTrue: [ self hFitContent ]
				ifFalse: [ self hMatchParent ] ]
]

{ #category : #'t - list item' }
TToListItem >> ensuredItemConstraints [

	^ self ensuredToploExtension ensuredItemConstraints
]

{ #category : #'t - list item' }
TToListItem >> flagAsDisabled: aBoolean [

	self storeDisabled: aBoolean.
	self listElementDo: [ :be |
		aBoolean
			ifTrue: [ be disabledItem: self ]
			ifFalse: [ be enabledItem: self ] ].
	super flagAsDisabled: aBoolean
]

{ #category : #'t - list item' }
TToListItem >> hidden: aBoolean [

	self storeHidden: aBoolean.
	self listElementDo: [ :l |
		aBoolean
			ifTrue: [ l hiddenItem: self ]
			ifFalse: [ l visibleItem: self ] ]
]

{ #category : #'t - list item' }
TToListItem >> isSegmentedItem [

	^ self
		  withAllParentsDetect: [ :p | p isKindOf: ToSegmentedListElement ]
		  ifFound: [ :p | true ]
		  ifNone: [ false ]
]

{ #category : #'t - list item' }
TToListItem >> isSelected [

	self listElementDo: [ :l | ^ l isSelectedItem: self ].
	^ super isSelected
]

{ #category : #'t - list item' }
TToListItem >> itemConstraints [

	^ self toploExtensionDo: [ :te | te itemConstraints ]
]

{ #category : #'t - list item' }
TToListItem >> itemConstraintsDo: aValuable [

	^ self toploExtensionDo: [ :te | te itemConstraintsDo: aValuable ]
]

{ #category : #'t - list item' }
TToListItem >> listElement [ 

	^ self listHolderDo: [ :h | h listElement ] 
]

{ #category : #'t - list item' }
TToListItem >> listElementDo: aBlock [

	^ self listElement ifNotNil: [ :be | aBlock value: be ]
]

{ #category : #'t - list item' }
TToListItem >> positionInBar [
	self
		deprecated: 'Use #positionInList instead'
		transformWith:
		'`@rcvr positionInBar' -> '`@rcvr positionInList'.

	^ self positionInList
]

{ #category : #'t - list item' }
TToListItem >> positionInList [

	^ self holder position
]

{ #category : #'t - list item' }
TToListItem >> selected: aBoolean [

	self storeSelected: aBoolean.
	self listElementDo: [ :l |
		aBoolean
			ifTrue: [ l selectedItem: self ]
			ifFalse: [ l deselectedItem: self ] ]
]

{ #category : #'t - list item' }
TToListItem >> storeDisabled: aBoolean [

	self ensuredItemConstraints disabled: aBoolean
]

{ #category : #'t - list item' }
TToListItem >> storeHidden: aBoolean [

	self ensuredItemConstraints hidden: aBoolean
]

{ #category : #'t - list item' }
TToListItem >> storeSelected: aBoolean [

	self ensuredItemConstraints selected: aBoolean
]

{ #category : #'t - list item' }
TToListItem >> storeUnselectable: aBoolean [

	self ensuredItemConstraints unselectable: aBoolean
]

{ #category : #'t - list item' }
TToListItem >> unselectable: aBoolean [

	self storeUnselectable: aBoolean.
	self listElementDo: [ :l |
		aBoolean
			ifTrue: [ l unselectableItem: self ]
			ifFalse: [ l selectableItem: self ] ]
]
