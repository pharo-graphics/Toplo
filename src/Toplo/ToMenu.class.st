Class {
	#name : #ToMenu,
	#superclass : #ToButtonMenuItem,
	#instVars : [
		'items',
		'rightIcon',
		'menuWindow',
		'submenuDresser',
		'ensureLabelLeftAlignment'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'item adding/removing' }
ToMenu >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'item adding/removing' }
ToMenu >> addItem: aMenuItem [

	self items add: aMenuItem.
	self menuWindow addChild: aMenuItem.
	aMenuItem addedInMenu: self
]

{ #category : #'item adding/removing' }
ToMenu >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #initialization }
ToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	submenuDresser ifNil: [ 
		submenuDresser := ToMenuAsSubmenuDresser new.
		self addDresser: submenuDresser].
	self privateUpdateChildren
]

{ #category : #'t - button initialization' }
ToMenu >> childrenLayout [

	self isSubmenu ifTrue: [ 
		^ { 
			  self icon.
			  iconColumnFill.
			  labelColumnFill.
			  self label.
			  self privateMatchParentFill.
			  self rightIcon } select: #notNil ].

	^ super childrenLayout
]

{ #category : #window }
ToMenu >> close [

	self menuWindow close
]

{ #category : #'t - initialization dresser' }
ToMenu >> defaultDresser [

	^ ToBasicMenuItemDresser next: ToMenuDresser new
]

{ #category : #'t - button accessing' }
ToMenu >> ensureLabelLeftAlignment [

	^ ensureLabelLeftAlignment ifNil: [ ensureLabelLeftAlignment := true ]
]

{ #category : #initialization }
ToMenu >> initialize [

	super initialize.

	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	items := OrderedCollection new.
	menuWindow := ToMenuWindow new widget: self.
	self whenClickedDo: [ self popupOrClose ].
	self whenLayoutedDo: [ self items do: [ :i | i updateFilling ] ]
]

{ #category : #testing }
ToMenu >> isSubmenu [

	^ submenuDresser notNil
]

{ #category : #'item  accessing' }
ToMenu >> items [

	^ items
]

{ #category : #window }
ToMenu >> menuWindow [

	^ menuWindow 
]

{ #category : #window }
ToMenu >> popup [

	self menuWindow popup
]

{ #category : #window }
ToMenu >> popupOrClose [

	self menuWindow isAttachedToSceneGraph ifTrue: [ 
		^ self menuWindow close ].
	self parentMenuWindow ifNotNil: [ :w | 
		^ w openSubmenuWindowFor: self ].
	self menuWindow popup
]

{ #category : #'item adding/removing' }
ToMenu >> removeItem: aMenuItem [

	aMenuItem removedFromMenu: self.
	self items remove: aMenuItem.
	self menuWindow removeChild: aMenuItem
]

{ #category : #initialization }
ToMenu >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	submenuDresser ifNotNil: [ 
		self removeDresser: submenuDresser.
		submenuDresser := nil ]
]

{ #category : #initialization }
ToMenu >> rightIcon [

	^ rightIcon ifNil: [ 
		  rightIcon := ToImage new
			               innerImage: self rightIconImage;
			               yourself ]
]

{ #category : #initialization }
ToMenu >> rightIconImage [

	| ic |
	ic := BlTextElement new text: '>' asRopedText bold.
	ic constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ].
	^ ic
]

{ #category : #initialization }
ToMenu >> shouldCheckIconColumnFill [

	^ self icon hasInnerImage 
]
