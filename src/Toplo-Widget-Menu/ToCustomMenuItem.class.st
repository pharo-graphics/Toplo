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
ToCustomMenuItem >> onAddedInItemBar: aMenu [

	aMenu onAddedCustomMenuItem: self

]

{ #category : #'adding-removing' }
ToCustomMenuItem >> onRemovedFromItemBar: aMenu [

	aMenu onRemovedCustomMenuItem: self

]
