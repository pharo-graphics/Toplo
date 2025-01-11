Trait {
	#name : #TToItemBar,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> addItem: anItem [

	self items add: anItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> addItem: anItem after: anotherItem [

	self items add: anItem after: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> addItem: anItem afterIndex: anInteger [

	self items add: anItem afterIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> addItem: anItem before: anotherItem [

	self items add: anItem before: anotherItem.
	self onAddedItem: anItem
]

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> addItem: anItem beforeIndex: anInteger [

	self items add: anItem beforeIndex: anInteger.
	self onAddedItem: anItem
]

{ #category : #'t - item bar - enable/disable' }
TToItemBar >> disabledItem: anItem [

	self disabledAtPosition: anItem positionInBar
]

{ #category : #'t - item bar - enable/disable' }
TToItemBar >> enabledItem: anItem [

	self enabledAtPosition: anItem positionInBar
]

{ #category : #'t - item bar - hidden/visible' }
TToItemBar >> hiddenItem: anItem [

	self hiddenAtPosition: anItem positionInBar
]

{ #category : #'t - item bar - testing' }
TToItemBar >> isItemContainer [

	^ true
]

{ #category : #'t - item bar - accessing' }
TToItemBar >> items [

	^ self dataAccessor
]

{ #category : #'t - item bar - double dispatch' }
TToItemBar >> onAddedAnyItemKind: anItem [

	anItem bar: self
]

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> onAddedItem: anItem [

	anItem onAddedInItemBar: self.
	self onAddedAnyItemKind: anItem.

]

{ #category : #'t - item bar - double dispatch' }
TToItemBar >> onAddedUnknownItemKind: anItem [


]

{ #category : #'t - item bar - double dispatch' }
TToItemBar >> onRemovedAnyItemKind: anItem [

		anItem bar: nil
]

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> onRemovedItem: anItem [

	self onRemovedAnyItemKind: anItem.
	anItem onRemovedFromItemBar: self
]

{ #category : #'t - item bar - double dispatch' }
TToItemBar >> onRemovedUnknownItemKind: anItem [


]

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> removeAllItems [

	self removeAllItems: self items asArray
]

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> removeAllItems: aCollection [

	aCollection do: [ :item | self removeItem: item ]
]

{ #category : #'t - item bar - adding/removing' }
TToItemBar >> removeItem: anItem [

	self onRemovedItem: anItem.
	self items remove: anItem
]

{ #category : #'t - item bar - selectable/unselectable' }
TToItemBar >> selectableItem: anItem [

	self selectableAtPosition: anItem positionInBar
]

{ #category : #'t - item bar - selectable/unselectable' }
TToItemBar >> unselectableItem: anItem [

	self unselectableAtPosition: anItem positionInBar
]

{ #category : #'t - item bar - hidden/visible' }
TToItemBar >> visibleItem: anItem [

	self visibleAtPosition: anItem positionInBar
]
