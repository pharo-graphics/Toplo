Trait {
	#name : #TToItem,
	#instVars : [
		'presetData',
		'barOwner'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

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

	self barOwner
		ifNil: [ self presetDisabledWith: aBoolean ]
		ifNotNil: [ :l |
			aBoolean
				ifTrue: [ l disabledItem: self ]
				ifFalse: [ l enabledItem: self ] ].
	super disabled: aBoolean
]

{ #category : #'t - item' }
TToItem >> ensurePresetData [

	presetData := ToItemPresetData new
]

{ #category : #'t - item' }
TToItem >> hidden: aBoolean [

	self barOwner
		ifNil: [ self presetHiddenWith: aBoolean ]
		ifNotNil: [ :l |
			aBoolean
				ifTrue: [ l hiddenItem: self ]
				ifFalse: [ l visibleItem: self ] ]
]

{ #category : #'t - item' }
TToItem >> positionInBar [

	self barOwnerDo: [ :pm | ^ pm items indexOf: self ].
	^ 0
]

{ #category : #'t - item' }
TToItem >> presetDataDo: aValuable [

	presetData ifNil: [ ^ self ].
	aValuable value: presetData.
	presetData := nil
]

{ #category : #'t - item' }
TToItem >> presetDisabledWith: aBoolean [

	self ensurePresetData.
	presetData disabled: aBoolean
]

{ #category : #'t - item' }
TToItem >> presetHiddenWith: aBoolean [

	self ensurePresetData.
	presetData hidden: aBoolean
]

{ #category : #'t - item' }
TToItem >> presetUnselectableWith: aBoolean [

	self ensurePresetData.
	presetData unselectable: aBoolean
]

{ #category : #'t - item' }
TToItem >> unselectable: aBoolean [

	self barOwner
		ifNil: [ self presetUnselectableWith: aBoolean ]
		ifNotNil: [ :l |
			aBoolean
				ifTrue: [ l unselectableItem: self ]
				ifFalse: [ l selectableItem: self ] ]
]
