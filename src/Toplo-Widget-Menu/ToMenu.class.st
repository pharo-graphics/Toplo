Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'menuWindow',
		'isSubmenu'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding/removing' }
ToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	isSubmenu := true
]

{ #category : #'t - menu item holder - accessing' }
ToMenu >> client [

	" get parent menu client if none is declared locally "
	^ client ifNil: [ self parentMenu ifNotNil: [ :pm | pm client ] ]
]

{ #category : #'t - menu window model - window opening/closing' }
ToMenu >> close [

	^ self menuWindow close
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
	isSubmenu := false
]

{ #category : #testing }
ToMenu >> isSubmenu [

	^ isSubmenu 
]

{ #category : #testing }
ToMenu >> isTopMenu [

	^ self parentMenu isNil
]

{ #category : #'t - menu window model - accessing' }
ToMenu >> menuWindow [

	^ menuWindow ifNil: [
		  menuWindow := ToMenuWindow new
			                associateElement: self;
			                yourself ]
]

{ #category : #'t - menu window model - window opening/closing' }
ToMenu >> popupEvent: anEvent [

	^ self menuWindow popupEvent: anEvent
]

{ #category : #'adding/removing' }
ToMenu >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	isSubmenu := false

	
]

{ #category : #'theme event handling' }
ToMenu >> toThemeChanged [ 

	super toThemeChanged.
	self menuWindow ifNotNil: [ :mw | mw toThemeChanged ]
	
]
