Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemContainer + TToMenuWindowModel',
	#classTraits : 'TToMenuItemContainer classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'windowManager',
		'itemList',
		'isSubmenu'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToMenu >> addedInMenuItemContainer: aMenu [

	aMenu addedMenu: self
]

{ #category : #'window handling' }
ToMenu >> autoPopupEvent: anEvent [

	windowManager autoPopupEvent: anEvent
]

{ #category : #accessing }
ToMenu >> bar [

	self
		deprecated: 'Use #itemList instead'
		transformWith: '`@rcvr bar' -> '`@rcvr itemList'.

	^ self itemList
]

{ #category : #accessing }
ToMenu >> buttonClickEventClass [

	^ BlMouseDownEvent
]

{ #category : #'t - menu window model' }
ToMenu >> closeWindow [

	" first ask the items to close "
	self items do: [ :it | it closeWindow ].
	" now my window "
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
	isSubmenu := false.
	windowManager := ToMenuWindowManager new.
	self addEventHandler: windowManager.
	windowManager builder: [ :menWin :request |
		menWin root addChild: request currentTarget itemList ]
]

{ #category : #accessing }
ToMenu >> isMenu [

	^ true
]

{ #category : #'t - menu window model' }
ToMenu >> isOpened [ 

	^ self menuWindow notNil
]

{ #category : #'t - menu window model' }
ToMenu >> isSubmenu [

	^ isSubmenu
]

{ #category : #accessing }
ToMenu >> isSubmenu: aBoolean [

	isSubmenu := aBoolean
]

{ #category : #'t - menu window model' }
ToMenu >> isTopMenu [

	^ self isSubmenu not
]

{ #category : #'t - menu window model' }
ToMenu >> menuWindow [ 

	^ windowManager currentWindow
]

{ #category : #'event handling' }
ToMenu >> mouseOverEvent: anEvent [

	(anEvent target hasInParentChain: self)
		ifTrue: [ self menuWindow ifNil: [ self popupEvent: anEvent ] ]
		ifFalse: [ self closeWindow ]
]

{ #category : #accessing }
ToMenu >> newRawSkin [ 

	^ ToMenuSkin new
]

{ #category : #'t - menu window model' }
ToMenu >> popupEvent: anEvent [

	windowManager popupEvent: anEvent
]

{ #category : #accessing }
ToMenu >> rootMenu [

	^ super rootMenu
]
