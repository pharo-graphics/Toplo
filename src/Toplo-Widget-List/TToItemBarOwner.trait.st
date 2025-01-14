Trait {
	#name : #TToItemBarOwner,
	#instVars : [
		'itemBar'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addAllItems: aCollection [

	itemBar addAllItems: aCollection
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addItem: anItem [

	itemBar addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addItem: anItem after: anotherItem [

	itemBar addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addItem: anItem afterIndex: anInteger [

	itemBar addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addItem: anItem before: anotherItem [

	itemBar addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> addItem: anItem beforeIndex: anInteger [

	itemBar addItem: anItem beforeIndex: anInteger.
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

	^ self itemBar dataAccessor
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> dataSource [

	^ self itemBar dataSource
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

	self disabledAtPosition: anItem positionInBar
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

	self enabledAtPosition: anItem positionInBar
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

	self hiddenAtPosition: anItem positionInBar
]

{ #category : #'t - item list holder - initializing' }
TToItemBarOwner >> initializeAsItemBarOwner [

	itemBar := self newItemBar
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

	^ self itemBar isNodeAutoDistribution
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> isNodeScrolling [

	^ self itemBar isNodeScrolling
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> isNodeWrapping [

	^ self itemBar isNodeWrapping
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> isUniformNodeHeight [

	^ self itemBar isUniformNodeHeight
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> isUniformNodeWidth [

	^ self itemBar isUniformNodeWidth
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> itemBar [

	^ itemBar
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

	anItem barOwner: self  
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> onAddedItem: anItem [

	self onAddedAnyItemKind: anItem.
	anItem onAddedInItemListHolder: self.

]

{ #category : #'t - item list holder - double dispatch' }
TToItemBarOwner >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item list holder - double dispatch' }
TToItemBarOwner >> onRemovedAnyItemKind: anItem [

	anItem barOwner: nil  
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

	^ self itemBar primarySelectionMode
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> removeAllItems [

	itemBar removeAllItems
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> removeAllItems: aCollection [

	itemBar removeAllItems: aCollection
]

{ #category : #'t - item list holder - adding/removing' }
TToItemBarOwner >> removeItem: anItem [

	self onRemovedItem: anItem.
	itemBar removeItem: anItem
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

	self selectableAtPosition: anItem positionInBar
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> selectionModel [

	^ self itemBar selectionModel
]

{ #category : #'t - item list holder - accessing' }
TToItemBarOwner >> selectionOption [

	^ self itemBar selectionOption
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

	self unselectableAtPosition: anItem positionInBar
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemBarOwner >> visibleAtPosition: anInteger [

	self itemList visibleAtPosition: anInteger
]

{ #category : #'t - item list holder - hidden/visible' }
TToItemBarOwner >> visibleItem: anItem [

	self visibleAtPosition: anItem positionInBar
]
