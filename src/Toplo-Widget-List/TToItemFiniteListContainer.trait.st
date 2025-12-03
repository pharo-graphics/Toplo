Trait {
	#name : #TToItemFiniteListContainer,
	#instVars : [
		'itemBar'
	],
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> addAllItems: aCollection [

	self itemBar addAllItems: aCollection
]

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> addItem: anItem [

	self itemBar addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> addItem: anItem after: anotherItem [

	self itemBar addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> addItem: anItem afterIndex: anInteger [

	self itemBar addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> addItem: anItem before: anotherItem [

	self itemBar addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> addItem: anItem beforeIndex: anInteger [

	self itemBar addItem: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> autoDistribute [

	^ self itemBar autoDistribute
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> autoDistribute: aBoolean [

	self itemBar autoDistribute = aBoolean ifTrue: [ ^ self ].
	self itemBar autoDistribute: aBoolean.
	self requestConfiguration
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> dataAccessor [

	^ self itemBar dataAccessor
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> dataSource [

	^ self itemBar dataSource
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemFiniteListContainer >> deselectedAtPosition: anInteger [

	self itemBar deselectedAtPosition: anInteger
]

{ #category : #'t - item bar container - disable/ enable' }
TToItemFiniteListContainer >> disabledAtPosition: anInteger [

	self itemBar disabledAtPosition: anInteger
]

{ #category : #'t - item bar container - disable/ enable' }
TToItemFiniteListContainer >> disabledItem: anItem [

	self itemBar disabledItem: anItem
]

{ #category : #'t - item bar container - disable/ enable' }
TToItemFiniteListContainer >> enabledAtPosition: anInteger [

	self itemBar enabledAtPosition: anInteger
]

{ #category : #'t - item bar container - disable/ enable' }
TToItemFiniteListContainer >> enabledItem: anItem [

	self itemBar enabledItem: anItem
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> exactNodeHeight: aNumberOrNil [

	self itemBar exactNodeHeight = aNumberOrNil ifTrue: [ ^ self ].
	self itemBar exactNodeHeight: aNumberOrNil.
	self requestConfiguration
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> exactNodeWidth: aNumberOrNil [

	self itemBar exactNodeWidth = aNumberOrNil ifTrue: [ ^ self ].
	self itemBar exactNodeWidth: aNumberOrNil.
	self requestConfiguration
]

{ #category : #'t - item bar container - testing' }
TToItemFiniteListContainer >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemFiniteListContainer >> hiddenAtPosition: anInteger [

	self itemBar hiddenAtPosition: anInteger
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemFiniteListContainer >> hiddenItem: anItem [

	self itemBar hiddenItem: anItem
]

{ #category : #'t - item bar container - initializing' }
TToItemFiniteListContainer >> initializeAsItemBarContainer [

	self setItemBar: self newItemBar
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> innerElement [

	^ self itemBar innerElement
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> isFlowable [

	^ self itemBar isFlowable
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> isFlowable: aBoolean [

	self itemBar isFlowable = aBoolean ifTrue: [ ^ self ].
	self itemBar isFlowable: aBoolean.
	self requestConfiguration
]

{ #category : #'t - item bar container - testing' }
TToItemFiniteListContainer >> isItemContainer [

	^ true
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> isScrollable [

	^ self itemBar isScrollable
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> isScrollable: aBoolean [

	self itemBar isScrollable = aBoolean ifTrue: [ ^ self ].
	self itemBar isScrollable: aBoolean.
	self requestConfiguration
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> itemBar [

	^ itemBar
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> items [

	^ self itemBar dataAccessor
]

{ #category : #'t - item bar container - initializing' }
TToItemFiniteListContainer >> newItemBar [

	^ ToItemFiniteListElement new
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> nodeContainersDo: aValuable [

	self itemBar nodeContainersDo: aValuable
]

{ #category : #'t - item bar container - double dispatch' }
TToItemFiniteListContainer >> onAddedAnyItemKind: anItem [


]

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> onAddedItem: anItem [

	self onAddedAnyItemKind: anItem.
	anItem onAddedInItemBarOwner: self.

]

{ #category : #'t - item bar container - double dispatch' }
TToItemFiniteListContainer >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item bar container - double dispatch' }
TToItemFiniteListContainer >> onRemovedAnyItemKind: anItem [


]

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemBarOwner: self
]

{ #category : #'t - item bar container - double dispatch' }
TToItemFiniteListContainer >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> primarySelectionMode [

	^ self itemBar primarySelectionMode
]

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> removeAllItems [

	self itemBar removeAllItems
]

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> removeAllItems: aCollection [

	self itemBar removeAllItems: aCollection
]

{ #category : #'t - item bar container - adding/removing' }
TToItemFiniteListContainer >> removeItem: anItem [

	self onRemovedItem: anItem.
	self itemBar removeItem: anItem
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> secondarySelecter [

	^ self itemBar secondarySelecter
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> secondarySelectionMode [

	^ self itemBar secondarySelectionMode
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> secondarySelectionOption [

	^ self itemBar secondarySelectionOption
]

{ #category : #'t - item bar container - unselectable/selectable' }
TToItemFiniteListContainer >> selectableAtPosition: anInteger [

	self itemBar selectableAtPosition: anInteger
]

{ #category : #'t - item bar container - unselectable/selectable' }
TToItemFiniteListContainer >> selectableItem: anItem [

	self itemBar selectableItem: anItem
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemFiniteListContainer >> selectedAtPosition: anInteger [

	self itemBar selectedAtPosition: anInteger
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> selecter [

	^ self itemBar selecter
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> selectionMode [

	^ self itemBar selectionMode
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> selectionModel [

	^ self itemBar selectionModel
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> selectionOption [

	^ self itemBar selectionOption
]

{ #category : #'t - item bar container - accessing' }
TToItemFiniteListContainer >> setItemBar: anItemBar [

	itemBar ifNotNil: [ BlImmutableObjectChangeError signal ].
	itemBar := anItemBar
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> uniformNodeHeight [

	^ self itemBar uniformNodeHeight
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> uniformNodeHeight: aBoolean [

	self itemBar uniformNodeHeight: aBoolean
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> uniformNodeWidth [

	^ self itemBar uniformNodeWidth
]

{ #category : #'t - item bar container - configuration' }
TToItemFiniteListContainer >> uniformNodeWidth: aBoolean [

	self itemBar uniformNodeWidth: aBoolean
]

{ #category : #'t - item bar container - unselectable/selectable' }
TToItemFiniteListContainer >> unselectableAtPosition: anInteger [

	self itemBar unselectableAtPosition: anInteger
]

{ #category : #'t - item bar container - unselectable/selectable' }
TToItemFiniteListContainer >> unselectableItem: anItem [

	self itemBar unselectableItem: anItem
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemFiniteListContainer >> visibleAtPosition: anInteger [

	self itemBar visibleAtPosition: anInteger
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemFiniteListContainer >> visibleItem: anItem [

	self itemBar visibleItem: anItem
]
