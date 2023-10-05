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

	self privateParentMenu: aMenu
]

{ #category : #'parent menu' }
ToAbstractMenuItem >> allParentMenusDo: aBlock [
	
	| pm |
	pm := self parentMenu.
	pm ifNil: [ ^ self ].
	aBlock value: pm.
	pm allParentMenusDo: aBlock
]

{ #category : #accessing }
ToAbstractMenuItem >> columnWidth [

	^ self parentMenu ifNil: [ 0 ] ifNotNil: [:pm | pm columnWidth ]
]

{ #category : #initialization }
ToAbstractMenuItem >> defaultEventHandler [

	^ nil
]

{ #category : #testing }
ToAbstractMenuItem >> hasIcon [

	^ false
]

{ #category : #accessing }
ToAbstractMenuItem >> icon: anElement [
]

{ #category : #initialization }
ToAbstractMenuItem >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal
]

{ #category : #testing }
ToAbstractMenuItem >> isSubmenu [ 

	^ false
]

{ #category : #testing }
ToAbstractMenuItem >> isTopMenu [

	^ false
]

{ #category : #window }
ToAbstractMenuItem >> menuWindow [

	" by default, a menuItem do not open a submenu "
	^ nil
]

{ #category : #'parent menu' }
ToAbstractMenuItem >> parentMenu [

	 ^ parentMenu
]

{ #category : #'parent menu' }
ToAbstractMenuItem >> parentMenuWindow [

	^ parentMenu ifNotNil: [:m | m menuWindow ] 
]

{ #category : #'parent menu' }
ToAbstractMenuItem >> privateParentMenu: aMenu [

	parentMenu := aMenu
]

{ #category : #'adding-removing' }
ToAbstractMenuItem >> removedFromMenu: aMenu [

	self privateParentMenu: nil
]
