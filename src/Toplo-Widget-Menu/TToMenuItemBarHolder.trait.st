Trait {
	#name : #TToMenuItemBarHolder,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item list holder - adding/removing' }
TToMenuItemBarHolder >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item list holder - adding/removing' }
TToMenuItemBarHolder >> closeAllWindowsForItemsSatisfying: aBlock [

	self items do: [ :it |
		(aBlock value: it) ifTrue: [ it menuWindowDo: [ :w | w close ] ] ]
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemList unselectableSelecter selectIndex: aMenuItem positionInBar
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	self itemList unselectableSelecter selectIndex: aFiller positionInBar
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onAddedMenu: aMenu [

	aMenu barHolder: self.
	aMenu isSubmenu: true.
	aMenu closeOnPicking: false
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onAddedMenuBar: aMenuBar [

	self onAddedMenuItem: aMenuBar.
	aMenuBar configureLayout.
	self itemList unselectableSelecter selectIndex:
		aMenuBar positionInBar
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onAddedMenuItem: aMenuItem [

	aMenuItem barHolder: self
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	self itemList unselectableSelecter selectIndex: aMenuItem positionInBar
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onRemovedCustomMenuItem: aMenuItem [

	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemList unselectableSelecter deselectIndex: aMenuItem positionInBar.
	self onRemovedMenuItem: aMenuItem.

]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onRemovedFillerMenuItem: aFiller [

	self itemList unselectableSelecter deselectIndex: aFiller positionInBar.
	self onRemovedMenuItem: aFiller.

]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onRemovedMenu: aMenu [

	aMenu barHolder: nil.
	aMenu isSubmenu: false
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onRemovedMenuBar: aMenuBar [

	self itemList unselectableSelecter deselectIndex:
		aMenuBar positionInBar.
	aMenuBar configureLayout.
	self onRemovedMenuItem: aMenuBar.

]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onRemovedMenuItem: aMenuItem [

	aMenuItem barHolder: nil
]

{ #category : #'t - menu item list holder - double dispatch' }
TToMenuItemBarHolder >> onRemovedSeparatorMenuItem: aMenuItem [

	self itemList unselectableSelecter deselectIndex: aMenuItem positionInBar.
	self onRemovedMenuItem: aMenuItem.

]
