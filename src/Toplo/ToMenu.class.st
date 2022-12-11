Class {
	#name : #ToMenu,
	#superclass : #ToButtonMenuItem,
	#instVars : [
		'items',
		'rightIcon',
		'asSubmenu',
		'menuWindow'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'item adding/removing' }
ToMenu >> addItem: aMenuItem [

	self items add: aMenuItem.
	self menuWindow addChild: aMenuItem.
	aMenuItem addedInMenu: self
]

{ #category : #initialization }
ToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	asSubmenu ifFalse: [ self addDresser: ToMenuAsSubmenuDresser new ].
	asSubmenu := true.
	self privateUpdateChildren
]

{ #category : #accessing }
ToMenu >> asSubmenu [

	^ asSubmenu ifNil: [ asSubmenu := false ]
]

{ #category : #'t - button initialization' }
ToMenu >> childrenLayout [

	^ self asSubmenu
		  ifTrue: [ 
			  { 
				  self icon.
				  self label.
				  self privateFill.
				  self rightIcon } ]
		  ifFalse: [ 
			  { 
				  self icon.
				  self label } ]
]

{ #category : #window }
ToMenu >> close [

	self menuWindow close
]

{ #category : #'t - initialization dresser' }
ToMenu >> defaultDresser [

	^ ToMenuDresser new
]

{ #category : #initialization }
ToMenu >> initialize [

	super initialize.

	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].

	items := OrderedCollection new.
	menuWindow := ToMenuWindow new widget: self.

	self whenClickedDo: [ self popupOrClose ]
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

	self menuWindow isAttachedToSceneGraph
		ifTrue: [ self menuWindow close ]
		ifFalse: [ self menuWindow popup ]
]

{ #category : #'item adding/removing' }
ToMenu >> removeItem: aMenuItem [

	self items remove: aMenuItem.
	self menuWindow removeChild: aMenuItem.
	aMenuItem privateParentMenuWindow: nil.

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
