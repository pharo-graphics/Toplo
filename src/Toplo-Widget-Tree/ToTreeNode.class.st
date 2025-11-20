"
I am a Tree Node,

I visually represent a line of data from a tree structure
"
Class {
	#name : #ToTreeNode,
	#superclass : #ToListNode,
	#traits : 'TToOrientable + TToTripletElement',
	#classTraits : 'TToOrientable classTrait + TToTripletElement classTrait',
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - triplet element - instance creation' }
ToTreeNode >> createStartContainer [

	startContainer := self newLinearContainer
		                  id: #'start-container';
		                  yourself.
	self addChild: startContainer at: 1
]

{ #category : #testing }
ToTreeNode >> hasLeafDataItem [

	^ self holder dataItem hasLeafDataItem
]

{ #category : #initialization }
ToTreeNode >> initialize [

	super initialize.
	self initializeAsTripletElement.
	self hMatchParent.
	self vFitContent.
	self middleContainer constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
	self startElement: ToElement new.
	self startElement layout: BlLinearLayout horizontal.

	self addEventHandlerOn: ToArrowButtonClickedEvent do: [ :event |
			event consume.
			self toggle ]
]

{ #category : #'instance creation' }
ToTreeNode >> initializeStartElement [

	self startElement addChild: self newStartElement 
]

{ #category : #testing }
ToTreeNode >> isLeaf [

	self
		deprecated: 'Use #hasLeafDataItem instead'
		transformWith: '`@rcvr isLeaf' -> '`@rcvr hasLeafDataItem'.
		
	^ self hasLeafDataItem
]

{ #category : #'t - triplet element - instance creation' }
ToTreeNode >> newMiddleContainer [

	^ self newLinearContainer
]

{ #category : #skin }
ToTreeNode >> newRawSkin [ 
	
	^ ToTreeNodeSkin new
]

{ #category : #'instance creation' }
ToTreeNode >> newStartElement [

	| arrowIcon aWrapper |
	aWrapper := self holder dataItem.
	arrowIcon := ToImage new
		             id: #arrowIcon;
		             yourself.
	aWrapper hasLeafDataItem ifFalse: [
			arrowIcon := aWrapper isExpanded
				             ifFalse: [ ToIconicArrowButton right ]
				             ifTrue: [ ToIconicArrowButton down ].
			arrowIcon clickAction: [
				self dispatchEvent: ToArrowButtonClickedEvent new ] ].
	arrowIcon constraintsDo: [ :c |
			c linear horizontal alignLeft.
			c linear vertical alignCenter ].
	^ arrowIcon
]

{ #category : #'instance creation' }
ToTreeNode >> newToConfiguration [ 

	^ ToTripletElementConfiguration new
]

{ #category : #accessing }
ToTreeNode >> nodeDepth [

	^ self holder dataItem nodeDepth
]

{ #category : #testing }
ToTreeNode >> toggle [

	^ self holder dataItem toggle
]
