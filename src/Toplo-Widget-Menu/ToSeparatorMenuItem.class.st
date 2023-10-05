Class {
	#name : #ToSeparatorMenuItem,
	#superclass : #ToAbstractMenuItem,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToSeparatorMenuItem >> addedInMenu: aMenu [

	self privateParentMenu: aMenu.
	self hMatchParent.
	self vFitContent
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
