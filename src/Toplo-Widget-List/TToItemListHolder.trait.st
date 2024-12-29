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
	anItem onAddedInItemListHolder: self
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> addItem: anItem after: anotherItem [

	self items add: anItem after: anotherItem.
	anItem onAddedInItemListHolder: self
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> addItem: anItem afterIndex: anInteger [

	self items add: anItem afterIndex: anInteger.
	anItem onAddedInItemListHolder: self
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> addItem: anItem before: anotherItem [

	self items add: anItem before: anotherItem.
	anItem onAddedInItemListHolder: self
]

{ #category : #'t - item list holder - adding/removing' }
TToItemListHolder >> addItem: anItem beforeIndex: anInteger [

	self items add: anItem beforeIndex: anInteger.
	anItem onAddedInItemListHolder: self
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
TToItemListHolder >> disableAtPosition: anInteger [

	self itemList disableAtPosition: anInteger
]

{ #category : #'t - item list holder - enable/disable' }
TToItemListHolder >> disableItem: anItem [

	self disableAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - enable/disable' }
TToItemListHolder >> enableAtPosition: anInteger [

	self itemList enableAtPosition: anInteger
]

{ #category : #'t - item list holder - enable/disable' }
TToItemListHolder >> enableItem: anItem [

	self enableAtPosition: anItem positionInItemList
]

{ #category : #'t - item list holder - testing' }
TToItemListHolder >> hasItems [ 

	^ self items notEmpty
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
TToItemListHolder >> onAddedUnknownItemKind: anItem [
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

	anItem onRemovedFromItemListHolder: self.
	self items remove: anItem
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> secondarySelectionMode [

	^ self itemList secondarySelectionMode
]

{ #category : #'t - item list holder - accessing' }
TToItemListHolder >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
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
