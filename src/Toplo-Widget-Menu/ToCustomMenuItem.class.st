Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToMenuItemElement,
	#instVars : [
		'innerElement',
		'builder'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToCustomMenuItem >> addedInMenuItemContainer: aMenu [

	aMenu addedCustomMenuItem: self

]

{ #category : #testing }
ToCustomMenuItem >> isSelectable [

	^ false
]
