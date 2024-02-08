Trait {
	#name : #TToMenuItemHolder,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> addItem: aMenuItem [

	self items add: aMenuItem.
	aMenuItem  addedInMenu: self
]

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item holder - testing' }
TToMenuItemHolder >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - menu item holder - accessing' }
TToMenuItemHolder >> items [

	^ self explicitRequirement 
]

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> removeItem: aMenuItem [

	self items remove: aMenuItem
]
