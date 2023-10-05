Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'isSubmenu',
		'window'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	isSubmenu := true.
	self initializeWithMenuItemConstraints

]

{ #category : #'t - menu item holder - accessing' }
ToMenu >> client [

	" get parent menu client if none is declared locally "
	^ client ifNil: [ self parentMenu ifNotNil: [ :pm | pm client ] ]
]

{ #category : #'t - menu window model - window opening/closing' }
ToMenu >> close [

	^ self window close
]

{ #category : #initialization }
ToMenu >> defaultEventHandler [
self halt.
	ToMenuWindowModelEventHandlerDep.
	^ ToElementWithPopupWindowEventHandler new 
]

{ #category : #initialization }
ToMenu >> initialize [

	super initialize.
	self initializeMenuItemHolder.
	isSubmenu := false.
	self initializeWithMenuConstraints  
]

{ #category : #initialization }
ToMenu >> initializeWithMenuConstraints [

	self fitContent.

]

{ #category : #testing }
ToMenu >> isSubmenu [

	^ isSubmenu 
]

{ #category : #testing }
ToMenu >> isTopMenu [

	^ self parentMenu isNil
]

{ #category : #'t - menu window model - window opening/closing' }
ToMenu >> popupEvent: anEvent [

	^ self window popupEvent: anEvent
]

{ #category : #'adding-removing' }
ToMenu >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	isSubmenu := false.
	self initializeWithMenuConstraints 

	
]

{ #category : #'theme event handling' }
ToMenu >> toThemeChanged [ 

	super toThemeChanged.
	self window ifNotNil: [ :mw | mw toThemeChanged ]
	
]

{ #category : #'t - menu window model - accessing' }
ToMenu >> window [

	^ window ifNil: [
		  window := ToMenuWindow new
			                associateElement: self;
			                yourself ]
]
