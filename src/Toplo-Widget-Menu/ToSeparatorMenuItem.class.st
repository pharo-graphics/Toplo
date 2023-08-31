Class {
	#name : #ToSeparatorMenuItem,
	#superclass : #ToAbstractMenuItem,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding/removing' }
ToSeparatorMenuItem >> addedInMenu: aMenu [

	self privateParentMenu: aMenu.
	self hMatchParent.
	self vFitContent
]

{ #category : #'t - initialization dresser' }
ToSeparatorMenuItem >> defaultDresser [ 

	^ ToSeparatorMenuItemDresser new
]
