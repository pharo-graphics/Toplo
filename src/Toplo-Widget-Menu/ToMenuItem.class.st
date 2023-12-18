Class {
	#name : 'ToMenuItem',
	#superclass : 'ToGeneralButtonMenuItem',
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#instVars : [
		'filler',
		'rightHandSide'
	],
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'initialization' }
ToMenuItem >> buttonClass [

	^ ToButton 
]

{ #category : 'testing' }
ToMenuItem >> closeOnMouseEvent [

	^ self isTopMenu not
]

{ #category : 'accessing' }
ToMenuItem >> filler [ 

	^ filler
]

{ #category : 'initialization' }
ToMenuItem >> initialize [ 

	super initialize.
	self addStamp: #'menu-item'.
	filler := self newFiller.
	rightHandSide := self newRightHandSide.
	filler withoutSkin.
	rightHandSide withoutSkin.
	self button addChild: filler.
	self button addChild: rightHandSide
]

{ #category : 't - element with labeled icon - accessing' }
ToMenuItem >> labeledIcon [ 

	^ self button labeledIcon 
]

{ #category : 'initialization' }
ToMenuItem >> newFiller [

	^ ToElement new
		  hExact: 0;
		  vMatchParent;
		  id: #'menu-item-filler';
		  yourself
]

{ #category : 'skin' }
ToMenuItem >> newRawSkin [

	^ ToMenuItemSkin new
]

{ #category : 'initialization' }
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

{ #category : 'accessing' }
ToMenuItem >> rightHandSide [

	^ rightHandSide
]
