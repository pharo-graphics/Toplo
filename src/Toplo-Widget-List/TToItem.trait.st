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

	^ self userData at: #barOwner ifAbsent: [  ]
]

{ #category : #'t - item' }
TToItem >> barOwner: anItemContainer [

	self userData at: #barOwner put: anItemContainer
]

{ #category : #'t - item' }
TToItem >> barOwnerDo: aBlock [

	self barOwner ifNotNil: [ :bo | aBlock value: bo ]
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
	self barOwnerDo: [ :l |
		aBoolean
			ifTrue: [ l hiddenItem: self ]
			ifFalse: [ l visibleItem: self ] ]
]

{ #category : #'t - item' }
TToItem >> itemConstraints [

	^ self userData at: #itemConstraints ifAbsent: [  ]
]

{ #category : #'t - item' }
TToItem >> itemConstraintsDo: aValuable [

	self itemConstraints ifNil: [ ^ self ].
	aValuable value: self itemConstraints
]

{ #category : #'t - item' }
TToItem >> newItemConstraints [

	^ ToItemConstraints new
]

{ #category : #'t - item' }
TToItem >> positionInBar [

	^ self holder position
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
TToItem >> storeUnselectable: aBoolean [

	self ensuredItemConstraints unselectable: aBoolean
]

{ #category : #'t - item' }
TToItem >> unselectable: aBoolean [

	self storeUnselectable: aBoolean.
	self barOwnerDo: [ :l |
			aBoolean
				ifTrue: [ l unselectableItem: self ]
				ifFalse: [ l selectableItem: self ] ]
]
