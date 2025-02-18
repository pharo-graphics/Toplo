Trait {
	#name : #TToItem,
	#category : #'Toplo-Core'
}

{ #category : #'t - item' }
TToItem >> barElement [ 

	self
		deprecated: 'Use #listElement instead'
		transformWith:
		'`@rcvr barElement' -> '`@rcvr listElement'.
	^ self listElement
]

{ #category : #'t - item' }
TToItem >> barElement: anItemBarElement [

	self
		deprecated: 'Use #listElement: instead'
		transformWith:
		'`@rcvr barElement: `@arg1' -> '`@rcvr listElement: `@arg1'.
		
	self listElement: anItemBarElement
]

{ #category : #'t - item' }
TToItem >> barElementDo: aBlock [
	self
		deprecated: 'Use #listElementDo: instead'
		transformWith:
		'`@rcvr barElementDo: `@arg1' -> '`@rcvr listElementDo: `@arg1'.
	self listElementDo: aBlock
]

{ #category : #'t - item' }
TToItem >> ensuredItemConstraints [

	^ self userData
		at: #itemConstraints
		ifAbsentPut: [self newItemConstraints ]
]

{ #category : #'t - item' }
TToItem >> flagAsDisabled: aBoolean [

	self storeDisabled: aBoolean.
	self listElementDo: [ :be |
		aBoolean
			ifTrue: [ be disabledItem: self ]
			ifFalse: [ be enabledItem: self ] ].
	super flagAsDisabled: aBoolean
]

{ #category : #'t - item' }
TToItem >> hidden: aBoolean [

	self storeHidden: aBoolean.
	self barElementDo: [ :l |
		aBoolean
			ifTrue: [ l hiddenItem: self ]
			ifFalse: [ l visibleItem: self ] ]
]

{ #category : #'t - item' }
TToItem >> isSelected [

	self barElementDo: [ :l | ^ l isSelectedItem: self ].
	self itemConstraintsDo: [ :c | ^ c selected ].
	^ false
]

{ #category : #'t - item' }
TToItem >> itemConstraints [

	^ self userData at: #itemConstraints ifAbsent: [  ]
]

{ #category : #'t - item' }
TToItem >> itemConstraintsClass [

	^ ToItemConstraints 
]

{ #category : #'t - item' }
TToItem >> itemConstraintsDo: aValuable [

	self itemConstraints ifNil: [ ^ self ].
	aValuable value: self itemConstraints
]

{ #category : #'t - item' }
TToItem >> listElement [ 

	^ self userData at: #listElement ifAbsent: [  ]
]

{ #category : #'t - item' }
TToItem >> listElement: anItemListElement [ 

	self userData at: #listElement put: anItemListElement
]

{ #category : #'t - item' }
TToItem >> listElementDo: aBlock [

	self listElement ifNotNil: [ :be | aBlock value: be ]
]

{ #category : #'t - item' }
TToItem >> newItemConstraints [

	^ self itemConstraintsClass new
]

{ #category : #'t - item' }
TToItem >> positionInBar [
	self
		deprecated: 'Use #positionInList instead'
		transformWith:
		'`@rcvr positionInBar' -> '`@rcvr positionInList'.

	^ self positionInList
]

{ #category : #'t - item' }
TToItem >> positionInList [

	^ self holder position
]

{ #category : #'t - item' }
TToItem >> selected: aBoolean [

	self storeSelected: aBoolean.
	self barElementDo: [ :l |
		aBoolean
			ifTrue: [ l selectedItem: self ]
			ifFalse: [ l deselectedItem: self ] ]
]

{ #category : #'t - item' }
TToItem >> storeDisabled: aBoolean [

	self ensuredItemConstraints disabled: aBoolean
]

{ #category : #'t - item' }
TToItem >> storeHidden: aBoolean [

	self ensuredItemConstraints hidden: aBoolean
]

{ #category : #'t - item' }
TToItem >> storeSelected: aBoolean [

	self ensuredItemConstraints selected: aBoolean
]

{ #category : #'t - item' }
TToItem >> storeUnselectable: aBoolean [

	self ensuredItemConstraints unselectable: aBoolean
]

{ #category : #'t - item' }
TToItem >> unselectable: aBoolean [

	self storeUnselectable: aBoolean.
	self listElementDo: [ :l |
		aBoolean
			ifTrue: [ l unselectableItem: self ]
			ifFalse: [ l selectableItem: self ] ]
]
