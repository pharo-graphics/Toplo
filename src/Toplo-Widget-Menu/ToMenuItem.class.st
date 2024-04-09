Class {
	#name : #ToMenuItem,
	#superclass : #ToGeneralButtonMenuItem,
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuItem >> buttonClass [

	^ ToButton 
]

{ #category : #testing }
ToMenuItem >> closeOnMouseEvent [

	^ self isTopMenu not
]

{ #category : #initialization }
ToMenuItem >> initialize [ 

	super initialize.
	self addStamp: #'menu-item'.
	self endElement: self newRightHandSide
]

{ #category : #'t - element with labeled icon - accessing' }
ToMenuItem >> labeledIcon [ 

	^ self button labeledIcon 
]

{ #category : #initialization }
ToMenuItem >> newFiller [

	^ BlElement new
		  constraintsDo: [ :c |
			  c horizontal exact: 0.
			  c vertical matchParent ];
		  id: #filler;
		  yourself
]

{ #category : #skin }
ToMenuItem >> newRawSkin [

	^ ToMenuItemSkin new
]

{ #category : #initialization }
ToMenuItem >> newRightHandSide [

	| rhs |
	rhs := BlElement new layout: BlLinearLayout horizontal.
	rhs id: #'right-hand-side'.
	rhs constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent.
		c linear vertical alignCenter.
		c linear horizontal alignCenter ].
	^ rhs
]
