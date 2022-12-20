Class {
	#name : #ToAbstractMenuItem,
	#superclass : #ToElement,
	#instVars : [
		'parentMenuWindow'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToAbstractMenuItem >> addedInMenu: aMenu [

	self privateParentMenuWindow: aMenu menuWindow.
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

	^ parentMenuWindow 
]

{ #category : #'private - accessing' }
ToAbstractMenuItem >> privateParentMenuWindow: aWindow [

	parentMenuWindow := aWindow
]

{ #category : #initialization }
ToAbstractMenuItem >> removedFromMenu: aMenu [

]
