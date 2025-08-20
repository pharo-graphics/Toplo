Class {
	#name : #ToMenuPane,
	#superclass : #ToElement,
	#traits : 'TToItem + TToMenuItem + TToItemBarContainer + TToMenuItemBarContainer + TToOrientable',
	#classTraits : 'TToItem classTrait + TToMenuItem classTrait + TToItemBarContainer classTrait + TToMenuItemBarContainer classTrait + TToOrientable classTrait',
	#instVars : [
		'autoOpen',
		'isSubPane'
	],
	#category : #'Toplo-Widget-Menu-Pane'
}

{ #category : #adding }
ToMenuPane >> addFiller [

	self addItem: ToMenuFiller new
]

{ #category : #adding }
ToMenuPane >> addMenu: aMenu [

	self
		deprecated: '#use addItem: instead'
		transformWith: '`@rcvr addMenu: `@arg' -> '`@rcvr addItem: `@arg'.
	self addItem: aMenu
]

{ #category : #configuration }
ToMenuPane >> applyConfiguration [
	" just force the resizer of the secondary direction 
	( vertical direction in case of an horizontal bar )"

	super applyConfiguration.
	self uniformNodeWidth: self isVertical.
	self itemBar horizontal: self isHorizontal.
	self itemBar isScrollable: self isScrollable.
	self itemBar isFlowable: self isFlowable.
	self isHFitContent
		ifTrue: [ self itemBar hFitContent ]
		ifFalse: [ self itemBar hMatchParent ].
	self isVFitContent
		ifTrue: [ self itemBar vFitContent ]
		ifFalse: [ self itemBar vMatchParent ]
]

{ #category : #'auto opening' }
ToMenuPane >> autoOpen [

	^ autoOpen
]

{ #category : #'auto opening' }
ToMenuPane >> autoOpen: anObject [

	autoOpen := anObject
]

{ #category : #'auto opening' }
ToMenuPane >> cancelAutoOpen [

	self rootMenuPane autoOpen: false
]

{ #category : #initialization }
ToMenuPane >> initialize [

	super initialize.
	self initializeAsItemBarContainer.
	self initializeAsMenuItemBarContainer.

	autoOpen := false.
	isSubPane := false.
	self layout: BlLinearLayout horizontal.
	self layout alignCenter.
	self addEventHandler: ToMenuPaneEventHandler new.
	self addChild: self itemBar.
	self isFlowable: false.
	self isScrollable: false.
	self beHorizontal.
	self fitContent
]

{ #category : #testing }
ToMenuPane >> isAutoOpen [

	^ self rootMenuPane autoOpen
]

{ #category : #'t - menu item' }
ToMenuPane >> isInline [

	^ false
]

{ #category : #testing }
ToMenuPane >> isMenuPane [

	^ true
]

{ #category : #testing }
ToMenuPane >> isSubPane [ 

	^ isSubPane
]

{ #category : #accessing }
ToMenuPane >> isSubPane: aBoolean [

	isSubPane := aBoolean
]

{ #category : #'t - menu window model' }
ToMenuPane >> menuPane [

	^ self
]

{ #category : #enumerating }
ToMenuPane >> menuWindowDo: aValuable [
]

{ #category : #'event handling' }
ToMenuPane >> mouseOverEvent: anEvent [

	self isAutoOpen ifFalse: [ ^ self ].

	" auto-open action "
	self items do: [ :m |
		(m isItemContainer and: [ m isInline not ]) ifTrue: [
			m mouseOverEvent: anEvent ] ]
]

{ #category : #'t - item list holder - initializing' }
ToMenuPane >> newItemBar [

	^ ToMenuItemBarElement new
]

{ #category : #skin }
ToMenuPane >> newRawSkin [

	^ ToMenuPaneSkin new
]

{ #category : #'adding-removing' }
ToMenuPane >> onAddedInItemBarOwner: aMenuItemBar [

	aMenuItemBar onAddedMenuPane: self
]

{ #category : #'t - menu item bar container - double dispatch' }
ToMenuPane >> onAddedMenu: aMenu [

	aMenu isMenuPaneMenu: true.
]

{ #category : #'adding-removing' }
ToMenuPane >> onRemovedFromItemBarOwner: aMenuItemBar [

	aMenuItemBar onRemovedMenuPane: self
]

{ #category : #adding }
ToMenuPane >> removeMenu: aMenu [

	self
		deprecated: '#use removeItem: instead'
		transformWith: '`@rcvr removeMenu: `@arg' -> '`@rcvr removeItem: `@arg'.
	self removeItem: aMenu
]

{ #category : #accessing }
ToMenuPane >> rootMenuPane [

	^ self menuBarOwner ifNotNil: [ :bo | bo rootMenuPane ] ifNil: [ self ]
]

{ #category : #'auto opening' }
ToMenuPane >> startAutoOpen [

	self rootMenuPane autoOpen: true
]

{ #category : #'auto opening' }
ToMenuPane >> switchAutoOpen [

	self isAutoOpen
		ifTrue: [ self cancelAutoOpen ]
		ifFalse: [ self startAutoOpen ]
]
