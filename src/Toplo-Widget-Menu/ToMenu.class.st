Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemContainer + TToMenuWindowModel',
	#classTraits : 'TToMenuItemContainer classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'windowManager'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'as yet unclassified' }
ToMenu >> bar [

	self
		deprecated: 'Use #itemList instead'
		transformWith: '`@rcvr bar' -> '`@rcvr itemList'.

	^ self itemList
]

{ #category : #'as yet unclassified' }
ToMenu >> buttonClickEventClass [

	^ BlMouseDownEvent
]

{ #category : #'as yet unclassified' }
ToMenu >> closeWindow [

	" first ask the items to close "
	self items do: [ :it | it closeWindow ].
	" now my window "
	self menuWindow ifNotNil: [:mw | mw close ]
]

{ #category : #'as yet unclassified' }
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
	windowManager := ToMenuWindowManager new.
	self addEventHandler: windowManager.
	windowManager builder: [ :menWin :request |
		menWin root addChild: request currentTarget itemList ]
]

{ #category : #'as yet unclassified' }
ToMenu >> isMenu [

	^ true
]

{ #category : #'as yet unclassified' }
ToMenu >> isOpened [ 

	^ self menuWindow notNil
]

{ #category : #'as yet unclassified' }
ToMenu >> isSubmenu [

	^ parentMenu notNil
]

{ #category : #'as yet unclassified' }
ToMenu >> isTopMenu [

	^ self parentMenu isNil
]

{ #category : #'as yet unclassified' }
ToMenu >> menuWindow [ 

	^ windowManager currentWindow
]

{ #category : #'as yet unclassified' }
ToMenu >> newRawSkin [ 

	^ ToMenuSkin new
]

{ #category : #'as yet unclassified' }
ToMenu >> popupEvent: anEvent [

	windowManager popupEvent: anEvent
]

{ #category : #'as yet unclassified' }
ToMenu >> rootMenu [

	^ super rootMenu
]
