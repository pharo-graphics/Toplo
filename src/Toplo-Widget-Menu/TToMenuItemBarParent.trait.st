Trait {
	#name : #TToMenuItemBarParent,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> closeAllWindowsForItemsSatisfying: aBlock [

	self items do: [ :it |
		(aBlock value: it) ifTrue: [ it menuWindowDo: [ :w | w close ] ] ]
]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onAddedCustomMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemList unselectableSelecter selectIndex: aMenuItem positionInParentBar
]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onAddedFillerMenuItem: aFiller [

	self onAddedMenuItem: aFiller.
	self itemList unselectableSelecter selectIndex: aFiller positionInParentBar
]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onAddedMenu: aMenu [

	aMenu isSubmenu: true.
	aMenu closeOnPicking: false
]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onAddedMenuBar: aMenuBar [

	self onAddedMenuItem: aMenuBar.
	aMenuBar configureLayout.
	self itemList unselectableSelecter selectIndex:
		aMenuBar positionInParentBar
]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onAddedMenuItem: aMenuItem [

]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onAddedSeparatorMenuItem: aMenuItem [

	self onAddedMenuItem: aMenuItem.
	self itemList unselectableSelecter selectIndex: aMenuItem positionInParentBar
]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onRemovedCustomMenuItem: aMenuItem [

	aMenuItem isSelectable ifTrue: [ ^ self ].
	self itemList unselectableSelecter deselectIndex: aMenuItem positionInParentBar.
	self onRemovedMenuItem: aMenuItem.

]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onRemovedFillerMenuItem: aFiller [

	self itemList unselectableSelecter deselectIndex: aFiller positionInParentBar.
	self onRemovedMenuItem: aFiller.

]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onRemovedMenu: aMenu [

	aMenu isSubmenu: false
]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onRemovedMenuBar: aMenuBar [

	self itemList unselectableSelecter deselectIndex:
		aMenuBar positionInParentBar.
	aMenuBar configureLayout.
	self onRemovedMenuItem: aMenuBar.

]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onRemovedMenuItem: aMenuItem [

]

{ #category : #'as yet unclassified' }
TToMenuItemBarParent >> onRemovedSeparatorMenuItem: aMenuItem [

	self itemList unselectableSelecter deselectIndex: aMenuItem positionInParentBar.
	self onRemovedMenuItem: aMenuItem.

]
