Class {
	#name : #ToCircularMenuPane,
	#superclass : #ToElement,
	#traits : 'TToItemListOwner + TToItemListUser + TToMenuItemListUser',
	#classTraits : 'TToItemListOwner classTrait + TToItemListUser classTrait + TToMenuItemListUser classTrait',
	#instVars : [
		'autoOpen',
		'isSubPane',
		'builder'
	],
	#category : #'Toplo-Widget-Menu-Pane'
}

{ #category : #accessing }
ToCircularMenuPane >> autoOpen [

	^ autoOpen
]

{ #category : #accessing }
ToCircularMenuPane >> autoOpen: anObject [

	autoOpen := anObject
]

{ #category : #'window handling' }
ToCircularMenuPane >> bottomUpCloseWindowRequestOnEvent: anEvent [
]

{ #category : #accessing }
ToCircularMenuPane >> builder: aValuable [

	" aValuable takes myself and the request event as arguments "

	builder := aValuable
]

{ #category : #'auto opening' }
ToCircularMenuPane >> cancelAutoOpen [

	self rootMenuPane autoOpen: false
]

{ #category : #initialization }
ToCircularMenuPane >> initialize [

	super initialize.
	self initializeAsItemListOwner.
	self initializeAsMenuItemListUser.
	
	autoOpen := false.
	isSubPane := false.

	self layout: BlFrameLayout new.
	self itemList constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	self matchParent.
	self addEventHandler: ToMenuPaneEventHandler new.
	self addChild: self itemList
]

{ #category : #testing }
ToCircularMenuPane >> isAutoOpen [

	^ self rootMenuPane autoOpen
]

{ #category : #accessing }
ToCircularMenuPane >> isSubPane [ 

	^ isSubPane
]

{ #category : #accessing }
ToCircularMenuPane >> isSubPane: aBoolean [

	isSubPane := aBoolean
]

{ #category : #'t - item list user - accessing' }
ToCircularMenuPane >> itemList [

	^ itemList 
]

{ #category : #'t - menu item' }
ToCircularMenuPane >> menuListOwner [

	^ self listElement ifNotNil: [ :be | be menuListOwner ]
]

{ #category : #'t - item list owner - initializing' }
ToCircularMenuPane >> newItemList [ 

	^ ToCircularMenuItemList new
]

{ #category : #accessing }
ToCircularMenuPane >> rootMenuPane [

	^ self
]
