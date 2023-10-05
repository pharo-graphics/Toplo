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
	filler id: #'menu-item-filler'.
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

	^ ToElement new matchParent
]
