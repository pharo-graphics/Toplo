Trait {
	#name : #TToMenuItemHolder,
	#instVars : [
		'items',
		'globalColumnWidth',
		'client'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - menu item adding/removing' }
TToMenuItemHolder >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - menu item adding/removing' }
TToMenuItemHolder >> addItem: aMenuItem [

	self items add: aMenuItem.
	self menuWindow root addChild: aMenuItem.
	aMenuItem addedInMenu: self
]

{ #category : #'t - menu item adding/removing' }
TToMenuItemHolder >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item adding/removing' }
TToMenuItemHolder >> changeItemAt: anIndex with: anItem [

	| item |
	item := self items at: anIndex.
	self removeItem: item
]

{ #category : #'t - menu accessing' }
TToMenuItemHolder >> client [

	^ client 
]

{ #category : #'t - menu accessing' }
TToMenuItemHolder >> client: anObject [

	client := anObject
]

{ #category : #'t - menu accessing' }
TToMenuItemHolder >> defaultGlobalColumnWidth [

	^ 22 
]

{ #category : #'t - menu accessing' }
TToMenuItemHolder >> globalColumnWidth [

	^ globalColumnWidth ifNil: [ self defaultGlobalColumnWidth ] 
]

{ #category : #'t - menu accessing' }
TToMenuItemHolder >> globalColumnWidth: anInteger [

	self globalColumnWidth = anInteger ifTrue: [ ^ self ].
	globalColumnWidth := anInteger.
	self items do: [ :item | item 	columnWidth: anInteger ]
	
]

{ #category : #'t - menu testing' }
TToMenuItemHolder >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - menu initialization' }
TToMenuItemHolder >> initializeMenuItemHolder [

	items := OrderedCollection new
]

{ #category : #'t - menu item  accessing' }
TToMenuItemHolder >> items [

	^ items
]

{ #category : #'t - menu accessing' }
TToMenuItemHolder >> menuWindow [

	^ self explicitRequirement 
]

{ #category : #'t - menu item adding/removing' }
TToMenuItemHolder >> removeItem: aMenuItem [

	aMenuItem removedFromMenu: self.
	self items remove: aMenuItem.
	self menuWindow root removeChild: aMenuItem
]

{ #category : #'t - menu item adding/removing' }
TToMenuItemHolder >> removeItemAt: anIndex [

	| item |
	item := self items at: anIndex.
	self removeItem: item
]

{ #category : #'t - menu item adding/removing' }
TToMenuItemHolder >> replaceItemAt: anIndex with: anItem [

	| previous |
	previous := self items at: anIndex.
	previous removedFromMenu: self.
	self items at: anIndex put: anItem.
	self menuWindow root replaceChild: previous with: anItem

]

{ #category : #'t - menu accessing' }
TToMenuItemHolder >> withoutLeftColumn [

	self globalColumnWidth: 0
]
