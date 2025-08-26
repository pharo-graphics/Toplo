Trait {
	#name : #TToItemList,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - item list - adding/removing' }
TToItemList >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - item list - adding/removing' }
TToItemList >> addItem: anItem [

	self items add: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list - adding/removing' }
TToItemList >> addItem: anItem after: anotherItem [

	self items add: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list - adding/removing' }
TToItemList >> addItem: anItem afterIndex: anInteger [

	self items add: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list - adding/removing' }
TToItemList >> addItem: anItem before: anotherItem [

	self items add: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list - adding/removing' }
TToItemList >> addItem: anItem beforeIndex: anInteger [

	self items add: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list - configuration' }
TToItemList >> applyItemListConfiguration [

	self nodesDo: [ :node | node applyConfiguration ]
]

{ #category : #'t - item list - hidden/visible' }
TToItemList >> deselectedItem: anItem [

	self deselectedAtPosition: anItem positionInBar
]

{ #category : #'t - item list - disabled/enabled' }
TToItemList >> disabledItem: anItem [

	self disabledAtPosition: anItem positionInList
]

{ #category : #'t - item list - disabled/enabled' }
TToItemList >> enabledItem: anItem [

	self enabledAtPosition: anItem positionInList
]

{ #category : #'t - item list - hidden/visible' }
TToItemList >> hiddenItem: anItem [

	self hiddenAtPosition: anItem positionInBar
]

{ #category : #'t - item list - accessing' }
TToItemList >> initializeAsItemListElement [ 

	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #'t - item list - hidden/visible' }
TToItemList >> isSelectedItem: anItem [

	^ self isSelectedAtPosition: anItem positionInList
]

{ #category : #'t - item list - accessing' }
TToItemList >> items [ 

	^ self dataAccessor
]

{ #category : #'t - item list - adding/removing' }
TToItemList >> notifyItemAdded: anItem [

]

{ #category : #'t - item list - adding/removing' }
TToItemList >> notifyItemRemoved: anItem wasSelected: aBoolean [

]

{ #category : #'t - item list - adding/removing' }
TToItemList >> onAddedItem: anItem [

	anItem listElement: self.
	self notifyItemAdded: anItem
]

{ #category : #'t - item list - adding/removing' }
TToItemList >> onRemovedItem: anItem wasSelected: aBoolean [

	self notifyItemRemoved: anItem wasSelected: aBoolean.
	anItem listElement: nil.

]

{ #category : #'t - item list - adding/removing' }
TToItemList >> removeAllItems [

	self removeAllItems: self items asArray
]

{ #category : #'t - item list - adding/removing' }
TToItemList >> removeAllItems: aCollection [

	aCollection do: [ :item | self removeItem: item ]
]

{ #category : #'t - item list - adding/removing' }
TToItemList >> removeItem: anItem [

	| wasSelected |
	wasSelected := self isSelectedAtPosition: anItem holder position.
	self items removeAt: anItem holder position.
	self onRemovedItem: anItem wasSelected: wasSelected.


]

{ #category : #'t - item list - unselectable/selectable' }
TToItemList >> selectableItem: anItem [

	self selectableAtPosition: anItem positionInBar
]

{ #category : #'t - item list - hidden/visible' }
TToItemList >> selectedItem: anItem [

	self selectedAtPosition: anItem positionInBar
]

{ #category : #'t - item list - unselectable/selectable' }
TToItemList >> unselectableItem: anItem [

	self unselectableAtPosition: anItem positionInList
]

{ #category : #'t - item list - hidden/visible' }
TToItemList >> visibleItem: anItem [

	self visibleAtPosition: anItem positionInBar
]
