Class {
	#name : #ToMenuItem,
	#superclass : #ToAbstractMenuItem,
	#traits : 'TToElementWithTooltip + TToClickable',
	#classTraits : 'TToElementWithTooltip classTrait + TToClickable classTrait',
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
ToMenuItem >> defaultEventHandler [ 

	ToMenuItemEventHandlerDep.
	^ super defaultEventHandler
]

{ #category : #initialization }
ToMenuItem >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #accessing }
ToMenuItem >> filler [ 

	^ filler
]

{ #category : #accessing }
ToMenuItem >> icon [

	^ self labeledIcon icon
]

{ #category : #accessing }
ToMenuItem >> icon: aToImage [

	self labeledIcon icon: aToImage
]

{ #category : #initialization }
ToMenuItem >> initialize [ 

	super initialize.
	self withStamp: #'menu-item'.
	self layout: self defaultLayout.
	labeledIcon := ToLabeledIcon new "interspace: #flexible; matchParent".
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

{ #category : #accessing }
ToMenuItem >> label [

	^ self labeledIcon label
]

{ #category : #accessing }
ToMenuItem >> label: aToLabel [

	self labeledIcon label: aToLabel
]

{ #category : #accessing }
ToMenuItem >> labelOffset: aNumber [

	self labeledIcon labelOffset: aNumber
]

{ #category : #accessing }
ToMenuItem >> labelText: aText [

	self labeledIcon label: (ToLabel text: aText)
]

{ #category : #accessing }
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
