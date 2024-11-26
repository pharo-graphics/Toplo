Class {
	#name : #ToMenuBar,
	#superclass : #ToElement,
	#traits : 'TToMenuItemContainer + TToOrientable',
	#classTraits : 'TToMenuItemContainer classTrait + TToOrientable classTrait',
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

{ #category : #'t - menu item container - double dispatch' }
ToMenuBar >> addedMenuItem: aMenuItem [

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
	self addEventFilter: ToMenuBarEventFilter new.
	self addEventHandler: ToMenuBarEventHandler new.
	self itemList uniformNodeWidth: false.
	self addChild: self itemList.
	self beHorizontal.
	self configureLayout

]

{ #category : #testing }
ToMenuBar >> isMenu [

	^ true
]

{ #category : #'t - orientable - accessing' }
ToMenuBar >> layoutStrategy [

	^ self layout


]

{ #category : #skin }
ToMenuBar >> newRawSkin [

	^ ToMenuBarSkin new
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
