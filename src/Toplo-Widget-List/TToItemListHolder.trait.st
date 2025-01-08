Trait {
	#name : #TToItemListHolder,
	#instVars : [
		'itemList'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> addItem: anItem [

	self items add: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> addItem: anItem after: anotherItem [

	self items add: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> addItem: anItem afterIndex: anInteger [

	self items add: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> addItem: anItem before: anotherItem [

	self items add: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> addItem: anItem beforeIndex: anInteger [

	self items add: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - initializing' }
TToItemListHolder >> configureLayout [

	self isHorizontal
		ifTrue: [ self itemList horizontal: true ]
		ifFalse: [ self itemList horizontal: false ]
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> dataAccessor [ 

	^ self itemList dataAccessor
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> dataSource [

	^ self itemList dataSource
]

{ #category : #'t - item list holder - enable/disable' }
TToItemListHolder >> disableItem: anItem [

	self
		deprecated: 'Use #disabledItem: instead'
		transformWith:
		'`@rcvr disableItem: `@arg1' -> '`@rcvr disabledItem: `@arg1'.

	self disabledItem: anItem
]

{ #category : #'t - item list holder - enable/disable' }
TToItemListHolder >> disabledAtPosition: anInteger [

	self itemList disabledAtPosition: anInteger
]

{ #category : #'t - item list holder - enable/disable' }
TToItemListHolder >> disabledItem: anItem [

	self disabledAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - enable/disable' }
TToItemListHolder >> enableItem: anItem [

	self
		deprecated: 'Use #enabledItem: instead'
		transformWith:
		'`@rcvr enableItem: `@arg1' -> '`@rcvr enabledItem: `@arg1'.

	self enabledItem: anItem
]

{ #category : #'t - item list holder - enable/disable' }
TToItemListHolder >> enabledAtPosition: anInteger [

	self itemList enabledAtPosition: anInteger
]

{ #category : #'t - item list holder - enable/disable' }
TToItemListHolder >> enabledItem: anItem [

	self enabledAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - testing' }
TToItemListHolder >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemListHolder >> hiddenAtPosition: anInteger [

	self itemList hiddenAtPosition: anInteger
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemListHolder >> hiddenItem: anItem [

	self hiddenAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> innerElement [

	^ self itemList innerElement
]

{ #category : #'t - item list holder - testing' }
TToItemListHolder >> isItemContainer [

	^ true
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> isNodeAutoDistribution [

	^ self itemList isNodeAutoDistribution
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> isNodeScrolling [

	^ self itemList isNodeScrolling
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> isNodeWrapping [

	^ self itemList isNodeWrapping
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> isUniformNodeHeight [

	^ self itemList isUniformNodeHeight
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> isUniformNodeWidth [

	^ self itemList isUniformNodeWidth
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> itemList [

	^ itemList ifNil: [ itemList := self newItemList ]
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> items [

	^ self itemList dataAccessor
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> newItemList [

	^ ToItemListElement new
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> nodeAutoDistribution: aBoolean [

	self itemList nodeAutoDistribution: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> nodeScrolling: aBoolean [

	self itemList nodeScrolling: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> nodeWrapping: aBoolean [

	self itemList nodeWrapping: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - double dispatch' }
TToItemListHolder >> onAddedAnyItemKind: anItem [

	anItem presetDataDo: [ :pd | pd setupItem: anItem ]
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> onAddedItem: anItem [

	anItem onAddedInItemListHolder: self.
	self onAddedAnyItemKind: anItem.

]

{ #category : #'t - item list holder - double dispatch' }
TToItemListHolder >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item list holder - double dispatch' }
TToItemListHolder >> onRemovedAnyItemKind: anItem [

	
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemListHolder: self
]

{ #category : #'t - item list holder - double dispatch' }
TToItemListHolder >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> primarySelectionMode [

	^ self itemList primarySelectionMode
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> removeAllItems [

	self removeAllItems: self items asArray
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> removeAllItems: aCollection [

	aCollection do: [ :item | self removeItem: item ]
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> removeItem: anItem [

	self onRemovedItem: anItem.
	self items remove: anItem
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> secondarySelecter [

	^ itemList secondarySelecter
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> secondarySelectionMode [

	^ self itemList secondarySelectionMode
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemListHolder >> selectableAtPosition: anInteger [

	self itemList selectableAtPosition: anInteger
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemListHolder >> selectableItem: anItem [

	self selectableAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> selectionModel [

	^ self itemList selectionModel
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> selectionOption [

	^ self itemList selectionOption
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> uniformNodeHeight: aBoolean [

	self itemList uniformNodeHeight: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> uniformNodeWidth: aBoolean [

	self itemList uniformNodeWidth: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemListHolder >> unselectableAtPosition: anInteger [

	self itemList unselectableAtPosition: anInteger
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemListHolder >> unselectableItem: anItem [

	self unselectableAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemListHolder >> visibleAtPosition: anInteger [

	self itemList visibleAtPosition: anInteger
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemListHolder >> visibleItem: anItem [

	self visibleAtPosition: anItem positionInItemList
]
