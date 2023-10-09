Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'items',
		'isSubmenu'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	isSubmenu := true.
	self initializeWithMenuItemConstraints

]

{ #category : #'t - clickable - click behavior' }
ToMenu >> clickEventClass [

	^ BlMouseDownEvent
]

{ #category : #'t - menu window model' }
ToMenu >> close [

	self items do: [ :it | it close ].
	super close
]

{ #category : #testing }
ToMenu >> includes: anElement [

	self currentAssociateWindow = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ super includes: anElement
]

{ #category : #initialization }
ToMenu >> initialize [

	super initialize.
	isSubmenu := false.
	self initializeWithMenuConstraints.
	self associateWindowFactory: [ ToMenuWindow new ].
	self whenClickedDo: [ :event | self popupOrCloseEvent: event ]
		
]

{ #category : #initialization }
ToMenu >> initializeWithMenuConstraints [

	self fitContent.

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

	^ isSubmenu 
]

{ #category : #'t - menu window model' }
ToMenu >> isTopMenu [

	^ self parentMenu isNil
]

{ #category : #'t - menu item holder - accessing' }
ToMenu >> items [

	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #'t - menu window model' }
ToMenu >> menuWindow [ 

	^ self currentAssociateWindow 
]

{ #category : #'window accessing' }
ToMenu >> newMenuWindow [ 

	^ self newAssociateWindow 
]

{ #category : #'t - menu window model' }
ToMenu >> popupEvent: anEvent [

	| win |
	win := self newMenuWindow.
	win popupEvent: anEvent
]

{ #category : #'as yet unclassified' }
ToMenu >> popupOrCloseEvent: anEvent [

	self isOpened
		ifTrue: [ self close ]
		ifFalse: [ self popupEvent: anEvent ]
]

{ #category : #'adding-removing' }
ToMenu >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	isSubmenu := false.
	self initializeWithMenuConstraints 

	
]

{ #category : #'t - menu window model' }
ToMenu >> rootMenu [

	^ super rootMenu
]

{ #category : #'theme event handling' }
ToMenu >> toThemeChanged [ 

	super toThemeChanged.
	self window ifNotNil: [ :mw | mw toThemeChanged ]
	
]
