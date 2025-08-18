Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToMenuItemElement,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToCustomMenuItem >> initialize [ 

	super initialize.
	closeOnPicking := false
]

{ #category : #testing }
ToCustomMenuItem >> isSelectable [

	^ false
]

{ #category : #'adding-removing' }
ToCustomMenuItem >> onAddedInItemBarOwner: aMenu [

	aMenu onAddedCustomMenuItem: self

]

{ #category : #'adding-removing' }
ToCustomMenuItem >> onRemovedFromItemBarOwner: aMenu [

	aMenu onRemovedCustomMenuItem: self

]
