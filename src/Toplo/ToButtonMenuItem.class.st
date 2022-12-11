Class {
	#name : #ToButtonMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToButton',
	#classTraits : 'TToButton classTrait',
	#instVars : [
		'#buttonPane',
		'#label',
		'#icon',
		'#rightPane',
		'#rightFill'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToButtonMenuItem >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	self iconImage: self emptyIconImage.
	rightPane addChild: self rightIconImage 
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> buttonPane [

	^ buttonPane
]

{ #category : #initialization }
ToButtonMenuItem >> emptyIconImage [

	^ BlElement new size: 16@16;background: Color random; 
		constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ];
		yourself.
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> icon [

	^ icon
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> icon: anImage [

	icon := anImage 
]

{ #category : #initialization }
ToButtonMenuItem >> initialize [

	super initialize.
	
	"self layout: BlLinearLayout horizontal."
	self layout:  (BlGridLayout new columnCount: 2; cellSpacing: 2).
	self fitContent.
	buttonPane := ToHorizontalPane new.
	self addChild: buttonPane.
	buttonPane constraintsDo: [ :c | c grid horizontal weight: 0.3 ].
	self initializeButton.
	
	rightPane := ToHorizontalPane new.
	rightPane constraintsDo: [ :c | c grid horizontal weight: 0.7 ].
	"rightFill := self privateFill."
	"rightFill width: 10."
	"self addChild: rightFill."
	self addChild: rightPane.
	self initializeRightPane.

	self beIconFirst.

	self initializeDresser 
	
]

{ #category : #initialization }
ToButtonMenuItem >> initializeRightPane [

	rightPane layout: BlLinearLayout horizontal.
	rightPane constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ].
	rightPane fitContent.	
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> label [

	^ label
]

{ #category : #'t - button accessing' }
ToButtonMenuItem >> label: aLabel [

	label := aLabel
	
]

{ #category : #initialization }
ToButtonMenuItem >> rightIconImage [

	^ self emptyIconImage 
	
]
