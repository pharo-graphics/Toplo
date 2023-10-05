Class {
	#name : #ToMenuItem,
	#superclass : #ToAbstractMenuItem,
	#traits : 'TToElementWithTooltip + TToClickable',
	#classTraits : 'TToElementWithTooltip classTrait + TToClickable classTrait',
	#instVars : [
		'#labeledIcon => ToSkinnableSlot',
		'#filler'
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
	filler := ToElement new id: #'filler'; hMatchParent; vFitContent; background: Color yellow.
	self addChild: labeledIcon.
	self addChild: filler.
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
ToMenuItem >> labelText: aText [

	self labeledIcon label: (ToLabel text: aText)
]

{ #category : #accessing }
ToMenuItem >> labeledIcon [

	^ labeledIcon
]
