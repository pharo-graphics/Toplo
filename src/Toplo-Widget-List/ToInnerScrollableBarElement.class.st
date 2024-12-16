Class {
	#name : #ToInnerScrollableBarElement,
	#superclass : #ToScrollableElement,
	#instVars : [
		'trackElement',
		'dataSource',
		'dataSourceManager',
		'listElement',
		'dataSourceObserver'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'instance creation' }
ToInnerScrollableBarElement class >> onBarElement: aBarElement [

	^ self basicNew
		  onBarElement: aBarElement;
		  initialize
]

{ #category : #'instance creation' }
ToInnerScrollableBarElement class >> onInnerBarElement: anInnerBarElement [

	^ self new
		  onInnerBarElement: anInnerBarElement;
		  yourself
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> addAllHolders: anArray at: aPosition [

	trackElement addAllHolders: anArray at: aPosition.
	anArray do: [ :h | self notifyChildAttached: h node  ]
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> addFakeNode: aNode [

	trackElement addFakeNode: aNode
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> addHolder: anHolder at: aPosition [

	trackElement addHolder: anHolder at: aPosition
]

{ #category : #layout }
ToInnerScrollableBarElement >> checkFullyVisibleNodes [

	| invisibleNodes |
	self isNodeWrapping ifTrue: [ ^ self ].
	self isNodeScrolling ifTrue: [ ^ self ].
	self isNodeAutoDistribution ifTrue: [ ^ self ].
	invisibleNodes := self nodesSelect: [ :n | n isFullyVisible not ].
	listElement haveInvisibleNodes: invisibleNodes
]

{ #category : #layout }
ToInnerScrollableBarElement >> configureLayoutIn: aBarElement [

	self matchParent.
	aBarElement isHMatchParent ifFalse: [ self hFitContent ].
	aBarElement isVMatchParent ifFalse: [ self vFitContent ].
	trackElement configureLayoutIn: aBarElement
]

{ #category : #'private - commands' }
ToInnerScrollableBarElement >> consumePendingDataSourceCommands [
]

{ #category : #accessing }
ToInnerScrollableBarElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToInnerScrollableBarElement >> dataSourceManager [

	^ dataSourceManager 
]

{ #category : #initialization }
ToInnerScrollableBarElement >> defaultDataSource [ 

	^ listElement dataSource.
]

{ #category : #initialization }
ToInnerScrollableBarElement >> defaultDataSourceManager [

	^ ToInnerBarDataSourceManager new
		  innerBarElement: self;
		  yourself
]

{ #category : #initialization }
ToInnerScrollableBarElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToInnerBarDataSourceObserver
]

{ #category : #initialization }
ToInnerScrollableBarElement >> defaultScrollFlinger [

	"Return class, actuall instantiation happens in initialize"
	^ ToInfiniteScrollFlinger
]

{ #category : #'t - infinite scrolled event' }
ToInnerScrollableBarElement >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'t - infinite scrolled event' }
ToInnerScrollableBarElement >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent
]

{ #category : #accessing }
ToInnerScrollableBarElement >> fakeNode [ 

	^ trackElement fakeNode
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> findElementHolderForDataSourcePosition: aPosition [
	"Return the holder for the node in the given position of the data set"

	self nodesDo: [ :aNode |
		| holder |
		holder := aNode holder.
		holder position = aPosition ifTrue: [ ^ holder ] ].
	^ nil
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> fullyVisibleNodes [

	^ trackElement fullyVisibleNodes
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> fullyVisibleNodesDo: aBlock [

	trackElement fullyVisibleNodesDo: aBlock
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> fullyVisibleNodesSelect: aBlock [

	^ trackElement fullyVisibleNodesSelect: aBlock
]

{ #category : #initialization }
ToInnerScrollableBarElement >> initialize [ 

	super initialize.

	self initializeDataSource.
	self addEventHandler: ToListInnerElementEventHandler new.
	self addEventHandler: (ToScrollableBarEventHandler new parentBar: self ).
	self trackElement: ToScrollableBarTrackElement new.

	self matchParent.
	self focusability: BlFocusability ignore

]

{ #category : #initialization }
ToInnerScrollableBarElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #accessing }
ToInnerScrollableBarElement >> innerElement [

	^ self
]

{ #category : #initialization }
ToInnerScrollableBarElement >> installFakeNode [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeNode |
	fakeNode := self nodeManager newFakeNodeIn: self.
	
	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	self addFakeNode: fakeNode.
	self nodeManager buildNode: fakeNode.
	self nodeManager constraintFakeNode: fakeNode



]

{ #category : #testing }
ToInnerScrollableBarElement >> isHorizontal [

	^ trackElement isHorizontal 
]

{ #category : #testing }
ToInnerScrollableBarElement >> isNodeAutoDistribution [

	^ trackElement isNodeAutoDistribution
]

{ #category : #testing }
ToInnerScrollableBarElement >> isNodeScrolling [

	^ trackElement isNodeScrolling
]

{ #category : #testing }
ToInnerScrollableBarElement >> isNodeWrapping [

	^ trackElement isNodeWrapping
]

{ #category : #accessing }
ToInnerScrollableBarElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToInnerScrollableBarElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #'instance creation' }
ToInnerScrollableBarElement >> newNodeHolderFromDataSource: aDataSource [

	^ listElement nodeManager newHolder
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> nodeGroupsSatisfying: aBlock [
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
ToInnerScrollableBarElement >> nodeManager [

	^ self listElement nodeManager
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> nodes [

	^ trackElement nodes
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> nodesDo: aBlock [

	trackElement nodesDo: aBlock
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> nodesSelect: aBlock [

	^ trackElement nodesSelect: aBlock 
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> nodesWithIndexDo: aBlock [

	trackElement nodesWithIndexDo: aBlock
]

{ #category : #notifying }
ToInnerScrollableBarElement >> notifyChildAttached: anElement [
	"Notify all event handlers that element is attached to the inner bar"

	self dispatchEvent: (BlInfiniteElementAttachedEvent element: anElement)
]

{ #category : #notifying }
ToInnerScrollableBarElement >> notifyChildDetached: anElement [
	"Notify all event handlers that element is detached from the inner bar"

	self dispatchEvent: (BlInfiniteElementDetachedEvent element: anElement)
]

{ #category : #initialization }
ToInnerScrollableBarElement >> onBarElement: aListElement [

	listElement ifNotNil: [ BlImmutableObjectChangeError signal ].
	self listElement: aListElement
]

{ #category : #'hooks - layout' }
ToInnerScrollableBarElement >> onEnterLayoutOrScroll [
]

{ #category : #'hooks - layout' }
ToInnerScrollableBarElement >> onExitLayoutOrScroll [
]

{ #category : #initialization }
ToInnerScrollableBarElement >> onInnerBarElement: anInnerBarElement [

	self addEventHandler: (ToScrollableBarEventHandler new parentBar: anInnerBarElement )
]

{ #category : #'data source updates' }
ToInnerScrollableBarElement >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	self nodesDo: [ :node |
		(node holder position >= aPositionStart) ifTrue: [ | dataItem |
			node holder unbindDataItem.
			dataItem := dataSource at: node holder position.
			node holder setDataItemAndBuildNode: dataItem ] ].
	self requestLayout 
]

{ #category : #'data source updates' }
ToInnerScrollableBarElement >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

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
ToInnerScrollableBarElement >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	| nodes |
	nodes := self nodesSelect: [ :node |
		         node holder position
			         between: aPositionStart 
			         and: aPositionStart + anItemCount - 1].
	self removeAllNodes: nodes.
	self updatePositions

]

{ #category : #'data source updates' }
ToInnerScrollableBarElement >> onItemsChanged [

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

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> partlyVisibleNodesDo: aBlock [

	trackElement partlyVisibleNodesDo: aBlock
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> partlyVisibleNodesSelect: aBlock [

	^ trackElement partlyVisibleNodesSelect: aBlock
]

{ #category : #'hooks - layout' }
ToInnerScrollableBarElement >> prefetchingAllowed [

	^ false
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> removeAllNodes: anArray [

	trackElement removeAllNodes: anArray.
	anArray do: [ :node | self notifyChildDetached: node  ]
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> removeFakeNode [

	trackElement removeFakeNode
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> removeNode: aNode [

	trackElement removeNode: aNode 
]

{ #category : #'t - infinite accessing' }
ToInnerScrollableBarElement >> scrollDeltaFromDataSourcePosition: anIndex [

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
ToInnerScrollableBarElement >> scrollDeltaTowardEndFromDataSourcePosition: anIndex [

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
ToInnerScrollableBarElement >> scrollDeltaTowardStartFromDataSourcePosition: anIndex [

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
ToInnerScrollableBarElement >> scrollToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #'t - infinite accessing' }
ToInnerScrollableBarElement >> scrollTowardEndToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #'t - infinite accessing' }
ToInnerScrollableBarElement >> scrollTowardStartToDataSourcePosition: anIndex [

	(self scrollDeltaTowardStartFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #initialization }
ToInnerScrollableBarElement >> scrollableBarTrackElementClass [

	^ ToScrollableBarTrackElement 
]

{ #category : #'accessing - nodes' }
ToInnerScrollableBarElement >> selectableNodeContainingGlobalPosition: aPoint [

	self nodesDo: [ :node |
		((node containsGlobalPoint: aPoint) and: [ node holder isSelectable ])
			ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #scrolling }
ToInnerScrollableBarElement >> smoothScrollBy: aPoint [
	"Animate a scroll by the given amount of pixels along either axis"
	| dX dY aContent |

	self hasScrolledElement
		ifFalse: [ ^ self ].

	aContent := self scrolledElement.

	dX := aPoint x.
	dY := aPoint y negated.
	
	self canScrollHorizontally
			ifTrue: [
			| aNewPosition aMinPosition aMaxPosition aNewClampedPosition |
			
			aNewPosition := self scrollPosition x + dX.
			aMinPosition := (self width - aContent width) min: 0.0.
			aMaxPosition := 0.0.
			aNewClampedPosition := (aNewPosition max: aMinPosition) min: aMaxPosition.
			
			dX := aNewClampedPosition - self scrollPosition x ]
		ifFalse: [ dX := 0.0 ].
	
	self canScrollVertically
		ifTrue: [
			| aNewPosition aMinPosition aMaxPosition aNewClampedPosition |
			
			aNewPosition := self scrollPosition y + dY.
			aMinPosition := (self height - aContent height) min: 0.0.
			aMaxPosition := 0.0.
			aNewClampedPosition := (aNewPosition max: aMinPosition) min: aMaxPosition.
			dY := aNewClampedPosition - self scrollPosition y ]
		ifFalse: [ dY := 0.0 ].
	
	(dX isZero and: [ dY isZero ])
		ifFalse: [ scrollFlinger smoothScrollBy: dX @ dY]
]

{ #category : #'t - infinite accessing' }
ToInnerScrollableBarElement >> smoothScrollToDataSourcePosition: anIndex [

	(self scrollDeltaFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self smoothScrollBy: p x negated @ p y ]
]

{ #category : #'t - infinite accessing' }
ToInnerScrollableBarElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"
		
	self stopScrollersInternal

	
]

{ #category : #scrolling }
ToInnerScrollableBarElement >> stopScrollersInternal [ 

	scrollFlinger stop
]

{ #category : #accessing }
ToInnerScrollableBarElement >> trackElement [

	^ trackElement 
]

{ #category : #accessing }
ToInnerScrollableBarElement >> trackElement: anElement [

	trackElement = anElement ifTrue: [ ^ self ].
	trackElement ifNotNil: [ trackElement removeFromParent ].
	trackElement := anElement.
	trackElement ifNil: [ ^ self ].
	trackElement id: #track.
	self addChild: trackElement 
]

{ #category : #initialization }
ToInnerScrollableBarElement >> uninstallFakeNode [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	" remove the fake node (to keep a constant minimum size ) "
	self removeFakeNode
]

{ #category : #'data source updates' }
ToInnerScrollableBarElement >> updatePositions [

	| pos |
	pos := 0.
	self nodesDo: [ :node |
		pos := pos + 1.
		node holder bindAtPosition: pos ]
]
