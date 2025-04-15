Trait {
	#name : #TToItemBarOwner,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addAllItems: aCollection [

	self itemBar addAllItems: aCollection
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addItem: anItem [

	self itemBar addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addItem: anItem after: anotherItem [

	self itemBar addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addItem: anItem afterIndex: anInteger [

	self itemBar addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addItem: anItem before: anotherItem [

	self itemBar addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> addItem: anItem beforeIndex: anInteger [

	self itemBar addItem: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> autoDistribute [

	^ self itemBar autoDistribute
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> autoDistribute: aBoolean [

	self itemBar autoDistribute = aBoolean ifTrue: [ ^ self ].
	self itemBar autoDistribute: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> dataAccessor [

	^ self itemBar dataAccessor
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> dataSource [

	^ self itemBar dataSource
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarOwner >> deselectedAtPosition: anInteger [

	self itemBar deselectedAtPosition: anInteger
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

	self itemBar disabledAtPosition: anInteger
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarOwner >> disabledItem: anItem [

	self itemBar disabledItem: anItem
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

	self itemBar enabledAtPosition: anInteger
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarOwner >> enabledItem: anItem [

	self itemBar enabledItem: anItem
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> exactNodeHeight: aNumberOrNil [

	self itemBar exactNodeHeight = aNumberOrNil ifTrue: [ ^ self ].
	self itemBar exactNodeHeight: aNumberOrNil.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> exactNodeWidth: aNumberOrNil [

	self itemBar exactNodeWidth = aNumberOrNil ifTrue: [ ^ self ].
	self itemBar exactNodeWidth: aNumberOrNil.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - testing' }
TToItemBarOwner >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarOwner >> hiddenAtPosition: anInteger [

	self itemBar hiddenAtPosition: anInteger
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarOwner >> hiddenItem: anItem [

	self itemBar hiddenItem: anItem
]

{ #category : #'t - item bar owner - initializing' }
TToItemBarOwner >> initializeAsItemBarOwner [

	| bar |
	bar := self newItemBar.
	self userData at: #itemBar put: bar
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
TToItemBarOwner >> isScrolling [

	^ self itemBar isScrolling
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> isScrolling: aBoolean [

	self itemBar isScrolling = aBoolean ifTrue: [ ^ self ].
	self itemBar isScrolling: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> isWrapping [

	^ self itemBar isWrapping
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> isWrapping: aBoolean [

	self itemBar isWrapping = aBoolean ifTrue: [ ^ self ].
	self itemBar isWrapping: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> itemBar [

	^ self userData at: #itemBar ifAbsent: [  ]
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
TToItemBarOwner >> nodesDo: aValuable [

	self itemBar nodesDo: aValuable
]

{ #category : #'t - item bar owner - double dispatch' }
TToItemBarOwner >> onAddedAnyItemKind: anItem [


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

	self itemBar removeAllItems
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> removeAllItems: aCollection [

	self itemBar removeAllItems: aCollection
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarOwner >> removeItem: anItem [

	self onRemovedItem: anItem.
	self itemBar removeItem: anItem
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> secondarySelecter [

	^ self itemBar secondarySelecter
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> secondarySelectionMode [

	^ self itemBar secondarySelectionMode
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> secondarySelectionOption [

	^ self itemBar secondarySelectionOption
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarOwner >> selectableAtPosition: anInteger [

	self itemBar selectableAtPosition: anInteger
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarOwner >> selectableItem: anItem [

	self itemBar selectableItem: anItem
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarOwner >> selectedAtPosition: anInteger [

	self itemBar selectedAtPosition: anInteger
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> selecter [

	^ self itemBar selecter
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> selectionMode [

	^ self itemBar selectionMode
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
TToItemBarOwner >> uniformNodeHeight [

	^ self itemBar uniformNodeHeight
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> uniformNodeHeight: aBoolean [

	self itemBar uniformNodeHeight: aBoolean
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> uniformNodeWidth [

	^ self itemBar uniformNodeWidth
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarOwner >> uniformNodeWidth: aBoolean [

	self itemBar uniformNodeWidth: aBoolean
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarOwner >> unselectableAtPosition: anInteger [

	self itemBar unselectableAtPosition: anInteger
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarOwner >> unselectableItem: anItem [

	self itemBar unselectableItem: anItem
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarOwner >> visibleAtPosition: anInteger [

	self itemBar visibleAtPosition: anInteger
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarOwner >> visibleItem: anItem [

	self itemBar visibleItem: anItem
]

{ #category : #'t - item bar owner - initializing' }
TToItemBarOwner >> wrapItemBar: anItemBar [

	self userData at: #itemBar put: anItemBar
]
