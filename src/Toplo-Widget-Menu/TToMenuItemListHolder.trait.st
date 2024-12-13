Trait {
	#name : #TToMenuItemListHolder,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu item list holder - adding/removing' }
TToMenuItemListHolder >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item list holder - adding/removing' }
TToMenuItemListHolder >> closeAllWindowsForItemsSatisfying: aBlock [

	self items do: [ :it |
		(aBlock value: it) ifTrue: [ it menuWindowDo: [ :w | w close ] ] ]
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemList unselectableSelecter selectIndex: aMenuItem positionInItemContainer
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	self itemList unselectableSelecter selectIndex: aFiller positionInItemContainer
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedMenu: aMenu [

	aMenu parentItemContainer: self.
	aMenu isSubmenu: true
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedMenuBar: aMenuBar [

	self onAddedMenuItem: aMenuBar.
	self itemList unselectableSelecter selectIndex:
		aMenuBar positionInItemContainer
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedMenuItem: aMenuItem [

	aMenuItem parentItemContainer: self
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	self itemList unselectableSelecter selectIndex: aMenuItem positionInItemContainer
]
