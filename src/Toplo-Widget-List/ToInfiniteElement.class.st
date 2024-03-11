Class {
	#name : #ToInfiniteElement,
	#superclass : #BlInfiniteElement,
	#traits : 'TBlLayoutResizable',
	#classTraits : 'TBlLayoutResizable classTrait',
	#instVars : [
		'layoutMonitor',
		'nodeHolderClass',
		'nodeClass',
		'listElement'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'as yet unclassified' }
ToInfiniteElement >> aeDrawItemDecorationsOn: aCanvas [

	self layoutCritical: [ super aeDrawItemDecorationsOn: aCanvas ]
]

{ #category : #accessing }
ToInfiniteElement >> dataAccessor [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToInfiniteElement >> defaultLayout [

	^ BlInfiniteLinearLayout new
]

{ #category : #initialization }
ToInfiniteElement >> defaultMouseScrollEventHandler [

	^ BlInfiniteMouseScrollListener new
		  restrictedByOrientation: true;
		  yourself
]

{ #category : #initialization }
ToInfiniteElement >> defaultNodeBuilder [

	^ [ :node :holder |
	  node addChild: (ToLabel text: holder dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToInfiniteElement >> defaultScrollFlinger [
	"Return class, actuall instantiation happens in initialize"
	^ ToInfiniteScrollFlinger
]

{ #category : #'scrolled event' }
ToInfiniteElement >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #layout }
ToInfiniteElement >> dispatchLayout [

	self layoutCritical: [ super dispatchLayout ]
]

{ #category : #'scrolled event' }
ToInfiniteElement >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent 
]

{ #category : #'t - infinite accessing' }
ToInfiniteElement >> infinite [ 

	^ self
]

{ #category : #initialization }
ToInfiniteElement >> initialize [

	super initialize.

	layoutMonitor := Monitor new.
	self matchParent
]

{ #category : #accessing }
ToInfiniteElement >> layoutCritical: aBlock [
			
	layoutMonitor critical: aBlock
]

{ #category : #accessing }
ToInfiniteElement >> listElement [

	^ listElement
]

{ #category : #initialization }
ToInfiniteElement >> newNode [

	^ self nodeClass new
]

{ #category : #'instance creation' }
ToInfiniteElement >> newNodeHolderFromDataSource: aDataSource [

	^ self nodeHolderClass new infiniteElement: self
]

{ #category : #accessing }
ToInfiniteElement >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #initialization }
ToInfiniteElement >> nodeClass [

	^ nodeClass ifNil: [ nodeClass := ToNode ]
]

{ #category : #initialization }
ToInfiniteElement >> nodeClass: aNodeClass [

	nodeClass := aNodeClass
]

{ #category : #'accessing - children' }
ToInfiniteElement >> nodeContainingGlobalPosition: aPoint [

	self childrenDo: [ :node |
		(node containsGlobalPoint: aPoint) ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #'accessing - nodes' }
ToInfiniteElement >> nodeGroupsSatisfying: aBlock [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	self layoutCritical: [
		^ Array streamContents: [ :stream |
			  | g |
			  g := OrderedCollection new.
			  self childrenDo: [ :node |
				  (aBlock value: node)
					  ifTrue: [ g add: node ]
					  ifFalse: [
						  g ifNotEmpty: [
							  stream nextPut: g.
							  g := OrderedCollection new ] ] ].
			  g ifNotEmpty: [ stream nextPut: g ] ] ]
]

{ #category : #accessing }
ToInfiniteElement >> nodeHolderBuilder [

	^ [ :theHolder |
	  | newNode |
	  newNode := self newNode.
	  theHolder node: newNode ]
]

{ #category : #initialization }
ToInfiniteElement >> nodeHolderClass [

	^ nodeHolderClass ifNil: [nodeHolderClass := ToNodeHolder ]
]

{ #category : #initialization }
ToInfiniteElement >> nodeHolderClass: aNodeHolderClass [

	nodeHolderClass := aNodeHolderClass
]

{ #category : #'api - hooks' }
ToInfiniteElement >> onInstalledIn: aListElement [

	listElement := aListElement
]

{ #category : #'t - resizeable' }
ToInfiniteElement >> resizableConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	
	Can be basically defined with #constraintsDo: aBlock.
	
	Introduced a an explicit requirement to let user
	implement additional actions when resizing is changed
	
	"
	self constraintsDo: aBlock
]

{ #category : #private }
ToInfiniteElement >> scrollToDataSourcePosition: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"

	self scrollToPosition: anIndex.

	"aWish smooth
		ifTrue: [ self listElement smoothScrollToPosition: aWish index ]
		ifFalse: [ self listElement scrollToPosition: aWish index ]"
]

{ #category : #private }
ToInfiniteElement >> scrollToIndex: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"

	self scrollToPosition: anIndex.

	"aWish smooth
		ifTrue: [ self listElement smoothScrollToPosition: aWish index ]
		ifFalse: [ self listElement scrollToPosition: aWish index ]"
]

{ #category : #private }
ToInfiniteElement >> scrollToIndexAtTop: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"
	"As a result, item at anIndex is positionned at the top of the listElement"

	self scrollToPosition: anIndex offset: self layout computeExtraLayoutSpace y.
]
