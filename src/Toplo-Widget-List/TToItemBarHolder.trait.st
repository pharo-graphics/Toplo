Trait {
	#name : #TToItemBarHolder,
	#instVars : [
		'itemList'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> addItem: anItem [

	self items add: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> addItem: anItem after: anotherItem [

	self items add: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> addItem: anItem afterIndex: anInteger [

	self items add: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> addItem: anItem before: anotherItem [

	self items add: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> addItem: anItem beforeIndex: anInteger [

	self items add: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - initializing' }
TToItemBarHolder >> configureLayout [

	self isHorizontal
		ifTrue: [ self itemList horizontal: true ]
		ifFalse: [ self itemList horizontal: false ]
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> dataAccessor [ 

	^ self itemList dataAccessor
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> dataSource [

	^ self itemList dataSource
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarHolder >> disableItem: anItem [

	self
		deprecated: 'Use #disabledItem: instead'
		transformWith:
		'`@rcvr disableItem: `@arg1' -> '`@rcvr disabledItem: `@arg1'.

	self disabledItem: anItem
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarHolder >> disabledAtPosition: anInteger [

	self itemList disabledAtPosition: anInteger
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarHolder >> disabledItem: anItem [

	self disabledAtPosition: anItem positionInBar
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarHolder >> enableItem: anItem [

	self
		deprecated: 'Use #enabledItem: instead'
		transformWith:
		'`@rcvr enableItem: `@arg1' -> '`@rcvr enabledItem: `@arg1'.

	self enabledItem: anItem
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarHolder >> enabledAtPosition: anInteger [

	self itemList enabledAtPosition: anInteger
]

{ #category : #'t - item list holder - enable/disable' }
TToItemBarHolder >> enabledItem: anItem [

	self enabledAtPosition: anItem positionInBar
]

{ #category : #'t - item list holder - testing' }
TToItemBarHolder >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemBarHolder >> hiddenAtPosition: anInteger [

	self itemList hiddenAtPosition: anInteger
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemBarHolder >> hiddenItem: anItem [

	self hiddenAtPosition: anItem positionInBar
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> innerElement [

	^ self itemList innerElement
]

{ #category : #'t - item list holder - testing' }
TToItemBarHolder >> isItemContainer [

	^ true
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> isNodeAutoDistribution [

	^ self itemList isNodeAutoDistribution
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> isNodeScrolling [

	^ self itemList isNodeScrolling
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> isNodeWrapping [

	^ self itemList isNodeWrapping
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> isUniformNodeHeight [

	^ self itemList isUniformNodeHeight
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> isUniformNodeWidth [

	^ self itemList isUniformNodeWidth
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> itemList [

	^ itemList ifNil: [ itemList := self newItemList ]
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> items [

	^ self itemList dataAccessor
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> newItemList [

	^ ToItemBarElement new
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> nodeAutoDistribution: aBoolean [

	self itemList nodeAutoDistribution: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> nodeScrolling: aBoolean [

	self itemList nodeScrolling: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> nodeWrapping: aBoolean [

	self itemList nodeWrapping: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - double dispatch' }
TToItemBarHolder >> onAddedAnyItemKind: anItem [

]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> onAddedItem: anItem [

	anItem onAddedInItemListHolder: self.
	self onAddedAnyItemKind: anItem.

]

{ #category : #'t - item list holder - double dispatch' }
TToItemBarHolder >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item list holder - double dispatch' }
TToItemBarHolder >> onRemovedAnyItemKind: anItem [

	
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemListHolder: self
]

{ #category : #'t - item list holder - double dispatch' }
TToItemBarHolder >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> primarySelectionMode [

	^ self itemList primarySelectionMode
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> removeAllItems [

	self removeAllItems: self items asArray
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> removeAllItems: aCollection [

	aCollection do: [ :item | self removeItem: item ]
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarHolder >> removeItem: anItem [

	self onRemovedItem: anItem.
	self items remove: anItem
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> secondarySelecter [

	^ itemList secondarySelecter
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> secondarySelectionMode [

	^ self itemList secondarySelectionMode
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemBarHolder >> selectableAtPosition: anInteger [

	self itemList selectableAtPosition: anInteger
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemBarHolder >> selectableItem: anItem [

	self selectableAtPosition: anItem positionInBar
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> selectionModel [

	^ self itemList selectionModel
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> selectionOption [

	^ self itemList selectionOption
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> uniformNodeHeight: aBoolean [

	self itemList uniformNodeHeight: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - accessing' }
TToItemBarHolder >> uniformNodeWidth: aBoolean [

	self itemList uniformNodeWidth: aBoolean.
	self configureLayout
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemBarHolder >> unselectableAtPosition: anInteger [

	self itemList unselectableAtPosition: anInteger
]

{ #category : #'t - item list holder - selectable/unselectable' }
TToItemBarHolder >> unselectableItem: anItem [

	self unselectableAtPosition: anItem positionInBar
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemBarHolder >> visibleAtPosition: anInteger [

	self itemList visibleAtPosition: anInteger
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemBarHolder >> visibleItem: anItem [

	self visibleAtPosition: anItem positionInBar
]
