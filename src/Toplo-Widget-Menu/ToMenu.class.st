Class {
	#name : 'ToMenu',
	#superclass : 'ToMenuItem',
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'items',
		'isSubmenu',
		'windowHandler'
	],
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'adding-removing' }
ToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	isSubmenu := true.
	self initializeWithMenuItemConstraints

]

{ #category : 't - clickable - click behavior' }
ToMenu >> clickEventClass [

	^ BlMouseDownEvent
]

{ #category : 't - menu window model' }
ToMenu >> closeWindow [

	self items do: [ :it | it closeWindow ].
	windowHandler closeWindow
]

{ #category : 'testing' }
ToMenu >> includes: anElement [

	self menuWindow = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ super includes: anElement
]

{ #category : 'initialization' }
ToMenu >> initialize [

	super initialize.
	isSubmenu := false.
	self initializeWithMenuConstraints.
	windowHandler := ToMenuWindowManager new element: self.
	windowHandler builder: [ :menWin :request |
		self requestNewSkin.
		request currentTarget items do: [ :it |
			menWin root addChild: it.
			it requestNewSkin ] ]
]

{ #category : 'initialization' }
ToMenu >> initializeWithMenuConstraints [

	self fitContent.

]

{ #category : 'skin' }
ToMenu >> installRawStyle [

	super installRawStyle.
	self isSubmenu ifFalse: [ ^ self ].
	self parentMenu items do: [ :mi |
		(mi isKindOf: ToMenuItem) ifTrue: [ mi filler width: 15] ].
	self rightHandSide addChild: (ToLabel new
			 text: '...';
			 yourself).

]

{ #category : 'testing' }
ToMenu >> isMenu [

	^ true
]

{ #category : 't - menu window model' }
ToMenu >> isOpened [ 

	^ self menuWindow notNil
]

{ #category : 't - menu window model' }
ToMenu >> isSubmenu [

	^ isSubmenu 
]

{ #category : 't - menu window model' }
ToMenu >> isTopMenu [

	^ self parentMenu isNil
]

{ #category : 't - menu item holder - accessing' }
ToMenu >> items [

	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : 't - menu window model' }
ToMenu >> menuWindow [ 

	^ windowHandler currentWindow
]

{ #category : 'menu window' }
ToMenu >> menuWindowDo: aValuable [

	self menuWindow ifNil: [ ^ self ].
	aValuable value: self menuWindow
]

{ #category : 't - menu window model' }
ToMenu >> popupEvent: anEvent [

	(windowHandler newWindowEvent: anEvent) popupEvent: anEvent
]

{ #category : 'adding-removing' }
ToMenu >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	isSubmenu := false.
	self initializeWithMenuConstraints 

	
]

{ #category : 't - menu window model' }
ToMenu >> rootMenu [

	^ super rootMenu
]

{ #category : 'theme event handling' }
ToMenu >> toThemeChanged [ 

	windowHandler toThemeChanged.
	super toThemeChanged.

	
]

{ #category : 'skin' }
ToMenu >> uninstallRawStyle [

	super uninstallRawStyle.
	self isSubmenu ifFalse: [ ^ self ].
	self rightHandSide removeChildren.

]
