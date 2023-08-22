Class {
	#name : #ToAbstractMenuItem,
	#superclass : #ToElement,
	#instVars : [
		'parentMenu'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'adding/removing' }
ToAbstractMenuItem >> addedInMenu: aMenu [

	self privateParentMenu: aMenu.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #'parent menu' }
ToAbstractMenuItem >> allParentMenusDo: aBlock [
	
	| pm |
	pm := self parentMenu.
	pm ifNil: [ ^ self ].
	aBlock value: pm.
	pm allParentMenusDo: aBlock
]

{ #category : #'t - pair presentation' }
ToAbstractMenuItem >> columnWidth: anInteger [
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

{ #category : #'accessing sizing' }
ToAbstractMenuItem >> largeHeight [ 

	^ 32
]

{ #category : #window }
ToAbstractMenuItem >> menuWindow [

	" by default, a menuItem do not open a submenu "
	^ nil
]

{ #category : #'accessing sizing' }
ToAbstractMenuItem >> middleHeight [

	^ 24
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

{ #category : #'adding/removing' }
ToAbstractMenuItem >> removedFromMenu: aMenu [

	self privateParentMenu: nil
]

{ #category : #'accessing sizing' }
ToAbstractMenuItem >> smallHeight [ 

	^ 18
]
