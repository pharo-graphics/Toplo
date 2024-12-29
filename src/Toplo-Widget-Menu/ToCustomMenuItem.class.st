Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToMenuItemElement,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #testing }
ToCustomMenuItem >> isSelectable [

	^ false
]

{ #category : #'adding-removing' }
ToCustomMenuItem >> onAddedInItemListHolder: aMenu [

	aMenu onAddedCustomMenuItem: self

]

{ #category : #'adding-removing' }
ToCustomMenuItem >> onRemovedFromItemListHolder: aMenu [

	aMenu onRemovedCustomMenuItem: self

]
