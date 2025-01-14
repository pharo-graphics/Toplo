Trait {
	#name : #TToItem,
	#instVars : [
		'barOwner',
		'barElement',
		'itemConstraints'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item' }
TToItem >> barElement [ 

	^ barElement
]

{ #category : #'t - item' }
TToItem >> barElement: anItemBarElement [ 

	barElement := anItemBarElement
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
TToItem >> ensureConstraintsStorage [

	itemConstraints := ToItemConstraints new
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
TToItem >> positionInBar [

	self barElementDo: [ :pm | ^ pm items indexOf: self ].
	^ 0
]

{ #category : #'t - item' }
TToItem >> storeDisabled: aBoolean [

	self ensureConstraintsStorage.
	itemConstraints disabled: aBoolean
]

{ #category : #'t - item' }
TToItem >> storeHidden: aBoolean [

	self ensureConstraintsStorage.
	itemConstraints hidden: aBoolean
]

{ #category : #'t - item' }
TToItem >> storeUnselectable: aBoolean [

	self ensureConstraintsStorage.
	itemConstraints unselectable: aBoolean
]

{ #category : #'t - item' }
TToItem >> storedConstraintsDo: aValuable [

	itemConstraints ifNil: [ ^ self ].
	aValuable value: itemConstraints
]

{ #category : #'t - item' }
TToItem >> unselectable: aBoolean [

	self storeUnselectable: aBoolean.
	self barOwnerDo: [ :l |
			aBoolean
				ifTrue: [ l unselectableItem: self ]
				ifFalse: [ l selectableItem: self ] ]
]
