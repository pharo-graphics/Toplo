Trait {
	#name : #TToItemBarContainer,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> addAllItems: aCollection [

	self itemBar addAllItems: aCollection
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> addItem: anItem [

	self itemBar addItem: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> addItem: anItem after: anotherItem [

	self itemBar addItem: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> addItem: anItem afterIndex: anInteger [

	self itemBar addItem: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> addItem: anItem before: anotherItem [

	self itemBar addItem: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> addItem: anItem beforeIndex: anInteger [

	self itemBar addItem: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> autoDistribute [

	^ self itemBar autoDistribute
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> autoDistribute: aBoolean [

	self itemBar autoDistribute = aBoolean ifTrue: [ ^ self ].
	self itemBar autoDistribute: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> dataAccessor [

	^ self itemBar dataAccessor
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> dataSource [

	^ self itemBar dataSource
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarContainer >> deselectedAtPosition: anInteger [

	self itemBar deselectedAtPosition: anInteger
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarContainer >> disableItem: anItem [

	self
		deprecated: 'Use #disabledItem: instead'
		transformWith:
		'`@rcvr disableItem: `@arg1' -> '`@rcvr disabledItem: `@arg1'.

	self disabledItem: anItem
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarContainer >> disabledAtPosition: anInteger [

	self itemBar disabledAtPosition: anInteger
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarContainer >> disabledItem: anItem [

	self itemBar disabledItem: anItem
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarContainer >> enableItem: anItem [

	self
		deprecated: 'Use #enabledItem: instead'
		transformWith:
		'`@rcvr enableItem: `@arg1' -> '`@rcvr enabledItem: `@arg1'.

	self enabledItem: anItem
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarContainer >> enabledAtPosition: anInteger [

	self itemBar enabledAtPosition: anInteger
]

{ #category : #'t - item bar owner - disable/ enable' }
TToItemBarContainer >> enabledItem: anItem [

	self itemBar enabledItem: anItem
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> exactItemHeight: aNumberOrNil [

	self itemBar exactItemHeight = aNumberOrNil ifTrue: [ ^ self ].
	self itemBar exactItemHeight: aNumberOrNil.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> exactItemWidth: aNumberOrNil [

	self itemBar exactItemWidth = aNumberOrNil ifTrue: [ ^ self ].
	self itemBar exactItemWidth: aNumberOrNil.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> exactNodeHeight: aNumberOrNil [

	self itemBar exactNodeHeight = aNumberOrNil ifTrue: [ ^ self ].
	self itemBar exactNodeHeight: aNumberOrNil.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> exactNodeWidth: aNumberOrNil [

	self itemBar exactNodeWidth = aNumberOrNil ifTrue: [ ^ self ].
	self itemBar exactNodeWidth: aNumberOrNil.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - testing' }
TToItemBarContainer >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarContainer >> hiddenAtPosition: anInteger [

	self itemBar hiddenAtPosition: anInteger
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarContainer >> hiddenItem: anItem [

	self itemBar hiddenItem: anItem
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> innerElement [

	^ self itemBar innerElement
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> isFlowable [

	^ self itemBar isFlowable
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> isFlowable: aBoolean [

	self itemBar isFlowable = aBoolean ifTrue: [ ^ self ].
	self itemBar isFlowable: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - testing' }
TToItemBarContainer >> isItemContainer [

	^ true
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> isScrollable [

	^ self itemBar isScrollable
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> isScrollable: aBoolean [

	self itemBar isScrollable = aBoolean ifTrue: [ ^ self ].
	self itemBar isScrollable: aBoolean.
	self requestNewConfiguration
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> isScrolling [

	self
		deprecated: 'Use #isScrollable'
		transformWith: '`@r isScrolling' -> '`@r isScrollable'.
	^ self isScrollable
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> isScrolling: aBoolean [

	self
		deprecated: 'Use #isScrollable:'
		transformWith: '`@r isScrolling: `@a' -> '`@r isScrollable: `@a'.
	self isScrollable: aBoolean
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> isWrapping [

	self
		deprecated: 'Use #isFlowable'
		transformWith: '`@r isWrapping' -> '`@r isFlowable'.
	^ self isFlowable
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> isWrapping: aBoolean [

	self
		deprecated: 'Use #isFlowable:'
		transformWith: '`@r isWrapping: `@a' -> '`@r isFlowable: `@a'.
	self isFlowable: aBoolean
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> itemList [

	self
		deprecated: 'Use itemBar instead'
		transformWith: '`@rcvr itemList' -> '`@rcvr itemBar'.

	^ self itemBar
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> items [

	^ self itemBar dataAccessor
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> newItemBar [

	^ ToItemBarElement new
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> nodesDo: aValuable [

	self itemBar nodesDo: aValuable
]

{ #category : #'t - item bar owner - double dispatch' }
TToItemBarContainer >> onAddedAnyItemKind: anItem [


]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> onAddedItem: anItem [

	self onAddedAnyItemKind: anItem.
	anItem onAddedInItemBarOwner: self.

]

{ #category : #'t - item bar owner - double dispatch' }
TToItemBarContainer >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item bar owner - double dispatch' }
TToItemBarContainer >> onRemovedAnyItemKind: anItem [


]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemBarOwner: self
]

{ #category : #'t - item bar owner - double dispatch' }
TToItemBarContainer >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> primarySelectionMode [

	^ self itemBar primarySelectionMode
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> removeAllItems [

	self itemBar removeAllItems
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> removeAllItems: aCollection [

	self itemBar removeAllItems: aCollection
]

{ #category : #'t - item bar owner - adding/removing' }
TToItemBarContainer >> removeItem: anItem [

	self onRemovedItem: anItem.
	self itemBar removeItem: anItem
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> secondarySelecter [

	^ self itemBar secondarySelecter
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> secondarySelectionMode [

	^ self itemBar secondarySelectionMode
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> secondarySelectionModel [

	^ self itemList secondarySelectionModel
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> secondarySelectionOption [

	^ self itemBar secondarySelectionOption
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarContainer >> selectableAtPosition: anInteger [

	self itemBar selectableAtPosition: anInteger
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarContainer >> selectableItem: anItem [

	self itemBar selectableItem: anItem
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarContainer >> selectedAtPosition: anInteger [

	self itemBar selectedAtPosition: anInteger
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> selecter [

	^ self itemBar selecter
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> selectionMode [

	^ self itemBar selectionMode
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> selectionModel [

	^ self itemBar selectionModel
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> selectionOption [

	^ self itemBar selectionOption
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> uniformNodeHeight [

	^ self itemBar uniformNodeHeight
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> uniformNodeHeight: aBoolean [

	self itemBar uniformNodeHeight: aBoolean
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> uniformNodeWidth [

	^ self itemBar uniformNodeWidth
]

{ #category : #'t - item bar owner - accessing' }
TToItemBarContainer >> uniformNodeWidth: aBoolean [

	self itemBar uniformNodeWidth: aBoolean
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarContainer >> unselectableAtPosition: anInteger [

	self itemBar unselectableAtPosition: anInteger
]

{ #category : #'t - item bar owner - unselectable/selectable' }
TToItemBarContainer >> unselectableItem: anItem [

	self itemBar unselectableItem: anItem
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarContainer >> visibleAtPosition: anInteger [

	self itemBar visibleAtPosition: anInteger
]

{ #category : #'t - item bar owner - hidden/visible' }
TToItemBarContainer >> visibleItem: anItem [

	self itemBar visibleItem: anItem
]
