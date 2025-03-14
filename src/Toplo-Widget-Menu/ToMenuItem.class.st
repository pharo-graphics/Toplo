"
I'm menu item based on triplet element trait (see `TToTripletElement`). 
Basically I'm composed of three subelements a start, a middle and an end part.
"
Class {
	#name : #ToMenuItem,
	#superclass : #ToGeneralButtonMenuItem,
	#traits : 'TToWithOrientableLayout + TToTripletElement + TToLabeledIcon',
	#classTraits : 'TToWithOrientableLayout classTrait + TToTripletElement classTrait + TToLabeledIcon classTrait',
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToMenuItem >> buttonClass [

	^ ToButton 
]

{ #category : #initialization }
ToMenuItem >> initialize [ 

	super initialize.
	self initializeAsTripletElementOn: self button.
	self addStamp: #'menu-item'.
	self endElement: self newRightHandSide
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

{ #category : #'t - with orientable layout - accessing' }
ToMenuItem >> targetLayout [ 

	^ self button targetLayout
]
