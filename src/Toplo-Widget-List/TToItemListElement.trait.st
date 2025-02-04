Trait {
	#name : #TToItemListElement,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> addItem: anItem [

	self items add: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> addItem: anItem after: anotherItem [

	self items add: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> addItem: anItem afterIndex: anInteger [

	self items add: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> addItem: anItem before: anotherItem [

	self items add: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> addItem: anItem beforeIndex: anInteger [

	self items add: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar element - accessing' }
TToItemListElement >> barOwner [

	^ self userData at: #barOwner ifAbsent: [  ]
]

{ #category : #'t - item bar element - accessing' }
TToItemListElement >> barOwner: aBarOwner [

	self userData at: #barOwner put: aBarOwner
]

{ #category : #'t - item bar element - accessing' }
TToItemListElement >> defaultNodeManagerClass [

	^ ToItemBarNodeManager
]

{ #category : #'t - item bar element - hidden/visible' }
TToItemListElement >> deselectedItem: anItem [

	self deselectedAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - disabled/enabled' }
TToItemListElement >> disabledItem: anItem [

	self disabledAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - disabled/enabled' }
TToItemListElement >> enabledItem: anItem [

	self enabledAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - hidden/visible' }
TToItemListElement >> hiddenItem: anItem [

	self hiddenAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - accessing' }
TToItemListElement >> initializeAsItemBarElement [ 

	self primarySelectionMode makeDisabledUnselectable: true
]

{ #category : #'t - item bar element - hidden/visible' }
TToItemListElement >> isSelectedItem: anItem [

	^ self isSelectedAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - accessing' }
TToItemListElement >> items [ 

	^ self dataAccessor
]

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> onAddedItem: anItem [

	anItem barElement: self
]

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> onRemovedItem: anItem [

	anItem barElement: nil
]

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> removeAllItems [

	self removeAllItems: self items asArray
]

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> removeAllItems: aCollection [

	aCollection do: [ :item | self removeItem: item ]
]

{ #category : #'t - item bar element - adding/removing' }
TToItemListElement >> removeItem: anItem [

	self items remove: anItem.
	self onRemovedItem: anItem
]

{ #category : #'t - item bar element - unselectable/selectable' }
TToItemListElement >> selectableItem: anItem [

	self selectableAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - hidden/visible' }
TToItemListElement >> selectedItem: anItem [

	self selectedAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - unselectable/selectable' }
TToItemListElement >> unselectableItem: anItem [

	self unselectableAtPosition: anItem positionInBar
]

{ #category : #'t - item bar element - hidden/visible' }
TToItemListElement >> visibleItem: anItem [

	self visibleAtPosition: anItem positionInBar
]
