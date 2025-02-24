Class {
	#name : #ToMenuPane,
	#superclass : #ToElement,
	#traits : 'TToItem + TToMenuItem + TToItemListOwner + TToMenuItemListOwner + TToMenuItemContainer + TToWithOrientableLayout',
	#classTraits : 'TToItem classTrait + TToMenuItem classTrait + TToItemListOwner classTrait + TToMenuItemListOwner classTrait + TToMenuItemContainer classTrait + TToWithOrientableLayout classTrait',
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
ToMenuPane >> applyInnerConfiguration [ 

	self configureLayout.
	super applyInnerConfiguration
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

{ #category : #'t - menu window model' }
ToMenuPane >> closeWindow [

	self itemList do: [ :it | it isMenuItem ifTrue: [ it closeWindow ] ]
]

{ #category : #'t - item bar owner - initializing' }
ToMenuPane >> configureLayout [
	" just force the resizer of the secondary direction 
	( vertical direction in case of an horizontal bar )"

	self isHorizontal
		ifTrue: [
			self vFitContent.
			self isSubPane ifTrue: [ self hFitContent ] ]
		ifFalse: [
			self hFitContent.
			self isSubPane ifTrue: [ self vFitContent ] ].

	self itemBar horizontal: self isHorizontal.
	self isHMatchParent
		ifTrue: [ self itemBar hMatchParent ]
		ifFalse: [ self itemBar hFitContent ].
	self isVMatchParent
		ifTrue: [ self itemBar vMatchParent ]
		ifFalse: [ self itemBar vFitContent ].

	self itemBar configureLayout.

]

{ #category : #initialization }
ToMenuPane >> initialize [

	super initialize.
	self initializeAsItemBarOwner.
	self initializeAsMenuItemListOwner.

	autoOpen := false.
	isSubPane := false.
	self layout: BlLinearLayout horizontal.
	self addEventHandler: ToMenuPaneEventHandler new.
	self addChild: self itemBar.
	self isWrapping: false.
	self hasUniformNodeWidth: false.
	self beHorizontal.
	self configureLayout
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

{ #category : #'t - menu item' }
ToMenuPane >> itemContaining: anElement [

	self = anElement ifTrue: [ ^ self ].
	^ (self itemList itemContaining: anElement) ifNotNil: [ :found |
		  | item |
		  found = anElement ifTrue: [ ^ self ].
		  item := found item.
		  item isMenuPane
			  ifTrue: [ item itemContaining: anElement ]
			  ifFalse: [ item ] ]
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

{ #category : #'t - menu item list owner - double dispatch' }
ToMenuPane >> onAddedMenu: aMenu [

	aMenu isMenuPaneMenu: true.
]

{ #category : #layout }
ToMenuPane >> onMeasure: anExtentMeasurementSpec [
	"By default let layout strategy do the measuring job.
	If needed override this method to do some additional
	actions or just implement custom layout strategy"

	| w |
	super onMeasure: anExtentMeasurementSpec.
	self isHorizontal ifTrue: [ ^ self ].
	w := 0.
	self collectedNodesDo: [ :child | w := w max: child measuredWidth ].
	self collectedNodesDo: [ :child |
		child measuredWidth < w ifTrue: [
			child measuredExtent: w @ child measuredHeight ] ]
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
