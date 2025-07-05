"
I'm a composite of Menu items. I can behave as a menu item (this is why I inherit from ToMenuItem) but I manage sub menu items.
"
Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToItemBarContainer + TToItemBarOwner + TToMenuItemListOwner + TToMenuWindowModel',
	#classTraits : 'TToItemBarContainer classTrait + TToItemBarOwner classTrait + TToMenuItemListOwner classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'isSubmenu',
		'builder',
		'windowManager',
		'openOnHovered',
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

{ #category : #accessing }
ToMenu >> builder [ 

	^ builder
]

{ #category : #accessing }
ToMenu >> builder: aValuable [

	" aValuable takes myself and the request event as arguments "

	builder := aValuable
]

{ #category : #testing }
ToMenu >> closeOnPicking [

	^ self manager closeOnPicking and: [ self isTopMenu not ]
]

{ #category : #testing }
ToMenu >> closeOnPicking: aBoolean [

	self manager closeOnPicking: aBoolean
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
	self fitContent.
	self initializeAsItemBarOwner.
	self initializeAsMenuItemListOwner.

	isSubmenu := false.
	isMenuPaneMenu := false.
	openOnHovered := true.
	self applySkinInstallerOnFirstRequest: true.

	windowManager := ToMenuPopupManager new
		                 windowBuilder: [ :window :request |
			                 builder ifNotNil: [
					                 self removeAllItems.
					                 self builder cull: self cull: request ].
			                 window root addChild: self itemBar ];
		                 yourself.
	self addEventHandler: windowManager
]

{ #category : #testing }
ToMenu >> isInline [

	^ self manager isInline
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

{ #category : #'t - menu window model' }
ToMenu >> isOpened [ 

	^ self menuWindow notNil and: [ self menuWindow isOpened ]
]

{ #category : #'t - menu window model' }
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

{ #category : #accessing }
ToMenu >> manager [ 

	^ windowManager 
]

{ #category : #'t - menu window model' }
ToMenu >> menuWindow [

	^ self manager currentWindow
]

{ #category : #'event handling' }
ToMenu >> mouseLeaveEvent: anEvent [

	self itemList secondarySelecter deselectAll
]

{ #category : #'event handling' }
ToMenu >> mouseOverEvent: anEvent [

	(anEvent target withAllParentsInclude: self)
		ifTrue: [ self menuWindow ifNil: [ self popupEvent: anEvent ] ]
		ifFalse: [ self closeWindow ]
]

{ #category : #'t - item bar container - accessing' }
ToMenu >> newItemBar [

	^ ToMenuItemBarElement new
]

{ #category : #skin }
ToMenu >> newRawSkin [ 

	^ ToMenuSkin new
]

{ #category : #'adding-removing' }
ToMenu >> onAddedInItemBarOwner: aMenu [

	aMenu onAddedMenu: self
]

{ #category : #'t - menu item list owner - double dispatch' }
ToMenu >> onAddedMenu: aMenu [

	aMenu isSubmenu: true.
	aMenu closeOnPicking: false
]

{ #category : #'adding-removing' }
ToMenu >> onRemovedFromItemBarOwner: aMenu [

	aMenu onRemovedMenu: self
]

{ #category : #'t - menu item list owner - double dispatch' }
ToMenu >> onRemovedMenu: aMenu [

	aMenu isSubmenu: false.
	aMenu closeOnPicking: false
]

{ #category : #accessing }
ToMenu >> openOnHovered [

	^ openOnHovered
]

{ #category : #accessing }
ToMenu >> openOnHovered: aBoolean [

	openOnHovered := aBoolean
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
