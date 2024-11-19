Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemContainer + TToMenuWindowModel',
	#classTraits : 'TToMenuItemContainer classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'bar',
		'windowManager'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #accessing }
ToMenu >> bar [

	^ bar
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
	bar := ToMenuBarElement new.
	windowManager := ToMenuWindowManager new.
	self addEventHandler: windowManager.
	windowManager builder: [ :menWin :request | 
		 menWin root addChild: request currentTarget bar ]
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

{ #category : #'t - menu item container - accessing' }
ToMenu >> items [

	^ bar dataAccessor
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
