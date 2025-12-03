Trait {
	#name : #TToItemBarContainer,
	#instVars : [
		'itemBar'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> addAllItems: aCollection [

	self itemBar addAllItems: aCollection
]

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> addItem: anItem [

	self itemBar addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> addItem: anItem after: anotherItem [

	self itemBar addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> addItem: anItem afterIndex: anInteger [

	self itemBar addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> addItem: anItem before: anotherItem [

	self itemBar addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> addItem: anItem beforeIndex: anInteger [

	self itemBar addItem: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> autoDistribute [

	^ self itemBar autoDistribute
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> autoDistribute: aBoolean [

	self itemBar autoDistribute = aBoolean ifTrue: [ ^ self ].
	self itemBar autoDistribute: aBoolean.
	self requestConfiguration
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> dataAccessor [

	^ self itemBar dataAccessor
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> dataSource [

	^ self itemBar dataSource
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemBarContainer >> deselectedAtPosition: anInteger [

	self itemBar deselectedAtPosition: anInteger
]

{ #category : #'t - item bar container - disable/ enable' }
TToItemBarContainer >> disabledAtPosition: anInteger [

	self itemBar disabledAtPosition: anInteger
]

{ #category : #'t - item bar container - disable/ enable' }
TToItemBarContainer >> disabledItem: anItem [

	self itemBar disabledItem: anItem
]

{ #category : #'t - item bar container - disable/ enable' }
TToItemBarContainer >> enabledAtPosition: anInteger [

	self itemBar enabledAtPosition: anInteger
]

{ #category : #'t - item bar container - disable/ enable' }
TToItemBarContainer >> enabledItem: anItem [

	self itemBar enabledItem: anItem
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> exactNodeHeight: aNumberOrNil [

	self itemBar exactNodeHeight = aNumberOrNil ifTrue: [ ^ self ].
	self itemBar exactNodeHeight: aNumberOrNil.
	self requestConfiguration
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> exactNodeWidth: aNumberOrNil [

	self itemBar exactNodeWidth = aNumberOrNil ifTrue: [ ^ self ].
	self itemBar exactNodeWidth: aNumberOrNil.
	self requestConfiguration
]

{ #category : #'t - item bar container - testing' }
TToItemBarContainer >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemBarContainer >> hiddenAtPosition: anInteger [

	self itemBar hiddenAtPosition: anInteger
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemBarContainer >> hiddenItem: anItem [

	self itemBar hiddenItem: anItem
]

{ #category : #'t - item bar container - initializing' }
TToItemBarContainer >> initializeAsItemBarContainer [

	self setItemBar: self newItemBar
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> innerElement [

	^ self itemBar innerElement
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> isFlowable [

	^ self itemBar isFlowable
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> isFlowable: aBoolean [

	self itemBar isFlowable = aBoolean ifTrue: [ ^ self ].
	self itemBar isFlowable: aBoolean.
	self requestConfiguration
]

{ #category : #'t - item bar container - testing' }
TToItemBarContainer >> isItemContainer [

	^ true
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> isScrollable [

	^ self itemBar isScrollable
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> isScrollable: aBoolean [

	self itemBar isScrollable = aBoolean ifTrue: [ ^ self ].
	self itemBar isScrollable: aBoolean.
	self requestConfiguration
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> itemBar [

	^ itemBar
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> items [

	^ self itemBar dataAccessor
]

{ #category : #'t - item bar container - initializing' }
TToItemBarContainer >> newItemBar [

	^ ToItemFiniteListElement new
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> nodeContainersDo: aValuable [

	self itemBar nodeContainersDo: aValuable
]

{ #category : #'t - item bar container - double dispatch' }
TToItemBarContainer >> onAddedAnyItemKind: anItem [


]

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> onAddedItem: anItem [

	self onAddedAnyItemKind: anItem.
	anItem onAddedInItemBarOwner: self.

]

{ #category : #'t - item bar container - double dispatch' }
TToItemBarContainer >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item bar container - double dispatch' }
TToItemBarContainer >> onRemovedAnyItemKind: anItem [


]

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemBarOwner: self
]

{ #category : #'t - item bar container - double dispatch' }
TToItemBarContainer >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> primarySelectionMode [

	^ self itemBar primarySelectionMode
]

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> removeAllItems [

	self itemBar removeAllItems
]

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> removeAllItems: aCollection [

	self itemBar removeAllItems: aCollection
]

{ #category : #'t - item bar container - adding/removing' }
TToItemBarContainer >> removeItem: anItem [

	self onRemovedItem: anItem.
	self itemBar removeItem: anItem
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> secondarySelecter [

	^ self itemBar secondarySelecter
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> secondarySelectionMode [

	^ self itemBar secondarySelectionMode
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> secondarySelectionOption [

	^ self itemBar secondarySelectionOption
]

{ #category : #'t - item bar container - unselectable/selectable' }
TToItemBarContainer >> selectableAtPosition: anInteger [

	self itemBar selectableAtPosition: anInteger
]

{ #category : #'t - item bar container - unselectable/selectable' }
TToItemBarContainer >> selectableItem: anItem [

	self itemBar selectableItem: anItem
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemBarContainer >> selectedAtPosition: anInteger [

	self itemBar selectedAtPosition: anInteger
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> selecter [

	^ self itemBar selecter
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> selectionMode [

	^ self itemBar selectionMode
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> selectionModel [

	^ self itemBar selectionModel
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> selectionOption [

	^ self itemBar selectionOption
]

{ #category : #'t - item bar container - accessing' }
TToItemBarContainer >> setItemBar: anItemBar [

	itemBar ifNotNil: [ BlImmutableObjectChangeError signal ].
	itemBar := anItemBar
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> uniformNodeHeight [

	^ self itemBar uniformNodeHeight
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> uniformNodeHeight: aBoolean [

	self itemBar uniformNodeHeight: aBoolean
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> uniformNodeWidth [

	^ self itemBar uniformNodeWidth
]

{ #category : #'t - item bar container - configuration' }
TToItemBarContainer >> uniformNodeWidth: aBoolean [

	self itemBar uniformNodeWidth: aBoolean
]

{ #category : #'t - item bar container - unselectable/selectable' }
TToItemBarContainer >> unselectableAtPosition: anInteger [

	self itemBar unselectableAtPosition: anInteger
]

{ #category : #'t - item bar container - unselectable/selectable' }
TToItemBarContainer >> unselectableItem: anItem [

	self itemBar unselectableItem: anItem
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemBarContainer >> visibleAtPosition: anInteger [

	self itemBar visibleAtPosition: anInteger
]

{ #category : #'t - item bar container - hidden/visible' }
TToItemBarContainer >> visibleItem: anItem [

	self itemBar visibleItem: anItem
]
