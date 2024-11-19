Class {
	#name : #ToSeparatorMenuItem,
	#superclass : #ToMenuItemElement,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToSeparatorMenuItem >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	aMenu bar unselectableSelecter selectIndex: self positionInMenu
]

{ #category : #initialization }
ToSeparatorMenuItem >> initialize [ 

	super initialize.
	self addChild: (ToElement new
			 background: Color lightGray;
			 constraintsDo: [ :c | 
				 c horizontal matchParent.
				 c vertical exact: 1 ]).
	self padding: (BlInsets all: 2)
]
