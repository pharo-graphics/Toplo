"
I am a Tree Node,

I visually represent a line of data from a tree structure
"
Class {
	#name : #ToTreeNode,
	#superclass : #ToListNode,
	#traits : 'TToOrientable + TToTripletContainer',
	#classTraits : 'TToOrientable classTrait + TToTripletContainer classTrait',
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - triplet container - instance creation' }
ToTreeNode >> createStartContainer [

	startContainer := self newLinearContainer
		                  id: #'start-container';
		                  yourself.
	self addChild: startContainer at: 1
]

{ #category : #testing }
ToTreeNode >> hasLeafDataItem [

	^ self holder dataWrapper hasLeafDataItem
]

{ #category : #'instance creation' }
ToTreeNode >> indentFiller [

	^ self startContainer childWithId: #indentFiller
]

{ #category : #accessing }
ToTreeNode >> indentWidth: aNumber [

	self indentFiller width: aNumber
]

{ #category : #initialization }
ToTreeNode >> initialize [

	super initialize.
	self initializeAsTripletContainer.
	self createStartContainer.
	self hMatchParent.
	self vFitContent.
	self middleContainer constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
	self addEventHandlerOn: ToArrowButtonClickedEvent do: [ :event |
			event consume.
			self toggle ]
]

{ #category : #'instance creation' }
ToTreeNode >> initializeStartContainer [


	self startContainer addChild: self newIndentFiller.
	self startContainer addChild: self newArrowIcon.

]

{ #category : #testing }
ToTreeNode >> isLeaf [

	self
		deprecated: 'Use #hasLeafDataItem instead'
		transformWith: '`@rcvr isLeaf' -> '`@rcvr hasLeafDataItem'.
		
	^ self hasLeafDataItem
]

{ #category : #'instance creation' }
ToTreeNode >> newArrowIcon [

	| arrowIcon aWrapper |
	aWrapper := self holder dataWrapper.
	arrowIcon := ToIconicArrowButton none.
	aWrapper hasLeafDataItem ifFalse: [
			arrowIcon := aWrapper isExpanded
				             ifFalse: [ ToIconicArrowButton right ]
				             ifTrue: [ ToIconicArrowButton down ].
			arrowIcon clickAction: [
				self dispatchEvent: ToArrowButtonClickedEvent new ] ].

	arrowIcon id: #arrowIcon.
	arrowIcon constraintsDo: [ :c |
			c linear horizontal alignLeft.
			c linear vertical alignCenter ].
	^ arrowIcon
]

{ #category : #'instance creation' }
ToTreeNode >> newIndentFiller [

	^ self newFiller
		  id: #indentFiller;
		  background: Color red
]

{ #category : #'t - triplet container - instance creation' }
ToTreeNode >> newMiddleContainer [

	^ self newLinearContainer
]

{ #category : #skin }
ToTreeNode >> newRawSkin [ 
	
	^ ToTreeNodeSkin new
]

{ #category : #'instance creation' }
ToTreeNode >> newToConfiguration [ 

	^ ToTripletContainerConfiguration new
]

{ #category : #accessing }
ToTreeNode >> nodeDepth [

	^ self holder dataWrapper nodeDepth
]

{ #category : #testing }
ToTreeNode >> toggle [

	^ self holder dataWrapper toggle
]
