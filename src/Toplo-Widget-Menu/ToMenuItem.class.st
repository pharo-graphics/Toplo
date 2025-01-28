"
I'm menu item based on triplet element trait (see `TToTripletElement`). 
Basically I'm composed of three subelements a start, a middle and an end part.
"
Class {
	#name : #ToMenuItem,
	#superclass : #ToGeneralButtonMenuItem,
	#traits : 'TToOrientable + TToTripletElement + TToLabeledIcon',
	#classTraits : 'TToOrientable classTrait + TToTripletElement classTrait + TToLabeledIcon classTrait',
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #initialization }
ToMenuItem >> buttonClass [

	^ ToButton 
]

{ #category : #initialization }
ToMenuItem >> initialize [ 

	super initialize.
	self addStamp: #'menu-item'.
	self endElement: self newRightHandSide
]

{ #category : #'t - orientable - accessing' }
ToMenuItem >> layoutStrategy [

	^ self layout

	
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

{ #category : #layout }
ToMenuItem >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	"self configureLayout."
	super onLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #'t - triplet element - private - accessing' }
ToMenuItem >> tripletProperties [

	^ self button tripletProperties
]

{ #category : #'t - triplet element - private - accessing' }
ToMenuItem >> tripletProperties: aTripletElementProperties [

	self shouldNotImplement 
]
