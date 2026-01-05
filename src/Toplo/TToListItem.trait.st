Trait {
	#name : #TToListItem,
	#instVars : [
		'listItemConstraints'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - item' }
TToListItem >> ensuredItemConstraints [

	^ listItemConstraints ifNil: [
		  listItemConstraints := self newItemConstraints ]
]

{ #category : #'t - item' }
TToListItem >> flagAsDisabled: aBoolean [

	self storeDisabled: aBoolean.
	self listElementDo: [ :be |
		aBoolean
			ifTrue: [ be disabledItem: self ]
			ifFalse: [ be enabledItem: self ] ].
	super flagAsDisabled: aBoolean
]

{ #category : #'t - item' }
TToListItem >> hidden: aBoolean [

	self storeHidden: aBoolean.
	self barElementDo: [ :l |
		aBoolean
			ifTrue: [ l hiddenItem: self ]
			ifFalse: [ l visibleItem: self ] ]
]

{ #category : #'t - item' }
TToListItem >> isSelected [

	self listElementDo: [ :l | ^ l isSelectedItem: self ].
	^ super isSelected
]

{ #category : #'t - item' }
TToListItem >> itemConstraints [

	^ listItemConstraints 
]

{ #category : #'t - item' }
TToListItem >> itemConstraintsClass [

	^ ToItemConstraints 
]

{ #category : #'t - item' }
TToListItem >> itemConstraintsDo: aValuable [

	self itemConstraints ifNil: [ ^ self ].
	aValuable value: self itemConstraints
]

{ #category : #'t - item' }
TToListItem >> listElement [ 

	^ self listHolderDo: [ :h | h listElement ] 
]

{ #category : #'t - item' }
TToListItem >> listElementDo: aBlock [

	^ self listElement ifNotNil: [ :be | aBlock value: be ]
]

{ #category : #'t - item' }
TToListItem >> newItemConstraints [

	^ self itemConstraintsClass new
]

{ #category : #'t - item' }
TToListItem >> positionInBar [
	self
		deprecated: 'Use #positionInList instead'
		transformWith:
		'`@rcvr positionInBar' -> '`@rcvr positionInList'.

	^ self positionInList
]

{ #category : #'t - item' }
TToListItem >> positionInList [

	^ self holder position
]

{ #category : #'t - item' }
TToListItem >> selected: aBoolean [

	self storeSelected: aBoolean.
	self listElementDo: [ :l |
		aBoolean
			ifTrue: [ l selectedItem: self ]
			ifFalse: [ l deselectedItem: self ] ]
]

{ #category : #'t - item' }
TToListItem >> storeDisabled: aBoolean [

	self ensuredItemConstraints disabled: aBoolean
]

{ #category : #'t - item' }
TToListItem >> storeHidden: aBoolean [

	self ensuredItemConstraints hidden: aBoolean
]

{ #category : #'t - item' }
TToListItem >> storeSelected: aBoolean [

	self ensuredItemConstraints selected: aBoolean
]

{ #category : #'t - item' }
TToListItem >> storeUnselectable: aBoolean [

	self ensuredItemConstraints unselectable: aBoolean
]

{ #category : #'t - item' }
TToListItem >> unselectable: aBoolean [

	self storeUnselectable: aBoolean.
	self listElementDo: [ :l |
		aBoolean
			ifTrue: [ l unselectableItem: self ]
			ifFalse: [ l selectableItem: self ] ]
]
