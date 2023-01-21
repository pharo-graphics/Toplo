Class {
	#name : #ToAbstractMenuItem,
	#superclass : #ToElement,
	#instVars : [
		'parentMenu'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToAbstractMenuItem >> addedInMenu: aMenu [

	self privateParentMenu: aMenu.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #'t - menu window' }
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
	self layout: BlLinearLayout horizontal.

]

{ #category : #'t - menu window' }
ToAbstractMenuItem >> parentMenu [

	 ^ parentMenu
]

{ #category : #'t - menu window' }
ToAbstractMenuItem >> parentMenuWindow [

	^ parentMenu ifNotNil: [:m | m subMenuWindow ] 
]

{ #category : #'t - menu window' }
ToAbstractMenuItem >> privateParentMenu: aMenu [

	parentMenu := aMenu
]

{ #category : #initialization }
ToAbstractMenuItem >> removedFromMenu: aMenu [

	self privateParentMenu: nil
]

{ #category : #window }
ToAbstractMenuItem >> subMenuWindow [

	" by default, a menuItem do not open a submenu "
	^ nil
]
