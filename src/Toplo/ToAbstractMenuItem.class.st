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

{ #category : #initialization }
ToAbstractMenuItem >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.

]

{ #category : #testing }
ToAbstractMenuItem >> isSubmenu [ 

	^ false
]

{ #category : #window }
ToAbstractMenuItem >> menuWindow [

	^ nil
]

{ #category : #window }
ToAbstractMenuItem >> parentMenuWindow [

	^ parentMenu ifNotNil: [:m | m menuWindow ] 
]

{ #category : #'private - accessing' }
ToAbstractMenuItem >> privateParentMenu: aMenu [

	parentMenu := aMenu
]

{ #category : #initialization }
ToAbstractMenuItem >> removedFromMenu: aMenu [

]
