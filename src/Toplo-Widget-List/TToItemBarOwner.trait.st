Trait {
	#name : #TToItemBarOwner,
	#instVars : [
		'itemBar'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addAllItems: aCollection [

	itemBar addAllItems: aCollection
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addItem: anItem [

	itemBar addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addItem: anItem after: anotherItem [

	itemBar addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addItem: anItem afterIndex: anInteger [

	itemBar addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addItem: anItem before: anotherItem [

	itemBar addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addItem: anItem beforeIndex: anInteger [

	itemBar addItem: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - initializing' }
TToItemBarOwner >> configureLayout [

	self isHorizontal
		ifTrue: [ self itemList horizontal: true ]
		ifFalse: [ self itemList horizontal: false ]
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> dataAccessor [

	^ self itemBar dataAccessor
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> dataSource [

	^ self itemBar dataSource
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarOwner >> disableItem: anItem [

	self
		deprecated: 'Use #disabledItem: instead'
		transformWith:
		'`@rcvr disableItem: `@arg1' -> '`@rcvr disabledItem: `@arg1'.

	self disabledItem: anItem
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarOwner >> disabledAtPosition: anInteger [

	itemBar disabledAtPosition: anInteger
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarOwner >> disabledItem: anItem [

	itemBar disabledItem: anItem
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarOwner >> enableItem: anItem [

	self
		deprecated: 'Use #enabledItem: instead'
		transformWith:
		'`@rcvr enableItem: `@arg1' -> '`@rcvr enabledItem: `@arg1'.

	self enabledItem: anItem
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarOwner >> enabledAtPosition: anInteger [

	itemBar enabledAtPosition: anInteger
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarOwner >> enabledItem: anItem [

	itemBar enabledItem: anItem
]

{ #category : #'t - item bar owner - testing' }
TToItemBarOwner >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarOwner >> hiddenAtPosition: anInteger [

	itemBar hiddenAtPosition: anInteger
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarOwner >> hiddenItem: anItem [

	itemBar hiddenItem: anItem
]

{ #category : #'t - item bar owner - initializing' }
TToItemBarOwner >> initializeAsItemBarOwner [

	itemBar := self newItemBar
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> innerElement [

	^ self itemBar innerElement
]

{ #category : #'t - item bar owner - testing' }
TToItemBarOwner >> isItemContainer [

	^ true
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> isNodeAutoDistribution [

	^ self itemBar isNodeAutoDistribution
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> isNodeScrolling [

	^ self itemBar isNodeScrolling
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> isNodeWrapping [

	^ self itemBar isNodeWrapping
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> isUniformNodeHeight [

	^ self itemBar isUniformNodeHeight
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> isUniformNodeWidth [

	^ self itemBar isUniformNodeWidth
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> itemBar [

	^ itemBar
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> itemList [

	self
		deprecated: 'Use itemBar instead'
		transformWith: '`@rcvr itemList' -> '`@rcvr itemBar'.

	^ self itemBar
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> items [

	^ self itemBar dataAccessor
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> newItemBar [

	^ ToItemBarElement new
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> nodeAutoDistribution: aBoolean [

	self itemBar nodeAutoDistribution: aBoolean.
	self configureLayout
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> nodeScrolling: aBoolean [

	self itemBar nodeScrolling: aBoolean.
	self configureLayout
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> nodeWrapping: aBoolean [

	self itemBar nodeWrapping: aBoolean.
	self configureLayout
]

{ #category : #'t - item bar owner - double dispatch' }
TToItemBarOwner >> onAddedAnyItemKind: anItem [

	anItem barOwner: self  
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> onAddedItem: anItem [

	self onAddedAnyItemKind: anItem.
	anItem onAddedInItemBarOwner: self.

]

{ #category : #'t - item bar owner - double dispatch' }
TToItemBarOwner >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item bar owner - double dispatch' }
TToItemBarOwner >> onRemovedAnyItemKind: anItem [

	anItem barOwner: nil  
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemBarOwner: self
]

{ #category : #'t - item bar owner - double dispatch' }
TToItemBarOwner >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> primarySelectionMode [

	^ self itemBar primarySelectionMode
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> removeAllItems [

	itemBar removeAllItems
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> removeAllItems: aCollection [

	itemBar removeAllItems: aCollection
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> removeItem: anItem [

	self onRemovedItem: anItem.
	itemBar removeItem: anItem
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> secondarySelecter [

	^ itemBar secondarySelecter
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> secondarySelectionMode [

	^ self itemBar secondarySelectionMode
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarOwner >> selectableAtPosition: anInteger [

	itemBar selectableAtPosition: anInteger
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarOwner >> selectableItem: anItem [

	itemBar selectableItem: anItem
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> selectionModel [

	^ self itemBar selectionModel
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> selectionOption [

	^ self itemBar selectionOption
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> uniformNodeHeight: aBoolean [

	self itemBar uniformNodeHeight: aBoolean.
	self configureLayout
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> uniformNodeWidth: aBoolean [

	self itemBar uniformNodeWidth: aBoolean.
	self configureLayout
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarOwner >> unselectableAtPosition: anInteger [

	itemBar unselectableAtPosition: anInteger
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarOwner >> unselectableItem: anItem [

	itemBar unselectableItem: anItem
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarOwner >> visibleAtPosition: anInteger [

	itemBar visibleAtPosition: anInteger
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarOwner >> visibleItem: anItem [

	itemBar visibleItem: anItem
]
