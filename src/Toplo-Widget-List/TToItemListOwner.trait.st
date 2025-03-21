Trait {
	#name : #TToItemListOwner,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> addAllItems: aCollection [

	self itemBar addAllItems: aCollection
]

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> addItem: anItem [

	self itemBar addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> addItem: anItem after: anotherItem [

	self itemBar addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> addItem: anItem afterIndex: anInteger [

	self itemBar addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> addItem: anItem before: anotherItem [

	self itemBar addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> addItem: anItem beforeIndex: anInteger [

	self itemBar addItem: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> autoDistribute [

	^ self itemBar autoDistribute
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> autoDistribute: aBoolean [

	self itemBar autoDistribute = aBoolean ifTrue: [ ^ self ].
	self itemBar autoDistribute: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> dataAccessor [

	^ self itemBar dataAccessor
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> dataSource [

	^ self itemBar dataSource
]

{ #category : #'t - item list owner - hidden/visible' }
TToItemListOwner >> deselectedAtPosition: anInteger [

	self itemBar deselectedAtPosition: anInteger
]

{ #category : #'t - item list owner - disable/ enable' }
TToItemListOwner >> disableItem: anItem [

	self
		deprecated: 'Use #disabledItem: instead'
		transformWith:
		'`@rcvr disableItem: `@arg1' -> '`@rcvr disabledItem: `@arg1'.

	self disabledItem: anItem
]

{ #category : #'t - item list owner - disable/ enable' }
TToItemListOwner >> disabledAtPosition: anInteger [

	self itemBar disabledAtPosition: anInteger
]

{ #category : #'t - item list owner - disable/ enable' }
TToItemListOwner >> disabledItem: anItem [

	self itemBar disabledItem: anItem
]

{ #category : #'t - item list owner - disable/ enable' }
TToItemListOwner >> enableItem: anItem [

	self
		deprecated: 'Use #enabledItem: instead'
		transformWith:
		'`@rcvr enableItem: `@arg1' -> '`@rcvr enabledItem: `@arg1'.

	self enabledItem: anItem
]

{ #category : #'t - item list owner - disable/ enable' }
TToItemListOwner >> enabledAtPosition: anInteger [

	self itemBar enabledAtPosition: anInteger
]

{ #category : #'t - item list owner - disable/ enable' }
TToItemListOwner >> enabledItem: anItem [

	self itemBar enabledItem: anItem
]

{ #category : #'t - item list owner - testing' }
TToItemListOwner >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item list owner - hidden/visible' }
TToItemListOwner >> hiddenAtPosition: anInteger [

	self itemBar hiddenAtPosition: anInteger
]

{ #category : #'t - item list owner - hidden/visible' }
TToItemListOwner >> hiddenItem: anItem [

	self itemBar hiddenItem: anItem
]

{ #category : #'t - item list owner - initializing' }
TToItemListOwner >> initializeAsItemBarOwner [

	| bar |
	bar := self newItemBar.
	self userData at: #itemBar put: bar
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> innerElement [

	^ self itemBar innerElement
]

{ #category : #'t - item list owner - testing' }
TToItemListOwner >> isItemContainer [

	^ true
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> isScrolling [

	^ self itemBar isScrolling
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> isScrolling: aBoolean [

	self itemBar isScrolling = aBoolean ifTrue: [ ^ self ].
	self itemBar isScrolling: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> isWrapping [

	^ self itemBar isWrapping
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> isWrapping: aBoolean [

	self itemBar isWrapping = aBoolean ifTrue: [ ^ self ].
	self itemBar isWrapping: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> itemBar [

	^ self userData at: #itemBar ifAbsent: [  ]
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> itemList [

	self
		deprecated: 'Use itemBar instead'
		transformWith: '`@rcvr itemList' -> '`@rcvr itemBar'.

	^ self itemBar
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> items [

	^ self itemBar dataAccessor
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> newItemBar [

	^ ToItemBarElement new
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> nodesDo: aValuable [

	self itemBar nodesDo: aValuable
]

{ #category : #'t - item list owner - double dispatch' }
TToItemListOwner >> onAddedAnyItemKind: anItem [


]

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> onAddedItem: anItem [

	self onAddedAnyItemKind: anItem.
	anItem onAddedInItemBarOwner: self.

]

{ #category : #'t - item list owner - double dispatch' }
TToItemListOwner >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item list owner - double dispatch' }
TToItemListOwner >> onRemovedAnyItemKind: anItem [


]

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemBarOwner: self
]

{ #category : #'t - item list owner - double dispatch' }
TToItemListOwner >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> primarySelectionMode [

	^ self itemBar primarySelectionMode
]

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> removeAllItems [

	self itemBar removeAllItems
]

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> removeAllItems: aCollection [

	self itemBar removeAllItems: aCollection
]

{ #category : #'t - item list owner - adding/removing' }
TToItemListOwner >> removeItem: anItem [

	self onRemovedItem: anItem.
	self itemBar removeItem: anItem
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> secondarySelecter [

	^ self itemBar secondarySelecter
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> secondarySelectionMode [

	^ self itemBar secondarySelectionMode
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> secondarySelectionOption [

	^ self itemBar secondarySelectionOption
]

{ #category : #'t - item list owner - unselectable/selectable' }
TToItemListOwner >> selectableAtPosition: anInteger [

	self itemBar selectableAtPosition: anInteger
]

{ #category : #'t - item list owner - unselectable/selectable' }
TToItemListOwner >> selectableItem: anItem [

	self itemBar selectableItem: anItem
]

{ #category : #'t - item list owner - hidden/visible' }
TToItemListOwner >> selectedAtPosition: anInteger [

	self itemBar selectedAtPosition: anInteger
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> selecter [

	^ self itemBar selecter
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> selectionMode [

	^ self itemBar selectionMode
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> selectionModel [

	^ self itemBar selectionModel
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> selectionOption [

	^ self itemBar selectionOption
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> uniformNodeHeight [

	^ self itemBar uniformNodeHeight
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> uniformNodeHeight: aBoolean [

	self itemBar uniformNodeHeight: aBoolean
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> uniformNodeWidth [

	^ self itemBar uniformNodeWidth
]

{ #category : #'t - item list owner - accessing' }
TToItemListOwner >> uniformNodeWidth: aBoolean [

	self itemBar uniformNodeWidth: aBoolean
]

{ #category : #'t - item list owner - unselectable/selectable' }
TToItemListOwner >> unselectableAtPosition: anInteger [

	self itemBar unselectableAtPosition: anInteger
]

{ #category : #'t - item list owner - unselectable/selectable' }
TToItemListOwner >> unselectableItem: anItem [

	self itemBar unselectableItem: anItem
]

{ #category : #'t - item list owner - hidden/visible' }
TToItemListOwner >> visibleAtPosition: anInteger [

	self itemBar visibleAtPosition: anInteger
]

{ #category : #'t - item list owner - hidden/visible' }
TToItemListOwner >> visibleItem: anItem [

	self itemBar visibleItem: anItem
]
