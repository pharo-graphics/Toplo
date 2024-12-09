Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToMenuItemElement,
	#instVars : [
		'innerElement',
		'builder'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #testing }
ToCustomMenuItem >> isSelectable [

	^ false
]

{ #category : #'adding-removing' }
ToCustomMenuItem >> onAddedInMenuItemContainer: aMenu [

	aMenu onAddedCustomMenuItem: self

]
