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
	aMenuItem onAddedInMenuItemContainer: self
]

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> addSeparator [

	self addItem: ToSeparatorMenuItem new
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

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemList unselectableSelecter selectIndex: aMenuItem positionInItemContainer
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	self itemList unselectableSelecter selectIndex: aFiller positionInItemContainer
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> onAddedMenu: aMenu [

	aMenu parentItemContainer: self.
	aMenu isSubmenu: true
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> onAddedMenuBar: aMenuBar [

	self onAddedMenuItem: aMenuBar.
	self itemList unselectableSelecter selectIndex:
		aMenuBar positionInItemContainer
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> onAddedMenuItem: aMenuItem [

	aMenuItem parentItemContainer: self
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	self itemList unselectableSelecter selectIndex: aMenuItem positionInItemContainer
]

{ #category : #'t - menu item container - double dispatch' }
TToMenuItemContainer >> onAddedUnknownItemKind: anItem [
]

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> removeItem: aMenuItem [

	self items remove: aMenuItem
]
