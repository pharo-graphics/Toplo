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

{ #category : #'t - menu item list user - testing' }
TToMenuItemListUser >> hasMenuItems [

	^ self items anySatisfy: [ :e |
		  e isMenuItem and: [ e isMenuPane not ] ]
]

{ #category : #'t - menu item list user - initializing' }
TToMenuItemListUser >> initializeAsMenuItemListUser [

	self itemList menuListOwner: self
]
