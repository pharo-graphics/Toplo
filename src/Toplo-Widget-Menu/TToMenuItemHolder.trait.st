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
	self associateWindow root addChild: aMenuItem.
	aMenuItem addedInMenu: self
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

	aMenuItem removedFromMenu: self.
	self items remove: aMenuItem.
	self window root removeChild: aMenuItem
]

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> removeItemAt: anIndex [

	| item |
	item := self items at: anIndex.
	self removeItem: item
]

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> replaceItemAt: anIndex with: anItem [

	| previous |
	previous := self items at: anIndex.
	previous removedFromMenu: self.
	self items at: anIndex put: anItem.
	self window root replaceChild: previous with: anItem

]
