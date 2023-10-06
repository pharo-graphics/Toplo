Class {
	#name : #ToSeparatorMenuItem,
	#superclass : #ToAbstractMenuItem,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToSeparatorMenuItem >> initialize [ 

	super initialize.

	self hMatchParent.
	self vFitContent.
	self addChild: (ToElement new
			 background: Color lightGray;
			 constraintsDo: [ :c | 
				 c horizontal matchParent.
				 c vertical exact: 1 ]).
	self padding: (BlInsets all: 2)
]
