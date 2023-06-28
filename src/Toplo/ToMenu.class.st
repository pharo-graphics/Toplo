Class {
	#name : #ToMenu,
	#superclass : #ToButtonMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'submenuDresser'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - menu initialization' }
ToMenu >> addedAsSubmenuInMenu: aMenu [

	submenuDresser ifNil: [ 
		submenuDresser := ToMenuAsSubmenuDresser new.
		self addDresser: submenuDresser ]

]

{ #category : #'t - menu initialization' }
ToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	self addedAsSubmenuInMenu: aMenu
]

{ #category : #'t - menu accessing' }
ToMenu >> client [

	" get parent menu client if none is declared locally "
	^ client ifNil: [ self parentMenu ifNotNil: [ :pm | pm client ] ]
]

{ #category : #'t - initialization dresser' }
ToMenu >> defaultDresser [

	^ ToBasicMenuItemDresser next: (ToMenuWindowModelDresser next: ToMenuDresser new)
]

{ #category : #initialization }
ToMenu >> initialize [

	super initialize.

	self initializeMenuItemHolder.
	self initializeMenuWindowModel

]

{ #category : #'t - menu testing' }
ToMenu >> isSubmenu [

	^ submenuDresser notNil
]

{ #category : #'t - menu initialization' }
ToMenu >> removedAsSubmenuInMenu: aMenu [

	submenuDresser ifNotNil: [ 
		self removeDresser: submenuDresser.
		submenuDresser := nil ]
]

{ #category : #'t - menu item adding/removing' }
ToMenu >> removedFromMenu: aMenu [

	self removedAsSubmenuInMenu: aMenu.
	super removedFromMenu: aMenu.

	
]
