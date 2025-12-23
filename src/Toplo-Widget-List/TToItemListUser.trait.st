Trait {
	#name : #TToItemListUser,
	#instVars : [
		'itemBar'
	],
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addAllItems: aCollection [

	self itemBar addAllItems: aCollection
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addItem: anItem [

	self itemBar addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addItem: anItem after: anotherItem [

	self itemBar addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addItem: anItem afterIndex: anInteger [

	self itemBar addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addItem: anItem before: anotherItem [

	self itemBar addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> addItem: anItem beforeIndex: anInteger [

	self itemBar addItem: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> autoDistribute [

	^ self itemBar toConfiguration autoDistribute
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> autoDistribute: aBoolean [

	self itemBar toConfiguration autoDistribute: aBoolean
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> dataAccessor [

	^ self itemBar dataAccessor
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> dataSource [

	^ self itemBar dataSource
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> deselectedAtPosition: anInteger [

	self itemBar deselectedAtPosition: anInteger
]

{ #category : #'t - item list user - disable/ enable' }
TToItemListUser >> disabledAtPosition: anInteger [

	self itemBar disabledAtPosition: anInteger
]

{ #category : #'t - item list user - disable/ enable' }
TToItemListUser >> disabledItem: anItem [

	self itemBar disabledItem: anItem
]

{ #category : #'t - item list user - disable/ enable' }
TToItemListUser >> enabledAtPosition: anInteger [

	self itemBar enabledAtPosition: anInteger
]

{ #category : #'t - item list user - disable/ enable' }
TToItemListUser >> enabledItem: anItem [

	self itemBar enabledItem: anItem
]

{ #category : #'t - item list user - testing' }
TToItemListUser >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> hiddenAtPosition: anInteger [

	self itemBar hiddenAtPosition: anInteger
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> hiddenItem: anItem [

	self itemBar hiddenItem: anItem
]

{ #category : #'t - item list user - initializing' }
TToItemListUser >> initializeAsItemBarContainer [

	self setItemBar: self newItemBar
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> innerElement [

	^ self itemBar innerElement
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> isFlowable [

	^ self itemBar toConfiguration isFlowable
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> isFlowable: aBoolean [

	self itemBar toConfiguration isFlowable: aBoolean
]

{ #category : #'t - item list user - testing' }
TToItemListUser >> isItemContainer [

	^ true
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> isScrollable [

	^ self itemBar toConfiguration isScrollable
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> isScrollable: aBoolean [

	self itemBar toConfiguration isScrollable: aBoolean
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> itemBar [

	^ itemBar
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> items [

	^ self itemBar dataAccessor
]

{ #category : #'t - item list user - initializing' }
TToItemListUser >> newItemBar [

	^ ToItemFiniteListElement new
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> nodeContainersDo: aValuable [

	self itemBar nodeContainersDo: aValuable
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

	^ self itemBar primarySelectionMode
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> removeAllItems [

	self itemBar removeAllItems
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> removeAllItems: aCollection [

	self itemBar removeAllItems: aCollection
]

{ #category : #'t - item list user - adding/removing' }
TToItemListUser >> removeItem: anItem [

	self onRemovedItem: anItem.
	self itemBar removeItem: anItem
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> secondarySelecter [

	^ self itemBar secondarySelecter
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> secondarySelectionMode [

	^ self itemBar secondarySelectionMode
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> secondarySelectionOption [

	^ self itemBar secondarySelectionOption
]

{ #category : #'t - item list user - unselectable/selectable' }
TToItemListUser >> selectableAtPosition: anInteger [

	self itemBar selectableAtPosition: anInteger
]

{ #category : #'t - item list user - unselectable/selectable' }
TToItemListUser >> selectableItem: anItem [

	self itemBar selectableItem: anItem
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> selectedAtPosition: anInteger [

	self itemBar selectedAtPosition: anInteger
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> selecter [

	^ self itemBar selecter
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> selectionMode [

	^ self itemBar selectionMode
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> selectionModel [

	^ self itemBar selectionModel
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> selectionOption [

	^ self itemBar selectionOption
]

{ #category : #'t - item list user - accessing' }
TToItemListUser >> setItemBar: anItemBar [

	itemBar ifNotNil: [ BlImmutableObjectChangeError signal ].
	itemBar := anItemBar
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> uniformNodeHeight [

	^ self itemBar toConfiguration uniformNodeHeight
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> uniformNodeHeight: aBoolean [

	self itemBar toConfiguration uniformNodeHeight: aBoolean
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> uniformNodeWidth [

	^ self itemBar uniformNodeWidth
]

{ #category : #'t - item list user - configuration' }
TToItemListUser >> uniformNodeWidth: aBoolean [

	self itemBar toConfiguration uniformNodeWidth: aBoolean
]

{ #category : #'t - item list user - unselectable/selectable' }
TToItemListUser >> unselectableAtPosition: anInteger [

	self itemBar unselectableAtPosition: anInteger
]

{ #category : #'t - item list user - unselectable/selectable' }
TToItemListUser >> unselectableItem: anItem [

	self itemBar unselectableItem: anItem
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> visibleAtPosition: anInteger [

	self itemBar visibleAtPosition: anInteger
]

{ #category : #'t - item list user - hidden/visible' }
TToItemListUser >> visibleItem: anItem [

	self itemBar visibleItem: anItem
]
