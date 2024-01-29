Class {
	#name : #ToMenuItem,
	#superclass : #ToGeneralButtonMenuItem,
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#instVars : [
		'filler',
		'rightHandSide'
	],
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

{ #category : #accessing }
ToMenuItem >> filler [ 

	^ filler
]

{ #category : #initialization }
ToMenuItem >> initialize [ 

	super initialize.
	self addStamp: #'menu-item'.
	filler := self newFiller.
	rightHandSide := self newRightHandSide.
	self button addChild: filler.
	self button addChild: rightHandSide
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

{ #category : #accessing }
ToMenuItem >> rightHandSide [

	^ rightHandSide
]
