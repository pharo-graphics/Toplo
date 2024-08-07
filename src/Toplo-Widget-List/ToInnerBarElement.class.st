Class {
	#name : #ToInnerBarElement,
	#superclass : #ToTripletElement,
	#instVars : [
		'listElement',
		'dataSource',
		'dataSourceObserver',
		'dataSourceManager'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'instance creation' }
ToInnerBarElement class >> onBarElement: aBarElement [

	^ self basicNew
		  onBarElement: aBarElement;
		  initialize
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> addAllHolders: anArray at: aPosition [

	self scrollableElement addAllHolders: anArray at: aPosition.
	anArray do: [ :h | self notifyChildAttached: h node  ]
]

{ #category : #layout }
ToInnerBarElement >> checkFullyVisibleNodes [

	| invisibleNodes |
	self scrollableElement isNodeWrapping ifTrue: [ ^ self ].
	self scrollableElement isNodeScrolling ifTrue: [ ^ self ].
	self scrollableElement isNodeAutoDistribution ifTrue: [ ^ self ].
	invisibleNodes := self nodesSelect: [ :n | n isFullyVisible not ].
	listElement dispatchEvent: (ToBarNodeVisibilityEvent new
			 invisibleNodes: invisibleNodes;
			 yourself)
]

{ #category : #layout }
ToInnerBarElement >> configureLayoutIn: aBarElement [

	self matchParent.
	aBarElement isHMatchParent ifFalse: [ self hFitContent ].
	aBarElement isVMatchParent ifFalse: [ self vFitContent ].
	self scrollableElement configureLayoutIn: aBarElement
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

	^ ToInnerBarDataSourceManager new
		  innerBarElement: self;
		  yourself
]

{ #category : #initialization }
ToInnerBarElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToInnerBarDataSourceObserver
]

{ #category : #'t - infinite scrolled event' }
ToInnerBarElement >> disableScrolledEvent [

	self scrollableElement disableScrolledEvent
]

{ #category : #'t - infinite scrolled event' }
ToInnerBarElement >> enableScrolledEvent [

	self scrollableElement enableScrolledEvent
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> fakeNode [

	^ self scrollableElement fakeNode
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

	self scrollableElement fullyVisibleNodesDo: aBlock
]

{ #category : #'node enumerating' }
ToInnerBarElement >> fullyVisibleNodesSelect: aBlock [

	^ self scrollableElement fullyVisibleNodesSelect: aBlock
]

{ #category : #initialization }
ToInnerBarElement >> initialize [ 

	super initialize.
	self initializeDataSource.
	self addEventHandler: ToListInnerContainerEventHandler new.
	self middleElement: ToScrollableBarTrackElement new.
	self scrollableElement trackElement: self middleElement.
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
	holder dataItem: self nodeManager fakeDataItem.
	holder bindAtPosition: 0.
	fakeNode := self nodeManager newNodeForHolder: holder.
	" add the fake node (to keep a constant minimum size ) "
	self scrollableElement addFakeNode: fakeNode.
	self nodeManager buildFakeNode: fakeNode inHolder: holder.
	fakeNode id: #fakeNode.


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
ToInnerBarElement >> newMiddleContainer [

	^ self newScrollableBarElement
]

{ #category : #'instance creation' }
ToInnerBarElement >> newNodeHolderFromDataSource: aDataSource [

	^ listElement nodeManager newNodeHolder
]

{ #category : #initialization }
ToInnerBarElement >> newScrollableBarElement [

	^ ToScrollableBarElement onInnerBarElement: self.
]

{ #category : #'accessing - nodes' }
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
ToInnerBarElement >> nodeManager [

	^ self listElement nodeManager
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> nodes [

	^ self scrollableElement nodes
]

{ #category : #'node enumerating' }
ToInnerBarElement >> nodesDo: aBlock [

	self scrollableElement nodesDo: aBlock
]

{ #category : #'node enumerating' }
ToInnerBarElement >> nodesSelect: aBlock [

	^ self scrollableElement nodesSelect: aBlock
]

{ #category : #'node enumerating' }
ToInnerBarElement >> nodesWithIndexDo: aBlock [

	self scrollableElement nodesWithIndexDo: aBlock
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

{ #category : #initialization }
ToInnerBarElement >> onBarElement: aListElement [

	listElement ifNotNil: [ BlImmutableObjectChangeError signal ].
	self listElement: aListElement
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
	self checkFullyVisibleNodes.
	"self class name trace. ' ' trace. 'onLayout: context:' traceCr"
]

{ #category : #'node enumerating' }
ToInnerBarElement >> partlyVisibleNodesDo: aBlock [

	self scrollableElement partlyVisibleNodesDo: aBlock
]

{ #category : #'node enumerating' }
ToInnerBarElement >> partlyVisibleNodesSelect: aBlock [

	^ self scrollableElement partlyVisibleNodesSelect: aBlock
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> removeAllNodes: anArray [ 

	self scrollableElement removeAllNodes: anArray.
	anArray do: [ :node | self notifyChildDetached: node  ]
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> scrollDeltaFromDataSourcePosition: anIndex [

	| node bnds pad |
	node := self nodeAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisible ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	pad := listElement isHorizontal
		       ifTrue: [ listElement padding left ]
		       ifFalse: [ listElement padding top ].
	^ bnds position - pad
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> scrollDeltaTowardEndFromDataSourcePosition: anIndex [

	| node bnds offset padding |
	node := self nodeAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisible ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	padding := listElement padding.
	offset := listElement isHorizontal
		          ifTrue: [ padding right - listElement width + bnds width ]
		          ifFalse: [
		          padding bottom - listElement height + bnds height ].
	^ bnds position + offset
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> scrollDeltaTowardStartFromDataSourcePosition: anIndex [

	| node bnds pad |
	node := self nodeAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisible ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	pad := listElement isHorizontal
		       ifTrue: [ listElement padding left ]
		       ifFalse: [ listElement padding top ].
	^ bnds position - pad
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> scrollToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollableElement scrollBy: p x negated @ p y ]
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> scrollTowardEndToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollableElement scrollBy: p x negated @ p y ]
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> scrollTowardStartToDataSourcePosition: anIndex [

	(self scrollDeltaTowardStartFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollableElement scrollBy: p x negated @ p y ]
]

{ #category : #accessing }
ToInnerBarElement >> scrollableElement [

	^ self middleContainer
]

{ #category : #'accessing - children' }
ToInnerBarElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		((node containsGlobalPoint: aPoint) and: [ node holder isSelectable ])
			ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> smoothScrollToDataSourcePosition: anIndex [

	(self scrollDeltaFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollableElement smoothScrollBy: p x negated @ p y ]
]

{ #category : #'t - infinite accessing' }
ToInnerBarElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"
		
	self scrollableElement stopScrollersInternal

	
]

{ #category : #initialization }
ToInnerBarElement >> uninstallFakeNode [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	" remove the fake node (to keep a constant minimum size ) "
	self scrollableElement removeFakeNode
]

{ #category : #'data source updates' }
ToInnerBarElement >> updatePositions [

	| pos |
	pos := 0.
	self nodesDo: [ :node |
		pos := pos + 1.
		node holder bindAtPosition: pos ]
]
