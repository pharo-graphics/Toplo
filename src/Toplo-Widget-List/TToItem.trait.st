Trait {
	#name : #TToItem,
	#instVars : [
		'parentItemListHolder',
		'presetData'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item' }
TToItem >> ensurePresetData [

	presetData := ToItemPresetData new
]

{ #category : #'t - item' }
TToItem >> parentItemListHolder [

	^ parentItemListHolder
]

{ #category : #'t - item' }
TToItem >> parentItemListHolder: anItemContainer [

	parentItemListHolder := anItemContainer
]

{ #category : #'t - item' }
TToItem >> parentItemListHolderDo: aBlock [

	parentItemListHolder ifNil: [ ^ self ].
	aBlock value: parentItemListHolder
]

{ #category : #'t - item' }
TToItem >> positionInItemList [

	self parentItemListHolderDo: [ :pm | ^ pm items indexOf: self ].
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
