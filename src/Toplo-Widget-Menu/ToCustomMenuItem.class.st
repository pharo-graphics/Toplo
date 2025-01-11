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
ToCustomMenuItem >> onAddedInItemBar: aMenuItemBar [

	aMenuItemBar onAddedCustomMenuItem: self

]

{ #category : #'adding-removing' }
ToCustomMenuItem >> onRemovedFromItemBar: aMenuItemBar [

	aMenuItemBar onRemovedCustomMenuItem: self

]
