Trait {
	#name : #TToItemListElement,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> addItem: anItem [

	self items add: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> addItem: anItem after: anotherItem [

	self items add: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> addItem: anItem afterIndex: anInteger [

	self items add: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> addItem: anItem before: anotherItem [

	self items add: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> addItem: anItem beforeIndex: anInteger [

	self items add: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list - configuration' }
TToItemListElement >> applyItemListConfiguration [

	self nodeContainersDo: [ :container | container applyConfiguration ]
]

{ #category : #'t - item list - hidden/visible' }
TToItemListElement >> deselectedItem: anItem [

	self deselectedAtPosition: anItem positionInBar
]

{ #category : #'t - item list - disabled/enabled' }
TToItemListElement >> disabledItem: anItem [

	self disabledAtPosition: anItem positionInList
]

{ #category : #'t - item list - disabled/enabled' }
TToItemListElement >> enabledItem: anItem [

	self enabledAtPosition: anItem positionInList
]

{ #category : #'t - item list - hidden/visible' }
TToItemListElement >> hiddenItem: anItem [

	self hiddenAtPosition: anItem positionInBar
]

{ #category : #'t - item list - accessing' }
TToItemListElement >> initializeAsItemListElement [ 

	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #'t - item list - hidden/visible' }
TToItemListElement >> isSelectedItem: anItem [

	^ self isSelectedAtPosition: anItem positionInList
]

{ #category : #'t - item list - accessing' }
TToItemListElement >> items [ 

	^ self dataAccessor
]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> notifyItemAdded: anItem [

]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> notifyItemRemoved: anItem wasSelected: aBoolean [

	self dispatchEvent: (ToItemRemovedFromFiniteListEvent new
			 item: anItem;
			 wasSelected: aBoolean;
			 yourself)

]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> onAddedItem: anItem [

	anItem listElement: self.
	self notifyItemAdded: anItem
]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> onRemovedItem: anItem wasSelected: aBoolean [

	self notifyItemRemoved: anItem wasSelected: aBoolean.
	anItem listElement: nil.

]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> removeAllItems [

	self removeAllItems: self items asArray
]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> removeAllItems: aCollection [

	aCollection reverseDo: [ :item | self removeItem: item ]
]

{ #category : #'t - item list - adding/removing' }
TToItemListElement >> removeItem: anItem [

	| wasSelected |
	wasSelected := self isSelectedAtPosition: anItem holder position.
	self items removeAt: anItem holder position.
	self onRemovedItem: anItem wasSelected: wasSelected.


]

{ #category : #'t - item list - unselectable/selectable' }
TToItemListElement >> selectableItem: anItem [

	self selectableAtPosition: anItem positionInBar
]

{ #category : #'t - item list - hidden/visible' }
TToItemListElement >> selectedItem: anItem [

	self selectedAtPosition: anItem positionInBar
]

{ #category : #'t - item list - unselectable/selectable' }
TToItemListElement >> unselectableItem: anItem [

	self unselectableAtPosition: anItem positionInList
]

{ #category : #'t - item list - hidden/visible' }
TToItemListElement >> visibleItem: anItem [

	self visibleAtPosition: anItem positionInBar
]
