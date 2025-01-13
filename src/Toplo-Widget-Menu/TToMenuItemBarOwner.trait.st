Trait {
	#name : #TToMenuItemBarOwner,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item list holder - adding/removing' }
TToMenuItemBarOwner >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item list holder - adding/removing' }
TToMenuItemBarOwner >> closeAllWindowsForItemsSatisfying: aBlock [

	self items do: [ :it |
		(aBlock value: it) ifTrue: [ it menuWindowDo: [ :w | w close ] ] ]
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemBar unselectableSelecter selectIndex:
		aMenuItem positionInItemList
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	self itemBar unselectableSelecter selectIndex:
		aFiller positionInItemList
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onAddedMenu: aMenu [

	aMenu isSubmenu: true.
	aMenu closeOnPicking: false
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onAddedMenuBar: aMenuBar [

	self onAddedMenuItem: aMenuBar.
	aMenuBar configureLayout.
	self itemBar unselectableSelecter selectIndex:
		aMenuBar positionInItemList
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onAddedMenuItem: aMenuItem [
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	self itemBar unselectableSelecter selectIndex:
		aMenuItem positionInItemList
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onRemovedCustomMenuItem: aMenuItem [

	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemBar unselectableSelecter deselectIndex:
		aMenuItem positionInItemList.
	self onRemovedMenuItem: aMenuItem
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onRemovedFillerMenuItem: aFiller [

	self itemList unselectableSelecter deselectIndex: aFiller positionInItemList.
	self onRemovedMenuItem: aFiller.

]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onRemovedMenu: aMenu [

	aMenu isSubmenu: false
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onRemovedMenuBar: aMenuBar [

	self itemList unselectableSelecter deselectIndex:
		aMenuBar positionInItemList.
	aMenuBar configureLayout.
	self onRemovedMenuItem: aMenuBar.

]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onRemovedMenuItem: aMenuItem [

]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarOwner >> onRemovedSeparatorMenuItem: aMenuItem [

	self itemBar unselectableSelecter deselectIndex:
		aMenuItem positionInItemList.
	self onRemovedMenuItem: aMenuItem
]
