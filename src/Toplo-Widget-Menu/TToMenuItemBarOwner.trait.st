Trait {
	#name : #TToMenuItemBarOwner,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item bar owner - adding/removing' }
TToMenuItemBarOwner >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item bar owner - adding/removing' }
TToMenuItemBarOwner >> closeAllWindowsForItemsSatisfying: aBlock [

	self items do: [ :it |
		(aBlock value: it) ifTrue: [ it menuWindowDo: [ :w | w close ] ] ]
]

{ #category : #'t - menu item bar owner  - initialization' }
TToMenuItemBarOwner >> initializeAsMenuItemBarOwner [ 

	self itemBar menuBarOwner: self
]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	aMenuItem unselectable: true
]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	aFiller unselectable: true
]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onAddedMenu: aMenu [

	aMenu isSubmenu: true.
	aMenu closeOnPicking: false
]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onAddedMenuBar: aMenuBar [

	self onAddedMenuItem: aMenuBar.
	aMenuBar isSubBar: true.
	aMenuBar configureLayout.
	aMenuBar unselectable: true
]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onAddedMenuItem: aMenuItem [
]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem unselectable: true
]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onRemovedCustomMenuItem: aMenuItem [

	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemBar unselectableSelecter deselectIndex:
		aMenuItem positionInBar.
	self onRemovedMenuItem: aMenuItem
]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onRemovedFillerMenuItem: aFiller [

	self itemList unselectableSelecter deselectIndex: aFiller positionInBar.
	self onRemovedMenuItem: aFiller.

]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onRemovedMenu: aMenu [

	aMenu isSubmenu: false
]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onRemovedMenuBar: aMenuBar [

	self itemList unselectableSelecter deselectIndex:
		aMenuBar positionInBar.
	aMenuBar isSubBar: false.
	aMenuBar configureLayout.
	self onRemovedMenuItem: aMenuBar.

]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onRemovedMenuItem: aMenuItem [

]

{ #category : #'t - menu item bar owner - double dispatch' }
TToMenuItemBarOwner >> onRemovedSeparatorMenuItem: aMenuItem [

	self itemBar unselectableSelecter deselectIndex:
		aMenuItem positionInBar.
	self onRemovedMenuItem: aMenuItem
]
