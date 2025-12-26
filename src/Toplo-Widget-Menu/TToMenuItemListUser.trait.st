Trait {
	#name : #TToMenuItemListUser,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item list user - adding/removing' }
TToMenuItemListUser >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item list user - adding/removing' }
TToMenuItemListUser >> addSeparatorAfterIndex: anInteger [

	self addItem: ToSeparatorMenuItem new afterIndex: anInteger
]

{ #category : #'t - menu item list user - adding/removing' }
TToMenuItemListUser >> addSeparatorBeforeIndex: anInteger [

	self addItem: ToSeparatorMenuItem new beforeIndex: anInteger
]

{ #category : #initialization }
TToMenuItemListUser >> initializeAsMenuItemBarContainer [

	self itemList menuListOwner: self
]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	aMenuItem unselectable: true
]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	aFiller unselectable: true
]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onAddedMenu: aMenu [


]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onAddedMenuItem: aMenuItem [
]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onAddedMenuPane: aMenuPane [

	self onAddedMenuItem: aMenuPane.
	aMenuPane isSubPane: true.
	aMenuPane unselectable: true.
	self requestConfiguration.

]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem unselectable: true
]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onRemovedCustomMenuItem: aMenuItem [

	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemList unselectableSelecter deselectIndex:
		aMenuItem positionInList.
	self onRemovedMenuItem: aMenuItem
]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onRemovedFillerMenuItem: aFiller [

	self itemList unselectableSelecter deselectIndex: aFiller positionInBar.
	self onRemovedMenuItem: aFiller.

]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onRemovedMenu: aMenu [


]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onRemovedMenuItem: aMenuItem [

]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onRemovedMenuPane: aMenuPane [

	self itemList unselectableSelecter deselectIndex:
		aMenuPane positionInBar.
	aMenuPane isSubPane: false.
	self onRemovedMenuItem: aMenuPane.
	self requestConfiguration.


]

{ #category : #'t - menu item list user - double dispatch' }
TToMenuItemListUser >> onRemovedSeparatorMenuItem: aMenuItem [

	self itemList unselectableSelecter deselectIndex:
		aMenuItem positionInBar.
	self onRemovedMenuItem: aMenuItem
]
