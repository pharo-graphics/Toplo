Trait {
	#name : #TToItemBarParent,
	#instVars : [
		'itemList'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item bar parent - adding/removing' }
TToItemBarParent >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - item bar parent - adding/removing' }
TToItemBarParent >> addItem: anItem [

	self itemList addItem: anItem
]

{ #category : #'t - item bar parent - adding/removing' }
TToItemBarParent >> addItem: anItem after: anotherItem [

	self itemList add: anItem after: anotherItem
]

{ #category : #'t - item bar parent - adding/removing' }
TToItemBarParent >> addItem: anItem afterIndex: anInteger [

	self itemList add: anItem afterIndex: anInteger
]

{ #category : #'t - item bar parent - adding/removing' }
TToItemBarParent >> addItem: anItem before: anotherItem [

	self itemList add: anItem before: anotherItem
]

{ #category : #'t - item bar parent - adding/removing' }
TToItemBarParent >> addItem: anItem beforeIndex: anInteger [

	self itemList add: anItem beforeIndex: anInteger
]

{ #category : #'t - item bar parent - initializing' }
TToItemBarParent >> configureLayout [

	self isHorizontal
		ifTrue: [ self itemList horizontal: true ]
		ifFalse: [ self itemList horizontal: false ]
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> dataAccessor [ 

	^ self itemList dataAccessor
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> dataSource [

	^ self itemList dataSource
]

{ #category : #'t - item bar parent - enable/disable' }
TToItemBarParent >> disableItem: anItem [

	self
		deprecated: 'Use #disabledItem: instead'
		transformWith:
		'`@rcvr disableItem: `@arg1' -> '`@rcvr disabledItem: `@arg1'.

	self disabledItem: anItem
]

{ #category : #'t - item bar parent - enable/disable' }
TToItemBarParent >> disabledAtPosition: anInteger [

	self itemList disabledAtPosition: anInteger
]

{ #category : #'t - item bar parent - enable/disable' }
TToItemBarParent >> disabledItem: anItem [

	self itemList disabledItem: anItem
]

{ #category : #'t - item bar parent - enable/disable' }
TToItemBarParent >> enableItem: anItem [

	self
		deprecated: 'Use #enabledItem: instead'
		transformWith:
		'`@rcvr enableItem: `@arg1' -> '`@rcvr enabledItem: `@arg1'.

	self enabledItem: anItem
]

{ #category : #'t - item bar parent - enable/disable' }
TToItemBarParent >> enabledAtPosition: anInteger [

	self itemList enabledAtPosition: anInteger
]

{ #category : #'t - item bar parent - enable/disable' }
TToItemBarParent >> enabledItem: anItem [

	self itemList enabledItem: anItem
]

{ #category : #'t - item bar parent - testing' }
TToItemBarParent >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item bar parent - hidden/visible' }
TToItemBarParent >> hiddenAtPosition: anInteger [

	self itemList hiddenAtPosition: anInteger
]

{ #category : #'t - item bar parent - hidden/visible' }
TToItemBarParent >> hiddenItem: anItem [

	self itemList hiddenItem: anItem
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> innerElement [

	^ self itemList innerElement
]

{ #category : #'t - item bar parent - testing' }
TToItemBarParent >> isItemContainer [

	^ true
]

{ #category : #'t - item bar parent - testing' }
TToItemBarParent >> isNodeAutoDistribution [

	^ self itemList isNodeAutoDistribution
]

{ #category : #'t - item bar parent - testing' }
TToItemBarParent >> isNodeScrolling [

	^ self itemList isNodeScrolling
]

{ #category : #'t - item bar parent - testing' }
TToItemBarParent >> isNodeWrapping [

	^ self itemList isNodeWrapping
]

{ #category : #'t - item bar parent - testing' }
TToItemBarParent >> isUniformNodeHeight [

	^ self itemList isUniformNodeHeight
]

{ #category : #'t - item bar parent - testing' }
TToItemBarParent >> isUniformNodeWidth [

	^ self itemList isUniformNodeWidth
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> itemList [

	^ itemList ifNil: [ itemList := self newItemList ]
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> items [

	^ self itemList dataAccessor
]

{ #category : #'t - item bar parent - initializing' }
TToItemBarParent >> newItemList [

	^ ToItemBarElement new
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> nodeAutoDistribution: aBoolean [

	self itemList nodeAutoDistribution: aBoolean.
	self configureLayout
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> nodeScrolling: aBoolean [

	self itemList nodeScrolling: aBoolean.
	self configureLayout
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> nodeWrapping: aBoolean [

	self itemList nodeWrapping: aBoolean.
	self configureLayout
]

{ #category : #'t - item bar parent - double dispatch' }
TToItemBarParent >> onAddedAnyItemKind: anItem [

	anItem barParent: self
]

{ #category : #'t - item bar parent - double dispatch' }
TToItemBarParent >> onAddedItem: anItem [

	anItem onAddedInItemBar: self.
	self onAddedAnyItemKind: anItem.

]

{ #category : #'t - item bar parent - double dispatch' }
TToItemBarParent >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item bar parent - double dispatch' }
TToItemBarParent >> onRemovedAnyItemKind: anItem [

		anItem barParent: nil
]

{ #category : #'t - item bar parent - double dispatch' }
TToItemBarParent >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemBar: self
]

{ #category : #'t - item bar parent - double dispatch' }
TToItemBarParent >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> primarySelectionMode [

	^ self itemList primarySelectionMode
]

{ #category : #'t - item bar parent - adding/removing' }
TToItemBarParent >> removeAllItems [

	self removeAllItems: self items asArray
]

{ #category : #'t - item bar parent - adding/removing' }
TToItemBarParent >> removeAllItems: aCollection [

	aCollection do: [ :item | self removeItem: item ]
]

{ #category : #'t - item bar parent - adding/removing' }
TToItemBarParent >> removeItem: anItem [

	self itemList remove: anItem
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> secondarySelecter [

	^ itemList secondarySelecter
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> secondarySelectionMode [

	^ self itemList secondarySelectionMode
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item bar parent - selectable/unselectable' }
TToItemBarParent >> selectableAtPosition: anInteger [

	self itemList selectableAtPosition: anInteger
]

{ #category : #'t - item bar parent - selectable/unselectable' }
TToItemBarParent >> selectableItem: anItem [

	self itemList selectableItem: anItem
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> selectionModel [

	^ self itemList selectionModel
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> selectionOption [

	^ self itemList selectionOption
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> uniformNodeHeight: aBoolean [

	self itemList uniformNodeHeight: aBoolean.
	self configureLayout
]

{ #category : #'t - item bar parent - accessing' }
TToItemBarParent >> uniformNodeWidth: aBoolean [

	self itemList uniformNodeWidth: aBoolean.
	self configureLayout
]

{ #category : #'t - item bar parent - selectable/unselectable' }
TToItemBarParent >> unselectableAtPosition: anInteger [

	self itemList unselectableAtPosition: anInteger
]

{ #category : #'t - item bar parent - selectable/unselectable' }
TToItemBarParent >> unselectableItem: anItem [

	self itemList unselectableItem: anItem
]

{ #category : #'t - item bar parent - hidden/visible' }
TToItemBarParent >> visibleAtPosition: anInteger [

	self itemList visibleAtPosition: anInteger
]

{ #category : #'t - item bar parent - hidden/visible' }
TToItemBarParent >> visibleItem: anItem [

	self itemList visibleItem: anItem
]
