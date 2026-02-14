"
I'm a composite of Menu items. I can behave as a menu item (this is why I inherit from ToMenuItem) but I manage sub menu items.
"
Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToItemListOwner + TToItemListUser + TToMenuItemListUser + TToMenuWindowModel',
	#classTraits : 'TToItemListOwner classTrait + TToItemListUser classTrait + TToMenuItemListUser classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'isSubmenu',
		'builder',
		'windowManager',
		'isMenuPaneMenu',
		'showExpandIcon'
	],
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #accessing }
ToMenu >> anchorRoot: anElement [

	self manager anchorRoot: anElement
]

{ #category : #accessing }
ToMenu >> bar [

	self
		deprecated: 'Use #itemList instead'
		transformWith: '`@rcvr bar' -> '`@rcvr itemList'.

	^ self itemList
]

{ #category : #testing }
ToMenu >> beInline [

	self manager beInline
]

{ #category : #'window handling' }
ToMenu >> bottomUpCloseWindowRequestOnEvent: anEvent [

	self manager bottomUpCloseWindowRequestOnEvent: anEvent
]

{ #category : #accessing }
ToMenu >> builder [ 

	^ builder
]

{ #category : #accessing }
ToMenu >> builder: aValuable [

	" aValuable takes myself and the request event as arguments "

	builder := aValuable
]

{ #category : #'t - menu window model' }
ToMenu >> closeWindow [

	self menuWindow ifNotNil: [:mw | mw close ].

]

{ #category : #accessing }
ToMenu >> includes: anElement [

	self menuWindow = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ super includes: anElement
]

{ #category : #initialization }
ToMenu >> initialize [

	super initialize.
	self initializeAsItemListOwner.
	self initializeAsMenuItemListUser.

	isSubmenu := false.
	isMenuPaneMenu := false.
	self closeOnPicking: false.

	windowManager := self newWindowManager 
		                 windowBuilder: [ :window :request |
			                 builder ifNotNil: [
					                 self removeAllItems.
					                 self builder cull: self cull: request ].
			                 window root addChild: self itemList ];
		                 yourself.
	self addEventHandler: windowManager
]

{ #category : #testing }
ToMenu >> isInline [

	^ self hasInlineWindow 
]

{ #category : #accessing }
ToMenu >> isMenu [

	^ true
]

{ #category : #testing }
ToMenu >> isMenuPaneMenu [

	^ isMenuPaneMenu
]

{ #category : #accessing }
ToMenu >> isMenuPaneMenu: aBoolean [

	isMenuPaneMenu := aBoolean
]

{ #category : #testing }
ToMenu >> isOpened [ 

	^ self menuWindow notNil and: [ self menuWindow isOpened ]
]

{ #category : #testing }
ToMenu >> isOutsideEvent: anEvent [

	| windows |
	windows := Array streamContents: [ :stream |
			           self manager currentWindowDo: [ :w |
				           w withAllSubwindowsDo: [ :sub | stream nextPut: sub ] ] ].
	(windows allSatisfy: [ :w | w isOutsideEvent: anEvent ]) ifFalse: [
		^ false ].
	(self items allSatisfy: [ :it | it isOutsideEvent: anEvent ])
		ifFalse: [ ^ false ].
	^ super isOutsideEvent: anEvent
]

{ #category : #'t - menu item' }
ToMenu >> isSubmenu [

	^ isSubmenu ifNil: [ false ]
]

{ #category : #accessing }
ToMenu >> isSubmenu: aBoolean [

	isSubmenu := aBoolean
]

{ #category : #'t - menu window model' }
ToMenu >> isTopMenu [

	^ self isSubmenu not or: [ self isMenuPaneMenu ]
]

{ #category : #'t - item list user - accessing' }
ToMenu >> itemList [

	^ itemList
]

{ #category : #accessing }
ToMenu >> manager [ 

	^ windowManager 
]

{ #category : #'t - menu window model' }
ToMenu >> menuWindow [

	^ self manager currentWindow
]

{ #category : #'t - item list owner - initializing' }
ToMenu >> newItemList [

	^ ToMenuItemListElement new
]

{ #category : #skin }
ToMenu >> newRawSkin [ 

	^ ToMenuSkin new
]

{ #category : #'instance creation' }
ToMenu >> newWindowManager [

 	^ ToPopupMenuWindowManager new
]

{ #category : #'adding-removing' }
ToMenu >> onAddedInItemBarOwner: aMenu [

	aMenu onAddedMenu: self
]

{ #category : #'t - menu item list user - double dispatch' }
ToMenu >> onAddedMenu: aMenu [

	aMenu isSubmenu: true.
	" don't close a menu item on picking (mouse up or mouse down) "
	aMenu closeOnPicking: false
]

{ #category : #'adding-removing' }
ToMenu >> onRemovedFromItemBarOwner: aMenu [

	aMenu onRemovedMenu: self
]

{ #category : #'t - menu item list user - double dispatch' }
ToMenu >> onRemovedMenu: aMenu [

	aMenu isSubmenu: false
]

{ #category : #'t - menu window model' }
ToMenu >> popupEvent: anEvent [

	self manager popupEvent: anEvent
]

{ #category : #'t - menu item' }
ToMenu >> showExpandIcon [

	^ showExpandIcon ifNil: [ showExpandIcon := false ]
]

{ #category : #accessing }
ToMenu >> showExpandIcon: aBoolean [

	showExpandIcon = aBoolean ifTrue: [ ^ self ].
	showExpandIcon := aBoolean.
	self requestNewSkin
]

{ #category : #accessing }
ToMenu >> windowManager [

	self
		deprecated: 'Use #manager instead'
		transformWith: '`@rcvr windowManager' -> '`@rcvr manager'.
	^ self manager
]
