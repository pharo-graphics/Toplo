Trait {
	#name : #TToMenuItemBar,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item bar - adding/removing' }
TToMenuItemBar >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item bar - adding/removing' }
TToMenuItemBar >> closeAllWindowsForItemsSatisfying: aBlock [

	self items do: [ :it |
		(aBlock value: it) ifTrue: [ it menuWindowDo: [ :w | w close ] ] ]
]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	self unselectableItem: aMenuItem 
]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	self unselectableItem: aFiller
]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onAddedMenu: aMenu [

	aMenu isSubmenu: true.
	aMenu closeOnPicking: false
]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onAddedMenuBar: aMenuBar [

	self onAddedMenuItem: aMenuBar.
	aMenuBar configureLayout.
	self unselectableItem: aMenuBar
]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onAddedMenuItem: aMenuItem [

]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	self unselectableItem: aMenuItem
]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onRemovedCustomMenuItem: aMenuItem [

	aMenuItem isSelectable ifTrue: [ ^ self ].
	self unselectableItem: aMenuItem.
	self onRemovedMenuItem: aMenuItem.

]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onRemovedFillerMenuItem: aFiller [

	self unselectableItem: aFiller.
	self onRemovedMenuItem: aFiller.

]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onRemovedMenu: aMenu [

	aMenu isSubmenu: false
]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onRemovedMenuBar: aMenuBar [

	self unselectableItem: aMenuBar.
	aMenuBar configureLayout.
	self onRemovedMenuItem: aMenuBar
]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onRemovedMenuItem: aMenuItem [

]

{ #category : #'t - menu item bar - double dispatch' }
TToMenuItemBar >> onRemovedSeparatorMenuItem: aMenuItem [

	self unselectableItem: aMenuItem.
	self onRemovedMenuItem: aMenuItem.

]
