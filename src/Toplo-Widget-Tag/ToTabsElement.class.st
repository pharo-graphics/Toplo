Class {
	#name : #ToTabsElement,
	#superclass : #ToElement,
	#traits : 'TToItemListOwner',
	#classTraits : 'TToItemListOwner classTrait',
	#instVars : [
		'isHorizontal'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #accessing }
ToTabsElement >> beEndToStart [

	self layout direction: BlLayoutDirection rightToLeft.
	self requestInnerConfiguration 
]

{ #category : #accessing }
ToTabsElement >> beStartToEnd [

	self layout direction: BlLayoutDirection leftToRight.
	self requestInnerConfiguration 
]

{ #category : #configuration }
ToTabsElement >> configureLayout [

	super configureLayout.
	self isHorizontal
		ifFalse: [ self layout beHorizontal ]
		ifTrue: [ self layout beVertical ].
	self itemBar horizontal: self isHorizontal.
	self itemBar matchParent.
	self isHFitContent
		ifTrue: [ self itemBar hFitContent ]
		ifFalse: [ self itemBar hMatchParent ].
	self isVFitContent
		ifTrue: [ self itemBar vFitContent ]
		ifFalse: [ self itemBar vMatchParent ].
]

{ #category : #initialization }
ToTabsElement >> defaultEventHandler [

	^ ToTabsElementEventHandler new
]

{ #category : #initialization }
ToTabsElement >> defaultLayout [ 

	^ BlLinearLayout new
]

{ #category : #'focus requesting' }
ToTabsElement >> focusHolder [

	^ self itemBar
]

{ #category : #accessing }
ToTabsElement >> group [

	^ self itemBar group
]

{ #category : #accessing }
ToTabsElement >> horizontal: aBoolean [

	isHorizontal = aBoolean ifTrue: [ ^ self ].
	isHorizontal := aBoolean.
	self requestNewSkin.
	self requestInnerConfiguration 
]

{ #category : #initialization }
ToTabsElement >> initialize [

	super initialize.
	self initializeAsItemBarOwner.
	self addChild: self itemBar.

	self group
		addEventHandlerOn: ToCheckableGroupChangedEvent
		do: [ :event | self dispatchEvent: event ].

	self itemBar
		addEventHandlerOn: ToListSelectionChangedEvent
		do: [ :event | self dispatchEvent: event copy].

	self isHorizontal: true.
	self addEventHandler: self defaultEventHandler.
	self clipChildren: false
]

{ #category : #accessing }
ToTabsElement >> isHorizontal [ 

	^ isHorizontal
]

{ #category : #accessing }
ToTabsElement >> isHorizontal: aBoolean [

	self horizontal: aBoolean
]

{ #category : #accessing }
ToTabsElement >> isStartToEnd [ 

	^ self layout direction isLeftToRight 
]

{ #category : #accessing }
ToTabsElement >> isVertical [ 

	^ self isHorizontal not
]

{ #category : #'t - item list owner - accessing' }
ToTabsElement >> newItemBar [

	^ ToTabBarElement new
]

{ #category : #skin }
ToTabsElement >> newRawSkin [ 

	^ ToTabsElementSkin new
]

{ #category : #accessing }
ToTabsElement >> startToEnd: aBoolean [

	aBoolean
		ifTrue: [ self beStartToEnd ]
		ifFalse: [ self beEndToStart ]
]

{ #category : #accessing }
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
