Trait {
	#name : #TToItemListOwner,
	#instVars : [
		'itemList'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item list owner - initializing' }
TToItemListOwner >> initializeAsItemListOwner [

	self itemList: self newItemList
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> itemList: anItemList [

	itemList ifNotNil: [ itemList removeFromParent ].
	itemList := anItemList
]

{ #category : #'t - item list owner - initializing' }
TToItemListOwner >> newItemList [

	^ self shouldBeImplemented 
]
