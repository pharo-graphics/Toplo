Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToMenuItemElement,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item' }
ToCustomMenuItem >> closeOnPicking [ 

	^ false
]

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
