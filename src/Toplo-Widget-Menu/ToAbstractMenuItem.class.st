Class {
	#name : #ToAbstractMenuItem,
	#superclass : #ToElement,
	#instVars : [
		'parentMenu'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToAbstractMenuItem >> addedInMenu: aMenu [

	self parentMenu: aMenu
]

{ #category : #testing }
ToAbstractMenuItem >> hasIcon [

	^ false
]

{ #category : #testing }
ToAbstractMenuItem >> includes: anElement [

	self allChildrenBreadthFirstDo: [ :e | e = anElement ifTrue: [ ^ true ] ].
	^ false

]

{ #category : #initialization }
ToAbstractMenuItem >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self addEventHandler: ToMenuItemEventHandler new
]

{ #category : #testing }
ToAbstractMenuItem >> isSubmenu [ 

	^ false
]

{ #category : #testing }
ToAbstractMenuItem >> isTopMenu [

	^ false
]

{ #category : #'parent menu' }
ToAbstractMenuItem >> parentMenu [

	 ^ parentMenu
]

{ #category : #'parent menu' }
ToAbstractMenuItem >> parentMenu: aMenu [

	parentMenu := aMenu
]

{ #category : #'parent menu' }
ToAbstractMenuItem >> parentMenuWindow [

	^ parentMenu ifNotNil: [:m | m associateWindow ] 
]

{ #category : #'adding-removing' }
ToAbstractMenuItem >> removedFromMenu: aMenu [

	self parentMenu: nil
]

{ #category : #window }
ToAbstractMenuItem >> window [

	" by default, a menuItem do not open a submenu "
	^ nil
]
