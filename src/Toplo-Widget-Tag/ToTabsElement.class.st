Class {
	#name : #ToTabsElement,
	#superclass : #ToElement,
	#traits : 'TToTripletElement + TToItemListOwner',
	#classTraits : 'TToTripletElement classTrait + TToItemListOwner classTrait',
	#instVars : [
		'isHorizontal',
		'isStartToEnd'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'accessing - orientation' }
ToTabsElement >> configurationChanged [

	self itemBar horizontal: isHorizontal.
	isHorizontal
		ifTrue: [ self layout beVertical ]
		ifFalse: [ self layout beHorizontal ].
	isStartToEnd
		ifTrue: [ self layout direction: BlLayoutDirection leftToRight ]
		ifFalse: [ self layout direction: BlLayoutDirection rightToLeft ].
	self requestNewSkin
]

{ #category : #initialization }
ToTabsElement >> configureLayout [

	self middleContainer constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ].
	self itemBar configureLayoutIn: self
]

{ #category : #initialization }
ToTabsElement >> defaultEventHandler [

	^ ToTabsElementEventHandler new
]

{ #category : #initialization }
ToTabsElement >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #'accessing - orientation' }
ToTabsElement >> endToStart: aBoolean [

	self startToEnd: aBoolean not
]

{ #category : #'focus requesting' }
ToTabsElement >> focusHolder [

	^ self itemBar
]

{ #category : #accessing }
ToTabsElement >> group [

	^ self itemBar group
]

{ #category : #'accessing - orientation' }
ToTabsElement >> horizontal: aBoolean [

	isHorizontal = aBoolean ifTrue: [ ^ self ].
	isHorizontal := aBoolean.
	self configurationChanged
]

{ #category : #initialization }
ToTabsElement >> initialize [

	super initialize.
	self initializeAsItemBarOwner.
	self initializeAsTripletElementOn: self.
	self middleContainer clipChildren: false.

	self middleElement: self itemBar.

	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ].

	self itemBar
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self dispatchEvent: event copy].

	isStartToEnd := true.
	self horizontal: true.
	self addEventHandler: self defaultEventHandler
]

{ #category : #'accessing - orientation' }
ToTabsElement >> isHorizontal [ 

	^ isHorizontal
]

{ #category : #'accessing - orientation' }
ToTabsElement >> isStartToEnd [ 

	^ isStartToEnd 
]

{ #category : #'accessing - orientation' }
ToTabsElement >> isVertical [ 

	^ self isHorizontal not
]

{ #category : #'t - item list owner - accessing' }
ToTabsElement >> newItemBar [

	^ ToTabBarElement new
]

{ #category : #'instance creation' }
ToTabsElement >> newRawSkin [ 

	^ ToTabsElementSkin new
]

{ #category : #'accessing - orientation' }
ToTabsElement >> startToEnd: aBoolean [

	isStartToEnd = aBoolean ifTrue: [ ^ self ].
	isStartToEnd := aBoolean.
	self configurationChanged
]

{ #category : #'accessing - orientation' }
ToTabsElement >> vertical: aBoolean [

	self horizontal: aBoolean not
]

{ #category : #'t - checkable group owner' }
ToTabsElement >> withStrictCheckingStrategy [

	self itemBar withStrictCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabsElement >> withWeakCheckingStrategy [

	self itemBar withWeakCheckingStrategy
]

{ #category : #'t - checkable group owner' }
ToTabsElement >> withoutCheckingStrategy [

	self itemBar withoutCheckingStrategy
]
