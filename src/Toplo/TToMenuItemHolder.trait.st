Trait {
	#name : #TToMenuItemHolder,
	#instVars : [
		'items',
		'globalColumnWidth'
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
	self subMenuWindow root addChild: aMenuItem.
	aMenuItem addedInMenu: self
]

{ #category : #'t - menu item adding/removing' }
TToMenuItemHolder >> addSeparator [

	self addItem: ToSeparatorMenuItem new
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

{ #category : #'t - menu item adding/removing' }
TToMenuItemHolder >> removeItem: aMenuItem [

	aMenuItem removedFromMenu: self.
	self items remove: aMenuItem.
	self subMenuWindow removeChild: aMenuItem
]

{ #category : #'t - menu accessing' }
TToMenuItemHolder >> subMenuWindow [

	^ self explicitRequirement 
]

{ #category : #'t - menu accessing' }
TToMenuItemHolder >> withoutLeftColumn [

	self globalColumnWidth: 0
]
