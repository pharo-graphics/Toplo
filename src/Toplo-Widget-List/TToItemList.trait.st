Trait {
	#name : #TToItemList,
	#instVars : [
		'exactItemWidth',
		'exactItemHeight'
	],
	#category : #'Toplo-Widget-List-ItemList'
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

{ #category : #'t - item list - accessing' }
TToItemList >> defaultNodeManagerClass [

	^ ToItemBarNodeManager
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

{ #category : #'t - item list - accessing' }
TToItemList >> exactItemHeight [

	^ exactItemHeight
]

{ #category : #'t - item list - accessing' }
TToItemList >> exactItemHeight: aNumberOrNil [

	exactItemHeight = aNumberOrNil ifTrue:[ ^ self ].
	exactItemHeight := aNumberOrNil.
	self requestNewConfiguration.
	self notifyDataSourceChanged.
	self requestLayout
]

{ #category : #'t - item list - accessing' }
TToItemList >> exactItemWidth [

	^ exactItemWidth
]

{ #category : #'t - item list - accessing' }
TToItemList >> exactItemWidth: aNumberOrNil [

	exactItemWidth = aNumberOrNil ifTrue:[ ^ self ].
	exactItemWidth := aNumberOrNil.
	self requestNewConfiguration.
	self notifyDataSourceChanged.
	self requestLayout
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
TToItemList >> onAddedItem: anItem [

	anItem listElement: self
]

{ #category : #'t - item list - adding/removing' }
TToItemList >> onRemovedItem: anItem [

	anItem listElement: nil
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

	self items remove: anItem.
	self onRemovedItem: anItem
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
