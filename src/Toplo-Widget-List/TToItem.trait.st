Trait {
	#name : #TToItem,
	#instVars : [
		'presetData',
		'barParent',
		'nodeHolder',
		'bar'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item' }
TToItem >> bar: anItemBar [

	bar := anItemBar 
]

{ #category : #'t - item' }
TToItem >> barParent [

	^ barParent
]

{ #category : #'t - item' }
TToItem >> barParent: anItemContainer [

	barParent := anItemContainer
]

{ #category : #'t - item' }
TToItem >> barParentDo: aBlock [

	self barParent ifNil: [ ^ self ].
	aBlock value: self barParent
]

{ #category : #'t - item' }
TToItem >> disabled: aBoolean [

	self barParent
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

	self barParent
		ifNil: [ self presetHiddenWith: aBoolean ]
		ifNotNil: [ :l |
			aBoolean
				ifTrue: [ l hiddenItem: self ]
				ifFalse: [ l visibleItem: self ] ]
]

{ #category : #'t - item' }
TToItem >> nodeHolder [

	^ nodeHolder
]

{ #category : #'t - item' }
TToItem >> nodeHolder: aNodeHolder [

	nodeHolder := aNodeHolder
]

{ #category : #'t - item' }
TToItem >> positionInBar [

	nodeHolder ifNotNil: [ ^ nodeHolder position ].
	^ 0
]

{ #category : #'t - item' }
TToItem >> positionInParentBar [

	nodeHolder ifNotNil: [ ^ nodeHolder position ].
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

	self barParent
		ifNil: [ self presetUnselectableWith: aBoolean ]
		ifNotNil: [ :l |
			aBoolean
				ifTrue: [ l unselectableItem: self ]
				ifFalse: [ l selectableItem: self ] ]
]
