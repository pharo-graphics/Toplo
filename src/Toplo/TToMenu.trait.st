Trait {
	#name : #TToMenu,
	#instVars : [
		'items',
		'menuWindow',
		'submenuDresser',
		'globalLeftColumnWidth'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - menu item adding/removing' }
TToMenu >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - menu item adding/removing' }
TToMenu >> addItem: aMenuItem [

	self items add: aMenuItem.
	self menuWindow addChild: aMenuItem.
	aMenuItem addedInMenu: self
]

{ #category : #'t - menu item adding/removing' }
TToMenu >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu initialization' }
TToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu. 
	submenuDresser ifNil: [ 
		submenuDresser := ToMenuAsSubmenuDresser new.
		self addDresser: submenuDresser ].
	self announce: ToMenuPresentationChangedAnnouncement new
]

{ #category : #'event management' }
TToMenu >> announce: anAnnouncement [

	self explicitRequirement 
]

{ #category : #'t - menu window' }
TToMenu >> close [

	self menuWindow close
]

{ #category : #'t - menu accessing' }
TToMenu >> defaultGlobalLeftColumnWidth [

	^ 22 
]

{ #category : #'t - menu accessing' }
TToMenu >> globalLeftColumnWidth [

	^ globalLeftColumnWidth ifNil: [ self defaultGlobalLeftColumnWidth ] 
]

{ #category : #'t - menu accessing' }
TToMenu >> globalLeftColumnWidth: anInteger [

	self globalLeftColumnWidth = anInteger ifTrue: [ ^ self ].
	globalLeftColumnWidth := anInteger.
	self items do: [ :item | item 	leftColumnWidth: anInteger ]
	
]

{ #category : #'t - menu testing' }
TToMenu >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - menu initialization' }
TToMenu >> initializeMenu [

	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	items := OrderedCollection new.
	menuWindow := self menuWindowClass new
]

{ #category : #'t - menu testing' }
TToMenu >> isSubmenu [

	^ submenuDresser notNil
]

{ #category : #'t - menu item  accessing' }
TToMenu >> items [

	^ items
]

{ #category : #'t - menu window' }
TToMenu >> menuWindow [

	^ menuWindow 
]

{ #category : #'t - menu initialization' }
TToMenu >> menuWindowClass [

	^ self explicitRequirement 
]

{ #category : #'t - menu window' }
TToMenu >> parentMenuWindow [

	^ self explicitRequirement 
]

{ #category : #'t - menu window' }
TToMenu >> popup [

	self hasItems ifFalse: [ ^ self ].
	self menuWindow popup
]

{ #category : #'t - menu window' }
TToMenu >> popupOrClose [

	self menuWindow isAttachedToSceneGraph ifTrue: [ 
		^ self menuWindow close ].
	self parentMenuWindow ifNotNil: [ :w | 
		^ w openSubmenuWindowFor: self ].
	self popup
]

{ #category : #'t - menu item adding/removing' }
TToMenu >> removeItem: aMenuItem [

	aMenuItem removedFromMenu: self.
	self items remove: aMenuItem.
	self menuWindow removeChild: aMenuItem
]

{ #category : #'t - menu initialization' }
TToMenu >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	submenuDresser ifNotNil: [ 
		self removeDresser: submenuDresser.
		submenuDresser := nil ]
]

{ #category : #'t - menu initialization' }
TToMenu >> rightIconImage [

	| ic |
	ic := BlTextElement new text: '>' asRopedText bold.
	ic constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter ].
	^ ic
]
