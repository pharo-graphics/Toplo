Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemContainer + TToMenuWindowModel',
	#classTraits : 'TToMenuItemContainer classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'windowManager',
		'itemList'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #accessing }
ToMenu >> bar [

	self
		deprecated: 'Use #itemList instead'
		transformWith: '`@rcvr bar' -> '`@rcvr itemList'.

	^ self itemList
]

{ #category : #initialization }
ToMenu >> buttonClickEventClass [

	^ BlMouseDownEvent
]

{ #category : #'t - menu window model' }
ToMenu >> closeWindow [

	" first ask the items to close "
	self items do: [ :it | it closeWindow ].
	" now my window "
	self menuWindow ifNotNil: [:mw | mw close ]
]

{ #category : #testing }
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
	itemList := ToMenuItemListElement new.
	windowManager := ToMenuWindowManager new.
	self addEventHandler: windowManager.
	windowManager builder: [ :menWin :request |
		menWin root addChild: request currentTarget itemList ]
]

{ #category : #testing }
ToMenu >> isMenu [

	^ true
]

{ #category : #'t - menu window model' }
ToMenu >> isOpened [ 

	^ self menuWindow notNil
]

{ #category : #'t - menu window model' }
ToMenu >> isSubmenu [

	^ parentMenu notNil
]

{ #category : #'t - menu window model' }
ToMenu >> isTopMenu [

	^ self parentMenu isNil
]

{ #category : #accessing }
ToMenu >> itemList [

	^  itemList
]

{ #category : #'t - menu item container - accessing' }
ToMenu >> items [

	^ itemList dataAccessor
]

{ #category : #'t - menu window model' }
ToMenu >> menuWindow [ 

	^ windowManager currentWindow
]

{ #category : #skin }
ToMenu >> newRawSkin [ 

	^ ToMenuSkin new
]

{ #category : #'t - menu window model' }
ToMenu >> popupEvent: anEvent [

	windowManager popupEvent: anEvent
]

{ #category : #'t - menu window model' }
ToMenu >> rootMenu [

	^ super rootMenu
]
