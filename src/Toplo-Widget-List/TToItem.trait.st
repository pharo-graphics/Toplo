Trait {
	#name : #TToItem,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item' }
TToItem >> barElement [ 

	^ self userData at: #barElement ifAbsent: [  ]
]

{ #category : #'t - item' }
TToItem >> barElement: anItemBarElement [ 

	self userData at: #barElement put: anItemBarElement
]

{ #category : #'t - item' }
TToItem >> barElementDo: aBlock [

	self barElement ifNotNil: [ :be | aBlock value: be ]
]

{ #category : #'t - item' }
TToItem >> barOwner [

	^ self barElement ifNotNil: [ :be | be barOwner ] 
]

{ #category : #'t - item' }
TToItem >> barOwnerDo: aValuable [

	self barOwner ifNotNil: [ :bo | aValuable value: bo ]
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
	self barElementDo: [ :be |
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
TToItem >> newItemConstraints [

	^ self itemConstraintsClass new
]

{ #category : #'t - item' }
TToItem >> positionInBar [

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
	self barElementDo: [ :l |
			aBoolean
				ifTrue: [ l unselectableItem: self ]
				ifFalse: [ l selectableItem: self ] ]
]
