Trait {
	#name : #TToMenuItemListOwner,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item list owner - adding/removing' }
TToMenuItemListOwner >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item list owner - adding/removing' }
TToMenuItemListOwner >> closeAllWindowsForItemsSatisfying: aBlock [

	self items do: [ :it |
		(aBlock value: it) ifTrue: [ it menuWindowDo: [ :w | w close ] ] ]
]

{ #category : #'t - menu item list owner  - initialization' }
TToMenuItemListOwner >> initializeAsMenuItemListOwner [ 

	self itemBar menuBarOwner: self
]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	aMenuItem unselectable: true
]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	aFiller unselectable: true
]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onAddedMenu: aMenu [


]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onAddedMenuItem: aMenuItem [
]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onAddedMenuPane: aMenuPane [

	self onAddedMenuItem: aMenuPane.
	aMenuPane isSubPane: true.
	aMenuPane configureLayout.
	aMenuPane unselectable: true
]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem unselectable: true
]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onRemovedCustomMenuItem: aMenuItem [

	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemBar unselectableSelecter deselectIndex:
		aMenuItem positionInList.
	self onRemovedMenuItem: aMenuItem
]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onRemovedFillerMenuItem: aFiller [

	self itemList unselectableSelecter deselectIndex: aFiller positionInBar.
	self onRemovedMenuItem: aFiller.

]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onRemovedMenu: aMenu [


]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onRemovedMenuItem: aMenuItem [

]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onRemovedMenuPane: aMenuPane [

	self itemList unselectableSelecter deselectIndex:
		aMenuPane positionInBar.
	aMenuPane isSubPane: false.
	aMenuPane configureLayout.
	self onRemovedMenuItem: aMenuPane

]

{ #category : #'t - menu item list owner - double dispatch' }
TToMenuItemListOwner >> onRemovedSeparatorMenuItem: aMenuItem [

	self itemBar unselectableSelecter deselectIndex:
		aMenuItem positionInBar.
	self onRemovedMenuItem: aMenuItem
]
