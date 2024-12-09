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

{ #category : #'auto opening' }
ToMenuBar >> autoOpen [

	^ autoOpen
]

{ #category : #'auto opening' }
ToMenuBar >> autoOpen: anObject [

	autoOpen := anObject
]

{ #category : #'auto opening' }
ToMenuBar >> cancelAutoOpen [

	self rootMenuBar autoOpen: false
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

{ #category : #'auto opening' }
ToMenuBar >> isAutoOpen [

	^ self rootMenuBar autoOpen
]

{ #category : #testing }
ToMenuBar >> isMenuBar [

	^ true
]

{ #category : #testing }
ToMenuBar >> isSubBar [ 

	^ parentItemContainer notNil
]

{ #category : #'t - menu item' }
ToMenuBar >> itemContaining: anElement [

	self = anElement ifTrue: [ ^ self ].
	^ (self itemList itemContaining: anElement) ifNotNil: [ :found |
		  | item |
		  item := found item.
		  item isMenuBar
			  ifTrue: [ item itemContaining: anElement ]
			  ifFalse: [ item ] ]
]

{ #category : #'t - orientable - accessing' }
ToMenuBar >> layoutStrategy [

	^ self layout


]

{ #category : #'t - menu window model' }
ToMenuBar >> menuBar [

	^ self
]

{ #category : #enumerating }
ToMenuBar >> menuWindowDo: aValuable [
]

{ #category : #'event handling' }
ToMenuBar >> mouseOverEvent: anEvent [

	self isAutoOpen ifFalse: [ ^ self ].

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

{ #category : #'adding-removing' }
ToMenuBar >> onAddedInMenuItemContainer: aMenuItemContainer [

	aMenuItemContainer onAddedMenuBar: self
]

{ #category : #'t - menu item container - double dispatch' }
ToMenuBar >> onAddedMenu: aMenu [

	aMenu parentItemContainer: self.
	aMenu isSubmenu: false
]

{ #category : #adding }
ToMenuBar >> removeMenu: aMenu [

	self
		deprecated: '#use removeItem: instead'
		transformWith: '`@rcvr removeMenu: `@arg' -> '`@rcvr removeItem: `@arg'.
	self removeItem: aMenu
]

{ #category : #accessing }
ToMenuBar >> rootMenuBar [ 

	parentItemContainer ifNil: [ ^ self ].
	^ parentItemContainer rootMenuBar
]

{ #category : #'auto opening' }
ToMenuBar >> startAutoOpen [

	self rootMenuBar autoOpen: true
]

{ #category : #'auto opening' }
ToMenuBar >> switchAutoOpen [

	self isAutoOpen
		ifTrue: [ self cancelAutoOpen ]
		ifFalse: [ self startAutoOpen ]
]
