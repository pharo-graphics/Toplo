Class {
	#name : #ToMenuBar,
	#superclass : #ToElement,
	#traits : 'TToItem + TToMenuItem + TToItemListHolder + TToMenuItemListHolder + TToOrientable',
	#classTraits : 'TToItem classTrait + TToMenuItem classTrait + TToItemListHolder classTrait + TToMenuItemListHolder classTrait + TToOrientable classTrait',
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

	self itemList do: [ :it | it isMenuItem ifTrue: [ it closeWindow ] ]
]

{ #category : #'t - item list holder - initializing' }
ToMenuBar >> configureLayout [

	self isHorizontal
		ifTrue: [
			self hMatchParent.
			self vFitContent.
			self itemList horizontal: true ]
		ifFalse: [
			self vMatchParent.
			self hFitContent.
			self itemList horizontal: false ]
]

{ #category : #initialization }
ToMenuBar >> initialize [

	super initialize.

	autoOpen := false.
	self layout: BlLinearLayout horizontal.
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
ToMenuBar >> isInline [

	^ false
]

{ #category : #testing }
ToMenuBar >> isMenuBar [

	^ true
]

{ #category : #testing }
ToMenuBar >> isSubBar [ 

	^ self parentItemListHolder notNil
]

{ #category : #'t - menu item' }
ToMenuBar >> itemContaining: anElement [

	self = anElement ifTrue: [ ^ self ].
	^ (self itemList itemContaining: anElement) ifNotNil: [ :found |
		  | item |
		  found = anElement ifTrue: [ ^ self ].
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
		m isItemContainer ifTrue: [ m mouseOverEvent: anEvent ] ]
]

{ #category : #'t - item list holder - accessing' }
ToMenuBar >> newItemList [

	^ ToMenuItemListElement new
]

{ #category : #skin }
ToMenuBar >> newRawSkin [

	^ ToMenuBarSkin new
]

{ #category : #'adding-removing' }
ToMenuBar >> onAddedInItemListHolder: aMenuItemContainer [

	aMenuItemContainer onAddedMenuBar: self
]

{ #category : #'t - menu item list holder - double dispatch' }
ToMenuBar >> onAddedMenu: aMenu [

	aMenu parentItemListHolder: self.
	aMenu isSubmenu: false
]

{ #category : #'adding-removing' }
ToMenuBar >> onRemovedFromItemListHolder: aMenuItemContainer [

	aMenuItemContainer onRemovedMenuBar: self
]

{ #category : #'t - menu item list holder - double dispatch' }
ToMenuBar >> onRemovedMenu: aMenu [

	aMenu parentItemListHolder: nil.
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

	self parentItemListHolder ifNil: [ ^ self ].
	^ self parentItemListHolder rootMenuBar
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
