Trait {
	#name : #TToMenuItemListHolder,
	#category : #'Toplo-Widget-Menu-Items'
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
	self itemList unselectableSelecter selectIndex: aMenuItem positionInItemList
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	self itemList unselectableSelecter selectIndex: aFiller positionInItemList
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedMenu: aMenu [

	aMenu parentItemListHolder: self.
	aMenu isSubmenu: true
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedMenuBar: aMenuBar [

	self onAddedMenuItem: aMenuBar.
	aMenuBar configureLayout.
	self itemList unselectableSelecter selectIndex:
		aMenuBar positionInItemList
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedMenuItem: aMenuItem [

	aMenuItem parentItemListHolder: self
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	self itemList unselectableSelecter selectIndex: aMenuItem positionInItemList
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onRemovedCustomMenuItem: aMenuItem [

	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemList unselectableSelecter deselectIndex: aMenuItem positionInItemList.
	self onRemovedMenuItem: aMenuItem.

]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onRemovedFillerMenuItem: aFiller [

	self itemList unselectableSelecter deselectIndex: aFiller positionInItemList.
	self onRemovedMenuItem: aFiller.

]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onRemovedMenu: aMenu [

	aMenu parentItemListHolder: nil.
	aMenu isSubmenu: false
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onRemovedMenuBar: aMenuBar [

	self itemList unselectableSelecter deselectIndex:
		aMenuBar positionInItemList.
	aMenuBar configureLayout.
	self onRemovedMenuItem: aMenuBar.

]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onRemovedMenuItem: aMenuItem [

	aMenuItem parentItemListHolder: nil
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemListHolder >> onRemovedSeparatorMenuItem: aMenuItem [

	self itemList unselectableSelecter deselectIndex: aMenuItem positionInItemList.
	self onRemovedMenuItem: aMenuItem.

]
