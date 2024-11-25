Trait {
	#name : #TToMenuItemContainer,
	#instVars : [
		'itemList'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> addItem: aMenuItem [

	self items add: aMenuItem.
	aMenuItem  addedInMenu: self
]

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedCustomMenuItem: aMenuItem [

	self addedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemList unselectableSelecter selectIndex: aMenuItem positionInMenu
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedMenuItem: aMenuItem [

	aMenuItem parentMenu: self
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedSeparatorMenuItem: aMenuItem [

	self addedMenuItem: aMenuItem.
	self itemList unselectableSelecter selectIndex: aMenuItem positionInMenu
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedUnknownItemKind: anItem [
]

{ #category : #'t - menu item container - testing' }
TToMenuItemContainer >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - menu item container - accessing' }
TToMenuItemContainer >> itemList [

	^ itemList ifNil: [ itemList := ToMenuItemListElement new ]
]

{ #category : #'t - menu item container - accessing' }
TToMenuItemContainer >> items [

	^ self itemList dataAccessor
]

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> removeItem: aMenuItem [

	self items remove: aMenuItem
]
