Class {
	#name : #ToMenuItem,
	#superclass : #ToAbstractMenuItem,
	#traits : 'TToElementWithTooltip + TToClickable + TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithTooltip classTrait + TToClickable classTrait + TToElementWithLabeledIcon classTrait',
	#instVars : [
		'#labeledIcon => ToSkinnableSlot',
		'#filler',
		'#rightHandSide'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - clickable - click behavior' }
ToMenuItem >> clickEventClass [

	^ BlMouseUpEvent
]

{ #category : #initialization }
ToMenuItem >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #accessing }
ToMenuItem >> filler [ 

	^ filler
]

{ #category : #initialization }
ToMenuItem >> initialize [ 

	super initialize.
	self withStamp: #'menu-item'.
	self layout: self defaultLayout.
	labeledIcon := ToLabeledIcon new .
	filler := self newFiller.
	rightHandSide := self newRightHandSide.
	self addChild: labeledIcon.
	self addChild: filler.
	self addChild: rightHandSide.
	self initializeWithMenuItemConstraints

]

{ #category : #initialization }
ToMenuItem >> initializeWithMenuItemConstraints [ 

	self hMatchParent.
	self vFitContent.

]

{ #category : #'t - element with labeled icon - accessing' }
ToMenuItem >> labeledIcon [ 

	^ labeledIcon 
]

{ #category : #initialization }
ToMenuItem >> newFiller [

	^ ToElement new
		  matchParent;
		  id: #'menu-item-filler';
		  yourself
]

{ #category : #initialization }
ToMenuItem >> newRightHandSide [

	| rhs |
	rhs := ToElement new layout: BlLinearLayout horizontal.
	rhs id: #'right-hand-side'.
	rhs constraintsDo: [ :c |
						 c linear vertical alignCenter.
						 c linear horizontal alignCenter ].
	rhs fitContent.
	^ rhs
]

{ #category : #accessing }
ToMenuItem >> rightHandSide [

	^ rightHandSide
]
