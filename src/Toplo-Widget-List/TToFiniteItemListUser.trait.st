Trait {
	#name : #TToFiniteItemListUser,
	#instVars : [
		'itemList'
	],
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> addAllItems: aCollection [

	self itemList addAllItems: aCollection
]

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> addItem: anItem [

	self itemList addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> addItem: anItem after: anotherItem [

	self itemList addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> addItem: anItem afterIndex: anInteger [

	self itemList addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> addItem: anItem before: anotherItem [

	self itemList addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> addItem: anItem beforeIndex: anInteger [

	self itemList addItem: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - configuration' }
TToFiniteItemListUser >> autoDistribute [

	^ self itemList innerConfiguration autoDistribute
]

{ #category : #'t - item list user - configuration' }
TToFiniteItemListUser >> autoDistribute: aBoolean [

	self itemList innerConfiguration autoDistribute: aBoolean
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> dataAccessor [

	^ self itemList dataAccessor
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> dataSource [

	^ self itemList dataSource
]

{ #category : #'t - item list user - hidden/visible' }
TToFiniteItemListUser >> deselectedAtPosition: anInteger [

	self itemList deselectedAtPosition: anInteger
]

{ #category : #'t - item list user - disable/ enable' }
TToFiniteItemListUser >> disabledAtPosition: anInteger [

	self itemList disabledAtPosition: anInteger
]

{ #category : #'t - item list user - disable/ enable' }
TToFiniteItemListUser >> disabledItem: anItem [

	self itemList disabledItem: anItem
]

{ #category : #'t - item list user - disable/ enable' }
TToFiniteItemListUser >> enabledAtPosition: anInteger [

	self itemList enabledAtPosition: anInteger
]

{ #category : #'t - item list user - disable/ enable' }
TToFiniteItemListUser >> enabledItem: anItem [

	self itemList enabledItem: anItem
]

{ #category : #'t - item list user - testing' }
TToFiniteItemListUser >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item list user - hidden/visible' }
TToFiniteItemListUser >> hiddenAtPosition: anInteger [

	self itemList hiddenAtPosition: anInteger
]

{ #category : #'t - item list user - hidden/visible' }
TToFiniteItemListUser >> hiddenItem: anItem [

	self itemList hiddenItem: anItem
]

{ #category : #'t - item list user - initializing' }
TToFiniteItemListUser >> initializeAsItemBarContainer [

	self setItemList: self newItemList
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> innerElement [

	^ self itemList innerElement
]

{ #category : #'t - item list user - configuration' }
TToFiniteItemListUser >> isFlowable [

	^ self itemList innerConfiguration isFlowable
]

{ #category : #'t - item list user - configuration' }
TToFiniteItemListUser >> isFlowable: aBoolean [

	self itemList innerConfiguration isFlowable: aBoolean
]

{ #category : #'t - item list user - testing' }
TToFiniteItemListUser >> isItemContainer [

	^ true
]

{ #category : #'t - item list user - configuration' }
TToFiniteItemListUser >> isScrollable [

	^ self itemList innerConfiguration isScrollable
]

{ #category : #'t - item list user - configuration' }
TToFiniteItemListUser >> isScrollable: aBoolean [

	self itemList innerConfiguration isScrollable: aBoolean
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> itemList [

	^ itemList
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> items [

	^ self itemList dataAccessor
]

{ #category : #'t - item list user - initializing' }
TToFiniteItemListUser >> newItemList [

	^ ToItemFiniteListElement new
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> nodeContainersDo: aValuable [

	self itemList nodeContainersDo: aValuable
]

{ #category : #'t - item list user - double dispatch' }
TToFiniteItemListUser >> onAddedAnyItemKind: anItem [


]

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> onAddedItem: anItem [

	self onAddedAnyItemKind: anItem.
	anItem onAddedInItemBarOwner: self.

]

{ #category : #'t - item list user - double dispatch' }
TToFiniteItemListUser >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item list user - double dispatch' }
TToFiniteItemListUser >> onRemovedAnyItemKind: anItem [


]

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemBarOwner: self
]

{ #category : #'t - item list user - double dispatch' }
TToFiniteItemListUser >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> primarySelectionMode [

	^ self itemList primarySelectionMode
]

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> removeAllItems [

	self itemList removeAllItems
]

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> removeAllItems: aCollection [

	self itemList removeAllItems: aCollection
]

{ #category : #'t - item list user - adding/removing' }
TToFiniteItemListUser >> removeItem: anItem [

	self onRemovedItem: anItem.
	self itemList removeItem: anItem
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> secondarySelecter [

	^ self itemList secondarySelecter
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> secondarySelectionMode [

	^ self itemList secondarySelectionMode
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> secondarySelectionOption [

	^ self itemList secondarySelectionOption
]

{ #category : #'t - item list user - unselectable/selectable' }
TToFiniteItemListUser >> selectableAtPosition: anInteger [

	self itemList selectableAtPosition: anInteger
]

{ #category : #'t - item list user - unselectable/selectable' }
TToFiniteItemListUser >> selectableItem: anItem [

	self itemList selectableItem: anItem
]

{ #category : #'t - item list user - hidden/visible' }
TToFiniteItemListUser >> selectedAtPosition: anInteger [

	self itemList selectedAtPosition: anInteger
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> selecter [

	^ self itemList selecter
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> selectionMode [

	^ self itemList selectionMode
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> selectionModel [

	^ self itemList selectionModel
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> selectionOption [

	^ self itemList selectionOption
]

{ #category : #'t - item list user - accessing' }
TToFiniteItemListUser >> setItemList: anItemList [

	itemList ifNotNil: [ BlImmutableObjectChangeError signal ].
	itemList := anItemList
]

{ #category : #'t - item list user - configuration' }
TToFiniteItemListUser >> uniformNodeHeight [

	^ self itemList innerConfiguration uniformNodeHeight
]

{ #category : #'t - item list user - configuration' }
TToFiniteItemListUser >> uniformNodeHeight: aBoolean [

	self itemList innerConfiguration uniformNodeHeight: aBoolean
]

{ #category : #'t - item list user - configuration' }
TToFiniteItemListUser >> uniformNodeWidth [

	^ self itemList innerConfiguration uniformNodeWidth
]

{ #category : #'t - item list user - configuration' }
TToFiniteItemListUser >> uniformNodeWidth: aBoolean [

	self itemList innerConfiguration uniformNodeWidth: aBoolean
]

{ #category : #'t - item list user - unselectable/selectable' }
TToFiniteItemListUser >> unselectableAtPosition: anInteger [

	self itemList unselectableAtPosition: anInteger
]

{ #category : #'t - item list user - unselectable/selectable' }
TToFiniteItemListUser >> unselectableItem: anItem [

	self itemList unselectableItem: anItem
]

{ #category : #'t - item list user - hidden/visible' }
TToFiniteItemListUser >> visibleAtPosition: anInteger [

	self itemList visibleAtPosition: anInteger
]

{ #category : #'t - item list user - hidden/visible' }
TToFiniteItemListUser >> visibleItem: anItem [

	self itemList visibleItem: anItem
]
