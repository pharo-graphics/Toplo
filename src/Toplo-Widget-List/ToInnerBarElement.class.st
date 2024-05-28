Class {
	#name : #ToInnerBarElement,
	#superclass : #ToTripletElement,
	#instVars : [
		'listElement',
		'dataSource',
		'dataSourceObserver',
		'dataSourceManager',
		'scrollable'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'instance creation' }
ToInnerBarElement class >> onBarElement: aBarElement [

	^ self basicNew
		  listElement: aBarElement;
		  initialize
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> addAllHolders: anArray at: aPosition [

	scrollable addAllHolders: anArray at: aPosition.
	anArray do: [ :h | self notifyChildAttached: h node  ]
]

{ #category : #private }
ToInnerBarElement >> checkFullyVisibleNodes [

	| invisibleNodes  |
	scrollable isNodeWrapping ifTrue: [ ^ self ].
	scrollable isNodeScrolling ifTrue: [ ^ self ].
	scrollable isNodeAutoDistribution ifTrue: [ ^ self ].
	invisibleNodes := self nodesSelect: [ :n | n isFullyVisible not ].
	listElement dispatchEvent: (ToBarNodeVisibilityEvent new
			 invisibleNodes: invisibleNodes;
			 yourself)
]

{ #category : #initialization }
ToInnerBarElement >> configureLayoutIn: aListElement [

	self isHorizontal
		ifTrue: [
			self hMatchParent.
			self vFitContent.
			self middleContainer constraintsDo: [ :c |
				c linear vertical alignCenter.
				c horizontal matchParent.
				c vertical fitContent ] ]
		ifFalse: [
			self vMatchParent.
			self hFitContent.
			self middleContainer constraintsDo: [ :c |
				c linear horizontal alignCenter.
				c vertical matchParent.
				c horizontal fitContent ] ].

	scrollable configureLayoutIn: aListElement.
	self installFakeNode
]

{ #category : #accessing }
ToInnerBarElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToInnerBarElement >> dataSourceManager [

	^ dataSourceManager 
]

{ #category : #initialization }
ToInnerBarElement >> defaultDataSource [ 

	^ listElement dataSource.
]

{ #category : #initialization }
ToInnerBarElement >> defaultDataSourceManager [

	^ ToScrollableBarDataSourceManager new
		  innerBarElement: self;
		  yourself
]

{ #category : #initialization }
ToInnerBarElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToScrollableBarDataSourceObserver
]

{ #category : #'t - infinite scrolled event' }
ToInnerBarElement >> disableScrolledEvent [

	scrollable disableScrolledEvent
]

{ #category : #'t - infinite scrolled event' }
ToInnerBarElement >> enableScrolledEvent [

	scrollable enableScrolledEvent
]

{ #category : #'t - children - accessing' }
ToInnerBarElement >> findElementHolderForDataSourcePosition: aPosition [
	"Return the holder for the node in the given position of the data set"

	self nodesDo: [ :aNode |
		| holder |
		holder := aNode holder.
		holder position = aPosition ifTrue: [ ^ holder ] ].
	^ nil
]

{ #category : #'node enumerating' }
ToInnerBarElement >> fullyVisibleNodesDo: aBlock [

	scrollable fullyVisibleNodesDo: aBlock
]

{ #category : #'node enumerating' }
ToInnerBarElement >> fullyVisibleNodesSelect: aBlock [

	^ scrollable fullyVisibleNodesSelect: aBlock
]

{ #category : #initialization }
ToInnerBarElement >> initialize [

	super initialize.
	self initializeDataSource.
	self id: #innerElement.
	scrollable := ToScrollableBarElement new.
	scrollable id: #scrollable.
	self middleElement: scrollable.
	scrollable
		addEventHandlerOn: BlElementScrolledEvent
		do: [ :event | self dispatchEvent: event copy ].
	scrollable
		addEventHandlerOn: ToInfiniteScrollFinishedEvent
		do: [ :event | self dispatchEvent: event copy ].
	self addEventHandler: ToInfiniteElementEventHandler new.

	self matchParent
]

{ #category : #initialization }
ToInnerBarElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> innerContainer [

	^ self
]

{ #category : #initialization }
ToInnerBarElement >> installFakeNode [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| holder fakeNode |
	holder := dataSource createHolder: self.
	holder infiniteElement: self.
	holder bindAtPosition: 0.
	fakeNode := self listElement nodeManager newFakeNodeInHolder: holder.
	fakeNode id: #fakeNode.
	self isHorizontal
		ifTrue: [
			fakeNode constraintsDo: [ :c |
				c horizontal exact: 0.
				c vertical fitContent.
				c flow vertical alignCenter.
				c linear vertical alignCenter ] ]
		ifFalse: [
			fakeNode constraintsDo: [ :c |
				c vertical exact: 0.
				c horizontal fitContent.
				c flow horizontal alignCenter.
				c linear horizontal alignCenter ] ].

	" add the fake node (to keep a constant minimum size ) "
	scrollable addFakeNode: fakeNode
]

{ #category : #accessing }
ToInnerBarElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToInnerBarElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #'instance creation' }
ToInnerBarElement >> newNodeHolderFromDataSource: aDataSource [

	^ self listElement nodeManager newNodeHolder
]

{ #category : #accessing }
ToInnerBarElement >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> nodeGroupsSatisfying: aBlock [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  self partlyVisibleNodesDo: [ :node |
			  (aBlock value: node)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #accessing }
ToInnerBarElement >> nodes [

	^ scrollable nodes
]

{ #category : #'node enumerating' }
ToInnerBarElement >> nodesDo: aBlock [

	scrollable nodesDo: aBlock
]

{ #category : #'node enumerating' }
ToInnerBarElement >> nodesSelect: aBlock [

	^ scrollable nodesSelect: aBlock
]

{ #category : #'node enumerating' }
ToInnerBarElement >> nodesWithIndexDo: aBlock [

	scrollable nodesWithIndexDo: aBlock
]

{ #category : #notifying }
ToInnerBarElement >> notifyChildAttached: anElement [
	"Notify all event handlers that element is attached to the inner bar"

	self dispatchEvent: (BlInfiniteElementAttachedEvent element: anElement)
]

{ #category : #notifying }
ToInnerBarElement >> notifyChildDetached: anElement [
	"Notify all event handlers that element is detached from the inner bar"

	self dispatchEvent: (BlInfiniteElementDetachedEvent element: anElement)
]

{ #category : #'data source updates' }
ToInnerBarElement >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	self nodesDo: [ :node |
		(node holder position
			 between: aPositionStart 
			 and: aPositionStart + anItemCount - 1) ifTrue: [
			node holder changeDataItem: (dataSource at: node holder position) ] ].
	self requestLayout 
]

{ #category : #'data source updates' }
ToInnerBarElement >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	| holder offsetPosition holders |
	holders := Array streamContents: [ :stream |
		           1 to: anItemCount do: [ :idx |
			           holder := self dataSource createHolder: self.
			           offsetPosition := aPositionStart + idx - 1.
			           holder infiniteElement: self.
			           self dataSource bindHolder: holder at: offsetPosition.
			           stream nextPut: holder ] ].
	self addAllHolders: holders at: aPositionStart.
	self updatePositions

]

{ #category : #'data source updates' }
ToInnerBarElement >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	| nodes |
	nodes := self nodesSelect: [ :node |
		         node holder position
			         between: aPositionStart 
			         and: aPositionStart + anItemCount - 1].
	self removeAllNodes: nodes.
	self updatePositions

]

{ #category : #'data source updates' }
ToInnerBarElement >> onItemsChanged [

	| holders |

	self removeAllNodes: self nodes.
	holders := Array streamContents: [ :stream |
		           | holder |
		           1 to: self dataSource itemCount do: [ :idx |
			           holder := self dataSource createHolder: self.
			           holder infiniteElement: self.
			           self dataSource bindHolder: holder at: idx.
			           stream nextPut: holder ] ].
	self addAllHolders: holders at: 1.
	self updatePositions

]

{ #category : #layout }
ToInnerBarElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self checkFullyVisibleNodes
]

{ #category : #'node enumerating' }
ToInnerBarElement >> partlyVisibleNodesDo: aBlock [

	scrollable partlyVisibleNodesDo: aBlock
]

{ #category : #'node enumerating' }
ToInnerBarElement >> partlyVisibleNodesSelect: aBlock [

	^ scrollable partlyVisibleNodesSelect: aBlock
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> removeAllNodes: anArray [ 

	scrollable removeAllNodes: anArray.
	anArray do: [ :node | self notifyChildDetached: node  ]
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> scrollDeltaFromDataSourcePosition: anIndex [

	| node bnds pad |
	node := self nodeAt: anIndex.
	node ifNil: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	pad := listElement isHorizontal
		       ifTrue: [ listElement padding left ]
		       ifFalse: [ listElement padding top ].
	^ bnds position - pad
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> scrollToDataSourcePosition: anIndex [

	(self scrollDeltaFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		scrollable scrollBy: p x negated @ p y ]
]

{ #category : #'accessing - children' }
ToInnerBarElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		(node holder isSelectable and: [ node containsGlobalPoint: aPoint ])
			ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> smoothScrollToDataSourcePosition: anIndex [

	(self scrollDeltaFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		scrollable smoothScrollBy: p x negated @ p y ]
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"
		
	scrollable stopScrollersInternal

	
]

{ #category : #'data source updates' }
ToInnerBarElement >> updatePositions [

	| pos |
	pos := 0.
	self nodesDo: [ :node |
		pos := pos + 1.
		node holder bindAtPosition: pos ]
]
