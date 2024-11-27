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
	aMenuItem addedInMenuItemContainer: self
]

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedCustomMenuItem: aMenuItem [

	self addedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemList unselectableSelecter selectIndex: aMenuItem positionInItemContainer
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedFillerMenuItem: aFiller [

	self addedMenuItem: aFiller.
	self itemList unselectableSelecter selectIndex: aFiller positionInItemContainer
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedMenu: aMenu [

	aMenu parentItemContainer: self.
	aMenu isSubmenu: true
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedMenuBar: aMenuBar [

	self addedMenuItem: aMenuBar.
	self itemList unselectableSelecter selectIndex: aMenuBar positionInItemContainer
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedMenuItem: aMenuItem [

	aMenuItem parentItemContainer: self
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedSeparatorMenuItem: aMenuItem [

	self addedMenuItem: aMenuItem.
	self itemList unselectableSelecter selectIndex: aMenuItem positionInItemContainer
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> addedUnknownItemKind: anItem [
]

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> closeAllWindowsForItemsSatisfying: aBlock [

	self items do: [ :it |
		(aBlock value: it) ifTrue: [ it menuWindowDo: [ :w | w close ] ] ]
]

{ #category : #'t - menu item container - testing' }
TToMenuItemContainer >> hasItems [ 

	^ self items notEmpty
]

{ #category : #testing }
TToMenuItemContainer >> isMenuItemContainer [

	^ true
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
