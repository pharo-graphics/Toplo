Trait {
	#name : #TToItemListOwner,
	#instVars : [
		'itemList'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item list owner - initializing' }
TToItemListOwner >> initializeAsItemListOwner [

	self setItemList: self newItemList
]

{ #category : #'t - item list owner - initializing' }
TToItemListOwner >> newItemList [

	^ self shouldBeImplemented 
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> setItemList: anItemList [

	itemList ifNotNil: [ BlImmutableObjectChangeError signal ].
	itemList := anItemList
]
