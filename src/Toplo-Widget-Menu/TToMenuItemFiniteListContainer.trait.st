Trait {
	#name : #TToMenuItemFiniteListContainer,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item bar container - adding/removing' }
TToMenuItemFiniteListContainer >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item bar container - adding/removing' }
TToMenuItemFiniteListContainer >> addSeparatorAfterIndex: anInteger [

	self addItem: ToSeparatorMenuItem new afterIndex: anInteger
]

{ #category : #'t - menu item bar container - adding/removing' }
TToMenuItemFiniteListContainer >> addSeparatorBeforeIndex: anInteger [

	self addItem: ToSeparatorMenuItem new beforeIndex: anInteger
]

{ #category : #initialization }
TToMenuItemFiniteListContainer >> initializeAsMenuItemBarContainer [

	self itemBar menuBarOwner: self
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	aMenuItem unselectable: true
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	aFiller unselectable: true
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onAddedMenu: aMenu [


]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onAddedMenuItem: aMenuItem [
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onAddedMenuPane: aMenuPane [

	self onAddedMenuItem: aMenuPane.
	aMenuPane isSubPane: true.
	aMenuPane unselectable: true.
	self requestConfiguration.

]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem unselectable: true
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onRemovedCustomMenuItem: aMenuItem [

	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemBar unselectableSelecter deselectIndex:
		aMenuItem positionInList.
	self onRemovedMenuItem: aMenuItem
]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onRemovedFillerMenuItem: aFiller [

	self itemList unselectableSelecter deselectIndex: aFiller positionInBar.
	self onRemovedMenuItem: aFiller.

]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onRemovedMenu: aMenu [


]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onRemovedMenuItem: aMenuItem [

]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onRemovedMenuPane: aMenuPane [

	self itemList unselectableSelecter deselectIndex:
		aMenuPane positionInBar.
	aMenuPane isSubPane: false.
	self onRemovedMenuItem: aMenuPane.
	self requestConfiguration.


]

{ #category : #'t - menu item bar container - double dispatch' }
TToMenuItemFiniteListContainer >> onRemovedSeparatorMenuItem: aMenuItem [

	self itemBar unselectableSelecter deselectIndex:
		aMenuItem positionInBar.
	self onRemovedMenuItem: aMenuItem
]
