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
	isSubmenu := true.
	self initializeWithMenuItemConstraints

]

{ #category : #'t - clickable - click behavior' }
ToMenu >> clickEventClass [

	^ BlMouseDownEvent
]

{ #category : #'menu window' }
ToMenu >> closeWindow [

	self items do: [ :it | it isOpened ifTrue: [ it closeWindow ] ].
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
	self initializeWithMenuConstraints.
	windowManager := ToMenuWindowManager new onInstalledIn: self.
	windowManager builder: [ :menWin :request |
		request currentTarget items do: [ :it | menWin root addChild: it ] ]
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

	^ windowManager currentWindow
]

{ #category : #'menu window' }
ToMenu >> menuWindowDo: aValuable [

	self menuWindow ifNil: [ ^ self ].
	aValuable value: self menuWindow
]

{ #category : #skin }
ToMenu >> newRawSkin [ 

	^ ToMenuSkin new
]

{ #category : #'t - menu window model' }
ToMenu >> popupEvent: anEvent [

	(windowManager newWindowEvent: anEvent) popupEvent: anEvent
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

	windowManager toThemeChanged.
	super toThemeChanged.

	
]
