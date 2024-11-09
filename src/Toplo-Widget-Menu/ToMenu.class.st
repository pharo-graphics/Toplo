Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'items',
		'isSubmenu',
		'windowManager'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	isSubmenu := true
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
	isSubmenu := false.
	self fitContent.
	windowManager := ToMenuWindowManager new.
	self addEventHandler: windowManager.
	windowManager builder: [ :menWin :request |
		request currentTarget items do: [ :it | menWin root addChild: it ] ]
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

	^ windowManager currentWindow
]

{ #category : #skin }
ToMenu >> newRawSkin [ 

	^ ToMenuSkin new
]

{ #category : #'t - menu window model' }
ToMenu >> popupEvent: anEvent [

	windowManager enqueuePopupTaskFromEvent: anEvent
]

{ #category : #'adding-removing' }
ToMenu >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	isSubmenu := false.
]

{ #category : #'t - menu window model' }
ToMenu >> rootMenu [

	^ super rootMenu
]

{ #category : #'theme event handling' }
ToMenu >> toThemeInstalled [ 

	windowManager toThemeInstalled.
	super toThemeInstalled.

	
]

{ #category : #'theme event handling' }
ToMenu >> toThemeUninstalled: aTheme [

	windowManager toThemeUninstalled: aTheme.
	super toThemeUninstalled: aTheme

	
]
