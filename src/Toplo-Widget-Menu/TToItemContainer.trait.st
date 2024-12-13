Trait {
	#name : #TToItemContainer,
	#instVars : [
		'itemList'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - item container - adding/removing' }
TToItemContainer >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - item container - adding/removing' }
TToItemContainer >> addItem: aMenuItem [

	self items add: aMenuItem.
	aMenuItem onAddedInItemContainer: self
]

{ #category : #'t - item container - enable/disable' }
TToItemContainer >> disableAtPosition: anInteger [

	self itemList disableAtPosition: anInteger
]

{ #category : #'t - item container - enable/disable' }
TToItemContainer >> disableItem: anItem [

	self disableAtPosition: anItem positionInItemContainer
]

{ #category : #'t - item container - enable/disable' }
TToItemContainer >> enableAtPosition: anInteger [

	self itemList enableAtPosition: anInteger
]

{ #category : #'t - item container - enable/disable' }
TToItemContainer >> enableItem: anItem [

	self enableAtPosition: anItem positionInItemContainer
]

{ #category : #'t - item container - testing' }
TToItemContainer >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - item container - testing' }
TToItemContainer >> isItemContainer [

	^ true
]

{ #category : #'t - item container - accessing' }
TToItemContainer >> itemList [

	^ itemList ifNil: [ itemList := ToMenuItemListElement new ]
]

{ #category : #'t - item container - accessing' }
TToItemContainer >> items [

	^ self itemList dataAccessor
]

{ #category : #'t - item container - double dispatch' }
TToItemContainer >> onAddedUnknownItemKind: anItem [
]

{ #category : #'t - item container - adding/removing' }
TToItemContainer >> removeItem: aMenuItem [

	self items remove: aMenuItem
]
