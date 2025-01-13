Trait {
	#name : #TToItemBarOwner,
	#instVars : [
		'itemBar'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addItem: anItem [

	self items add: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addItem: anItem after: anotherItem [

	self items add: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addItem: anItem afterIndex: anInteger [

	self items add: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addItem: anItem before: anotherItem [

	self items add: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addItem: anItem beforeIndex: anInteger [

	self items add: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - initializing' }
TToItemBarOwner >> configureLayout [

	self isHorizontal
		ifTrue: [ self itemList horizontal: true ]
		ifFalse: [ self itemList horizontal: false ]
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> dataAccessor [ 

	^ self itemList dataAccessor
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> dataSource [

	^ self itemList dataSource
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarOwner >> disableItem: anItem [

	self
		deprecated: 'Use #disabledItem: instead'
		transformWith:
		'`@rcvr disableItem: `@arg1' -> '`@rcvr disabledItem: `@arg1'.

	self disabledItem: anItem
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarOwner >> disabledAtPosition: anInteger [

	self itemBar disabledAtPosition: anInteger
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarOwner >> disabledItem: anItem [

	self disabledAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarOwner >> enableItem: anItem [

	self
		deprecated: 'Use #enabledItem: instead'
		transformWith:
		'`@rcvr enableItem: `@arg1' -> '`@rcvr enabledItem: `@arg1'.

	self enabledItem: anItem
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarOwner >> enabledAtPosition: anInteger [

	self itemBar enabledAtPosition: anInteger
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarOwner >> enabledItem: anItem [

	self enabledAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - testing' }
TToItemBarOwner >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemBarOwner >> hiddenAtPosition: anInteger [

	self itemList hiddenAtPosition: anInteger
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemBarOwner >> hiddenItem: anItem [

	self hiddenAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> innerElement [

	^ self itemList innerElement
]

{ #category : #'t - item list holder - testing' }
TToItemBarOwner >> isItemContainer [

	^ true
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> isNodeAutoDistribution [

	^ self itemList isNodeAutoDistribution
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> isNodeScrolling [

	^ self itemList isNodeScrolling
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> isNodeWrapping [

	^ self itemList isNodeWrapping
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> isUniformNodeHeight [

	^ self itemList isUniformNodeHeight
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> isUniformNodeWidth [

	^ self itemList isUniformNodeWidth
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> itemBar [

	^ itemBar ifNil: [ itemBar := self newItemList ]
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> itemList [

	self
		deprecated: 'Use itemBar instead'
		transformWith: '`@rcvr itemList' -> '`@rcvr itemBar'.

	^ self itemBar
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> items [

	^ self itemBar dataAccessor
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> newItemBar [

	^ ToItemBarElement new
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> newItemList [

	self
		deprecated: 'Use newItemBar instead'
		transformWith: '`@rcvr newItemList' -> '`@rcvr newItemBar'.
	^ self newItemBar
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> nodeAutoDistribution: aBoolean [

	self itemList nodeAutoDistribution: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> nodeScrolling: aBoolean [

	self itemList nodeScrolling: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> nodeWrapping: aBoolean [

	self itemBar nodeWrapping: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - double dispatch' }
TToItemBarOwner >> onAddedAnyItemKind: anItem [

	anItem parentItemListHolder: self  
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> onAddedItem: anItem [

	anItem onAddedInItemListHolder: self.
	self onAddedAnyItemKind: anItem.

]

{ #category : #'t - item list holder - double dispatch' }
TToItemBarOwner >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item list holder - double dispatch' }
TToItemBarOwner >> onRemovedAnyItemKind: anItem [

	anItem parentItemListHolder: nil  
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemListHolder: self
]

{ #category : #'t - item list holder - double dispatch' }
TToItemBarOwner >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> primarySelectionMode [

	^ self itemList primarySelectionMode
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> removeAllItems [

	self removeAllItems: self items asArray
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> removeAllItems: aCollection [

	aCollection do: [ :item | self removeItem: item ]
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> removeItem: anItem [

	self onRemovedItem: anItem.
	self items remove: anItem
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> secondarySelecter [

	^ itemBar secondarySelecter
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> secondarySelectionMode [

	^ self itemList secondarySelectionMode
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemBarOwner >> selectableAtPosition: anInteger [

	self itemList selectableAtPosition: anInteger
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemBarOwner >> selectableItem: anItem [

	self selectableAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> selectionModel [

	^ self itemList selectionModel
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> selectionOption [

	^ self itemList selectionOption
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> uniformNodeHeight: aBoolean [

	self itemList uniformNodeHeight: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> uniformNodeWidth: aBoolean [

	self itemBar uniformNodeWidth: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemBarOwner >> unselectableAtPosition: anInteger [

	self itemList unselectableAtPosition: anInteger
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemBarOwner >> unselectableItem: anItem [

	self unselectableAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemBarOwner >> visibleAtPosition: anInteger [

	self itemList visibleAtPosition: anInteger
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemBarOwner >> visibleItem: anItem [

	self visibleAtPosition: anItem positionInItemList
]
