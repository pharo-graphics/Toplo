Trait {
	#name : #TToItemFiniteListUser,
	#instVars : [
		'itemBar'
	],
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> addAllItems: aCollection [

	self itemBar addAllItems: aCollection
]

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> addItem: anItem [

	self itemBar addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> addItem: anItem after: anotherItem [

	self itemBar addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> addItem: anItem afterIndex: anInteger [

	self itemBar addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> addItem: anItem before: anotherItem [

	self itemBar addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> addItem: anItem beforeIndex: anInteger [

	self itemBar addItem: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item finite list user - configuration' }
TToItemFiniteListUser >> autoDistribute [

	^ self itemBar toConfiguration autoDistribute
]

{ #category : #'t - item finite list user - configuration' }
TToItemFiniteListUser >> autoDistribute: aBoolean [

	self itemBar toConfiguration autoDistribute: aBoolean
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> dataAccessor [

	^ self itemBar dataAccessor
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> dataSource [

	^ self itemBar dataSource
]

{ #category : #'t - item finite list user - hidden/visible' }
TToItemFiniteListUser >> deselectedAtPosition: anInteger [

	self itemBar deselectedAtPosition: anInteger
]

{ #category : #'t - item finite list user - disable/ enable' }
TToItemFiniteListUser >> disabledAtPosition: anInteger [

	self itemBar disabledAtPosition: anInteger
]

{ #category : #'t - item finite list user - disable/ enable' }
TToItemFiniteListUser >> disabledItem: anItem [

	self itemBar disabledItem: anItem
]

{ #category : #'t - item finite list user - disable/ enable' }
TToItemFiniteListUser >> enabledAtPosition: anInteger [

	self itemBar enabledAtPosition: anInteger
]

{ #category : #'t - item finite list user - disable/ enable' }
TToItemFiniteListUser >> enabledItem: anItem [

	self itemBar enabledItem: anItem
]

{ #category : #'t - item finite list user - testing' }
TToItemFiniteListUser >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item finite list user - hidden/visible' }
TToItemFiniteListUser >> hiddenAtPosition: anInteger [

	self itemBar hiddenAtPosition: anInteger
]

{ #category : #'t - item finite list user - hidden/visible' }
TToItemFiniteListUser >> hiddenItem: anItem [

	self itemBar hiddenItem: anItem
]

{ #category : #'t - item finite list user - initializing' }
TToItemFiniteListUser >> initializeAsItemBarContainer [

	self setItemBar: self newItemBar
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> innerElement [

	^ self itemBar innerElement
]

{ #category : #'t - item finite list user - configuration' }
TToItemFiniteListUser >> isFlowable [

	^ self itemBar toConfiguration isFlowable
]

{ #category : #'t - item finite list user - configuration' }
TToItemFiniteListUser >> isFlowable: aBoolean [

	self itemBar toConfiguration isFlowable: aBoolean
]

{ #category : #'t - item finite list user - testing' }
TToItemFiniteListUser >> isItemContainer [

	^ true
]

{ #category : #'t - item finite list user - configuration' }
TToItemFiniteListUser >> isScrollable [

	^ self itemBar toConfiguration isScrollable
]

{ #category : #'t - item finite list user - configuration' }
TToItemFiniteListUser >> isScrollable: aBoolean [

	self itemBar toConfiguration isScrollable: aBoolean
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> itemBar [

	^ itemBar
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> items [

	^ self itemBar dataAccessor
]

{ #category : #'t - item finite list user - initializing' }
TToItemFiniteListUser >> newItemBar [

	^ ToItemFiniteListElement new
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> nodeContainersDo: aValuable [

	self itemBar nodeContainersDo: aValuable
]

{ #category : #'t - item finite list user - double dispatch' }
TToItemFiniteListUser >> onAddedAnyItemKind: anItem [


]

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> onAddedItem: anItem [

	self onAddedAnyItemKind: anItem.
	anItem onAddedInItemBarOwner: self.

]

{ #category : #'t - item finite list user - double dispatch' }
TToItemFiniteListUser >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item finite list user - double dispatch' }
TToItemFiniteListUser >> onRemovedAnyItemKind: anItem [


]

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemBarOwner: self
]

{ #category : #'t - item finite list user - double dispatch' }
TToItemFiniteListUser >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> primarySelectionMode [

	^ self itemBar primarySelectionMode
]

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> removeAllItems [

	self itemBar removeAllItems
]

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> removeAllItems: aCollection [

	self itemBar removeAllItems: aCollection
]

{ #category : #'t - item finite list user - adding/removing' }
TToItemFiniteListUser >> removeItem: anItem [

	self onRemovedItem: anItem.
	self itemBar removeItem: anItem
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> secondarySelecter [

	^ self itemBar secondarySelecter
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> secondarySelectionMode [

	^ self itemBar secondarySelectionMode
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> secondarySelectionOption [

	^ self itemBar secondarySelectionOption
]

{ #category : #'t - item finite list user - unselectable/selectable' }
TToItemFiniteListUser >> selectableAtPosition: anInteger [

	self itemBar selectableAtPosition: anInteger
]

{ #category : #'t - item finite list user - unselectable/selectable' }
TToItemFiniteListUser >> selectableItem: anItem [

	self itemBar selectableItem: anItem
]

{ #category : #'t - item finite list user - hidden/visible' }
TToItemFiniteListUser >> selectedAtPosition: anInteger [

	self itemBar selectedAtPosition: anInteger
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> selecter [

	^ self itemBar selecter
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> selectionMode [

	^ self itemBar selectionMode
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> selectionModel [

	^ self itemBar selectionModel
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> selectionOption [

	^ self itemBar selectionOption
]

{ #category : #'t - item finite list user - accessing' }
TToItemFiniteListUser >> setItemBar: anItemBar [

	itemBar ifNotNil: [ BlImmutableObjectChangeError signal ].
	itemBar := anItemBar
]

{ #category : #'t - item finite list user - configuration' }
TToItemFiniteListUser >> uniformNodeHeight [

	^ self itemBar toConfiguration uniformNodeHeight
]

{ #category : #'t - item finite list user - configuration' }
TToItemFiniteListUser >> uniformNodeHeight: aBoolean [

	self itemBar toConfiguration uniformNodeHeight: aBoolean
]

{ #category : #'t - item finite list user - configuration' }
TToItemFiniteListUser >> uniformNodeWidth [

	^ self itemBar uniformNodeWidth
]

{ #category : #'t - item finite list user - configuration' }
TToItemFiniteListUser >> uniformNodeWidth: aBoolean [

	self itemBar toConfiguration uniformNodeWidth: aBoolean
]

{ #category : #'t - item finite list user - unselectable/selectable' }
TToItemFiniteListUser >> unselectableAtPosition: anInteger [

	self itemBar unselectableAtPosition: anInteger
]

{ #category : #'t - item finite list user - unselectable/selectable' }
TToItemFiniteListUser >> unselectableItem: anItem [

	self itemBar unselectableItem: anItem
]

{ #category : #'t - item finite list user - hidden/visible' }
TToItemFiniteListUser >> visibleAtPosition: anInteger [

	self itemBar visibleAtPosition: anInteger
]

{ #category : #'t - item finite list user - hidden/visible' }
TToItemFiniteListUser >> visibleItem: anItem [

	self itemBar visibleItem: anItem
]
