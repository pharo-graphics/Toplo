Class {
	#name : #ToMenuBar,
	#superclass : #ToElement,
	#traits : 'TToItem + TToMenuItem + TToItemBarOwner + TToMenuItemBarOwner + TToOrientable',
	#classTraits : 'TToItem classTrait + TToMenuItem classTrait + TToItemBarOwner classTrait + TToMenuItemBarOwner classTrait + TToOrientable classTrait',
	#instVars : [
		'isSubBar',
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

{ #category : #enumerating }
ToMenuBar >> collectedNodesDo: aValuable [

	self allChildrenBreadthFirstDo: [ :child |
		(child isKindOf: ToMenuItemNode) ifTrue: [
			child isFake ifFalse: [ aValuable value: child ] ] ]
]

{ #category : #'t - item bar owner - initializing' }
ToMenuBar >> configureLayout [
	" just force the resizer of the secondary direction 
	( vertical direction in case of an horizontal bar )"

	self isHorizontal
		ifTrue: [
			self vFitContent.
			self isSubBar ifTrue: [ self hFitContent ] ]
		ifFalse: [
			self hFitContent.
			self isSubBar ifTrue: [ self vFitContent ] ].
	self itemBar configureLayoutIn: self
]

{ #category : #initialization }
ToMenuBar >> initialize [

	super initialize.
	self initializeAsItemBarOwner.
	autoOpen := false.
	isSubBar := false.
	self layout: BlLinearLayout horizontal.
	self addEventHandler: ToMenuBarEventHandler new.
	self addChild: self itemBar.
	self nodeWrapping: false.
	self uniformNodeWidth: false.
	self beHorizontal
]

{ #category : #testing }
ToMenuBar >> isAutoOpen [

	^ self rootMenuBar autoOpen
]

{ #category : #'t - menu item' }
ToMenuBar >> isInline [

	^ false
]

{ #category : #testing }
ToMenuBar >> isMenuBar [

	^ true
]

{ #category : #testing }
ToMenuBar >> isSubBar [ 

	^ isSubBar
]

{ #category : #accessing }
ToMenuBar >> isSubBar: aBoolean [

	isSubBar := aBoolean
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
		(m isItemContainer and: [ m isInline not ]) ifTrue: [
			m mouseOverEvent: anEvent ] ]
]

{ #category : #'t - item list holder - initializing' }
ToMenuBar >> newItemBar [

	^ ToMenuItemBarElement new
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

	aMenu isSubmenu: false
]

{ #category : #layout }
ToMenuBar >> onMeasure: anExtentMeasurementSpec [
	"By default let layout strategy do the measuring job.
	If needed override this method to do some additional
	actions or just implement custom layout strategy"

	| w |
	super onMeasure: anExtentMeasurementSpec.
	self isHorizontal ifTrue: [ ^ self ].
	w := 0.
	self collectedNodesDo: [ :child | w := w max: child measuredWidth ].
	self collectedNodesDo: [ :child |
		child measuredExtent: w @ child measuredHeight ]
]

{ #category : #'adding-removing' }
ToMenuBar >> onRemovedFromItemListHolder: aMenuItemContainer [

	aMenuItemContainer onRemovedMenuBar: self
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

	self barOwner ifNil: [ ^ self ].
	^ self barOwner rootMenuBar
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
