Trait {
	#name : #TToItem,
	#instVars : [
		'parentItemListHolder'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

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
