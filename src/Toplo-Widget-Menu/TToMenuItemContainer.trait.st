Trait {
	#name : #TToMenuItemContainer,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> addItem: aMenuItem [

	self items add: aMenuItem.
	aMenuItem  addedInMenu: self
]

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item container - testing' }
TToMenuItemContainer >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - menu item container - accessing' }
TToMenuItemContainer >> items [

	^ self explicitRequirement 
]

{ #category : #'t - menu item container - adding/removing' }
TToMenuItemContainer >> removeItem: aMenuItem [

	self items remove: aMenuItem
]
