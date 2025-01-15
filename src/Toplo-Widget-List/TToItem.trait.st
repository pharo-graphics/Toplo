Trait {
	#name : #TToItem,
	#instVars : [
		'barOwner',
		'barElement'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item' }
TToItem >> barElement [ 

	^ self holder listElement
]

{ #category : #'t - item' }
TToItem >> barElement: anItemBarElement [ 

	"barElement := anItemBarElement"
]

{ #category : #'t - item' }
TToItem >> barElementDo: aBlock [

	barElement ifNil: [ ^ self ].
	aBlock value: barElement
]

{ #category : #'t - item' }
TToItem >> barOwner [

	^ barOwner
]

{ #category : #'t - item' }
TToItem >> barOwner: anItemContainer [

	barOwner := anItemContainer
]

{ #category : #'t - item' }
TToItem >> barOwnerDo: aBlock [

	barOwner ifNil: [ ^ self ].
	aBlock value: barOwner
]

{ #category : #'t - item' }
TToItem >> disabled: aBoolean [

	self storeDisabled: aBoolean.
	barElement ifNotNil: [ :l |
		aBoolean
			ifTrue: [ l disabledItem: self ]
			ifFalse: [ l enabledItem: self ] ].
	super disabled: aBoolean
]

{ #category : #'t - item' }
TToItem >> ensuredItemConstraints [

	^ self userData
		at: #itemConstraints
		ifAbsentPut: [self newItemConstraints ]
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

	self barElementDo: [ :pm | ^ pm items indexOf: self ].
	^ 0
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
