Class {
	#name : #ToMenuBar,
	#superclass : #ToElement,
	#traits : 'TToMenuItem + TToMenuItemContainer + TToOrientable',
	#classTraits : 'TToMenuItem classTrait + TToMenuItemContainer classTrait + TToOrientable classTrait',
	#instVars : [
		'autoOpen'
	],
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #adding }
ToMenuBar >> addFiller [

	self addItem: ToMenuFiller new
]

{ #category : #adding }
ToMenuBar >> addMenu: aMenu [

	self
		deprecated: '#use addItem: instead'
		transformWith: '`@rcvr addMenu: `@arg' -> '`@rcvr addItem: `@arg'.
	self addItem: aMenu
]

{ #category : #'adding-removing' }
ToMenuBar >> addedInMenuItemContainer: aMenuItemContainer [

	aMenuItemContainer addedMenuBar: self
]

{ #category : #'t - menu item container - double dispatch' }
ToMenuBar >> addedMenu: aMenu [

	aMenu parentItemContainer: self.
	aMenu isSubmenu: false
]

{ #category : #accessing }
ToMenuBar >> autoOpen [

	^ autoOpen
]

{ #category : #accessing }
ToMenuBar >> autoOpen: anObject [

	autoOpen := anObject
]

{ #category : #'friend only' }
ToMenuBar >> closeRequestFrom: anItem [

	autoOpen := false.
	self items do: [ :i | i closeRequestFrom: anItem ]
]

{ #category : #'t - menu window model' }
ToMenuBar >> closeWindow [

	itemList do: [ :it | it isMenuItem ifTrue: [ it closeWindow ] ]
]

{ #category : #initialization }
ToMenuBar >> configureLayout [

	self isHorizontal
		ifTrue: [ 
			self itemList horizontal: true.
			self hMatchParent.
			self vFitContent ]
		ifFalse: [ 
			self itemList horizontal: false.
			self vMatchParent.
			self hFitContent ]
]

{ #category : #initialization }
ToMenuBar >> initialize [

	super initialize.

	autoOpen := false.
	self layout: BlLinearLayout new.
	self addEventHandler: (BlEventHandler
			 on: ToLayoutOrientationChangedEvent
			 do: [ self configureLayout ]).
	self addEventHandler: ToMenuBarEventHandler new.
	self itemList uniformNodeWidth: false.
	self addChild: self itemList.
	self beHorizontal.
	self configureLayout

]

{ #category : #testing }
ToMenuBar >> isMenuBar [

	^ true
]

{ #category : #'t - orientable - accessing' }
ToMenuBar >> layoutStrategy [

	^ self layout


]

{ #category : #enumerating }
ToMenuBar >> menuWindowDo: aValuable [
]

{ #category : #'event handling' }
ToMenuBar >> mouseOverEvent: anEvent [

	autoOpen ifFalse: [ ^ self ].

	" auto-open action "
	self items do: [ :m |
		m isMenuItemContainer ifTrue: [ m mouseOverEvent: anEvent ] ]
]

{ #category : #skin }
ToMenuBar >> newRawSkin [

	^ ToMenuBarSkin new
]

{ #category : #initialization }
ToMenuBar >> nodeWrapping: aBoolean [

	itemList nodeWrapping: aBoolean
]

{ #category : #adding }
ToMenuBar >> removeMenu: aMenu [

	self
		deprecated: '#use removeItem: instead'
		transformWith: '`@rcvr removeMenu: `@arg' -> '`@rcvr removeItem: `@arg'.
	self removeItem: aMenu
]

{ #category : #accessing }
ToMenuBar >> rootMenu [

	^ self
]
