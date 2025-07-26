Trait {
	#name : #TToMenuItemBarContainer,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item bar container - adding/removing' }
TToMenuItemBarContainer >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item bar container - adding/removing' }
TToMenuItemBarContainer >> addSeparatorAfterIndex: anInteger [

	self addItem: ToSeparatorMenuItem new afterIndex: anInteger
]

{ #category : #'t - menu item bar container - adding/removing' }
TToMenuItemBarContainer >> addSeparatorBeforeIndex: anInteger [

	self addItem: ToSeparatorMenuItem new beforeIndex: anInteger
]

{ #category : #'t - menu item bar container - adding/removing' }
TToMenuItemBarContainer >> closeAllWindowsForItemsSatisfying: aBlock [

	self items do: [ :it |
		(aBlock value: it) ifTrue: [ it menuWindowDo: [ :w | w close ] ] ]
]

{ #category : #'t - menu item bar container  - initialization' }
TToMenuItemBarContainer >> initializeAsMenuItemListOwner [ 

	self itemBar menuBarOwner: self
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	aMenuItem unselectable: true
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	aFiller unselectable: true
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onAddedMenu: aMenu [


]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onAddedMenuItem: aMenuItem [
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onAddedMenuPane: aMenuPane [

	self onAddedMenuItem: aMenuPane.
	aMenuPane isSubPane: true.
	aMenuPane unselectable: true.
	self requestConfiguration.

]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem unselectable: true
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onRemovedCustomMenuItem: aMenuItem [

	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemBar unselectableSelecter deselectIndex:
		aMenuItem positionInList.
	self onRemovedMenuItem: aMenuItem
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onRemovedFillerMenuItem: aFiller [

	self itemList unselectableSelecter deselectIndex: aFiller positionInBar.
	self onRemovedMenuItem: aFiller.

]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onRemovedMenu: aMenu [


]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onRemovedMenuItem: aMenuItem [

]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onRemovedMenuPane: aMenuPane [

	self itemList unselectableSelecter deselectIndex:
		aMenuPane positionInBar.
	aMenuPane isSubPane: false.
	self onRemovedMenuItem: aMenuPane.
	self requestConfiguration.


]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemBarContainer >> onRemovedSeparatorMenuItem: aMenuItem [

	self itemBar unselectableSelecter deselectIndex:
		aMenuItem positionInBar.
	self onRemovedMenuItem: aMenuItem
]
