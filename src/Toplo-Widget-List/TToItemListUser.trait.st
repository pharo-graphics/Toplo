Trait {
	#name : #TToItemListUser,
	#instVars : [
		'itemList'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addAllItems: aCollection [

	self itemList addAllItems: aCollection
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addItem: anItem [

	self itemList addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addItem: anItem after: anotherItem [

	self itemList addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addItem: anItem afterIndex: anInteger [

	self itemList addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addItem: anItem before: anotherItem [

	self itemList addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addItem: anItem beforeIndex: anInteger [

	self itemList addItem: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> autoDistribute [

	^ self itemList toConfiguration autoDistribute
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> autoDistribute: aBoolean [

	self itemList toConfiguration autoDistribute: aBoolean
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> dataAccessor [

	^ self itemList dataAccessor
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> dataSource [

	^ self itemList dataSource
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> deselectedAtPosition: anInteger [

	self itemList deselectedAtPosition: anInteger
]

{ #category : #'t - item list user - disable/ enable' }
TToItemListUser >> disabledAtPosition: anInteger [

	self itemList disabledAtPosition: anInteger
]

{ #category : #'t - item list user - disable/ enable' }
TToItemListUser >> disabledItem: anItem [

	self itemList disabledItem: anItem
]

{ #category : #'t - item list user - disable/ enable' }
TToItemListUser >> enabledAtPosition: anInteger [

	self itemList enabledAtPosition: anInteger
]

{ #category : #'t - item list user - disable/ enable' }
TToItemListUser >> enabledItem: anItem [

	self itemList enabledItem: anItem
]

{ #category : #'t - item list user - testing' }
TToItemListUser >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> hiddenAtPosition: anInteger [

	self itemList hiddenAtPosition: anInteger
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> hiddenItem: anItem [

	self itemList hiddenItem: anItem
]

{ #category : #'t - item list user - initializing' }
TToItemListUser >> initializeAsItemBarContainer [

	self setItemList: self newItemList
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> innerElement [

	^ self itemList innerElement
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> isFlowable [

	^ self itemList toConfiguration isFlowable
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> isFlowable: aBoolean [

	self itemList toConfiguration isFlowable: aBoolean
]

{ #category : #'t - item list user - testing' }
TToItemListUser >> isItemContainer [

	^ true
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> isScrollable [

	^ self itemList toConfiguration isScrollable
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> isScrollable: aBoolean [

	self itemList toConfiguration isScrollable: aBoolean
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> itemList [

	^ itemList
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> items [

	^ self itemList dataAccessor
]

{ #category : #'t - item list user - initializing' }
TToItemListUser >> newItemList [

	^ ToItemListElement finite
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> nodeContainersDo: aValuable [

	self itemList nodeContainersDo: aValuable
]

{ #category : #'t - item list user - double dispatch' }
TToItemListUser >> onAddedAnyItemKind: anItem [


]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> onAddedItem: anItem [

	self onAddedAnyItemKind: anItem.
	anItem onAddedInItemBarOwner: self.

]

{ #category : #'t - item list user - double dispatch' }
TToItemListUser >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item list user - double dispatch' }
TToItemListUser >> onRemovedAnyItemKind: anItem [


]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemBarOwner: self
]

{ #category : #'t - item list user - double dispatch' }
TToItemListUser >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> primarySelectionMode [

	^ self itemList primarySelectionMode
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> removeAllItems [

	self itemList removeAllItems
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> removeAllItems: aCollection [

	self itemList removeAllItems: aCollection
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> removeItem: anItem [

	self onRemovedItem: anItem.
	self itemList removeItem: anItem
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> secondarySelecter [

	^ self itemList secondarySelecter
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> secondarySelectionMode [

	^ self itemList secondarySelectionMode
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> secondarySelectionOption [

	^ self itemList secondarySelectionOption
]

{ #category : #'t - item list user - unselectable/selectable' }
TToItemListUser >> selectableAtPosition: anInteger [

	self itemList selectableAtPosition: anInteger
]

{ #category : #'t - item list user - unselectable/selectable' }
TToItemListUser >> selectableItem: anItem [

	self itemList selectableItem: anItem
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> selectedAtPosition: anInteger [

	self itemList selectedAtPosition: anInteger
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> selecter [

	^ self itemList selecter
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> selectionMode [

	^ self itemList selectionMode
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> selectionModel [

	^ self itemList selectionModel
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> selectionOption [

	^ self itemList selectionOption
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> setItemList: anItemList [

	itemList ifNotNil: [ BlImmutableObjectChangeError signal ].
	itemList := anItemList
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> uniformNodeHeight [

	^ self itemList toConfiguration uniformNodeHeight
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> uniformNodeHeight: aBoolean [

	self itemList toConfiguration uniformNodeHeight: aBoolean
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> uniformNodeWidth [

	^ self itemList toConfiguration uniformNodeWidth
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> uniformNodeWidth: aBoolean [

	self itemList toConfiguration uniformNodeWidth: aBoolean
]

{ #category : #'t - item list user - unselectable/selectable' }
TToItemListUser >> unselectableAtPosition: anInteger [

	self itemList unselectableAtPosition: anInteger
]

{ #category : #'t - item list user - unselectable/selectable' }
TToItemListUser >> unselectableItem: anItem [

	self itemList unselectableItem: anItem
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> visibleAtPosition: anInteger [

	self itemList visibleAtPosition: anInteger
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> visibleItem: anItem [

	self itemList visibleItem: anItem
]
