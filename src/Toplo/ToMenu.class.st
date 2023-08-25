Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'submenuDresser',
		'menuWindow'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'adding/removing' }
ToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	submenuDresser ifNil: [ 
		submenuDresser := ToMenuAsSubmenuDresser new.
		self addDresser: submenuDresser ]

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

{ #category : #'t - initialization dresser' }
ToMenu >> defaultDresser [

	^ ToBasicMenuItemDresser next: ToMenuWindowModelDresser new
]

{ #category : #initialization }
ToMenu >> initialize [

	super initialize.
	self initializeMenuItemHolder
]

{ #category : #testing }
ToMenu >> isSubmenu [

	^ submenuDresser notNil
]

{ #category : #testing }
ToMenu >> isTopMenu [

	^ self parentMenu isNil
]

{ #category : #'t - menu window model - accessing' }
ToMenu >> menuWindow [

	^ menuWindow ifNil: [
		  menuWindow := ToMenuWindow new
			                widget: self;
			                yourself ]
]

{ #category : #'t - menu window model - window opening/closing' }
ToMenu >> popupEvent: anEvent [

	^ self menuWindow popupEvent: anEvent
]

{ #category : #'adding/removing' }
ToMenu >> removedFromMenu: aMenu [

	submenuDresser ifNotNil: [ 
		self removeDresser: submenuDresser.
		submenuDresser := nil ].
	super removedFromMenu: aMenu.

	
]

{ #category : #'theme event handling' }
ToMenu >> toThemeChanged [ 

	super toThemeChanged.
	self menuWindow ifNotNil: [ :mw | mw toThemeChanged ]
	
]
