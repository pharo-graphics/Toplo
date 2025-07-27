Class {
	#name : #ToInnerBarElement,
	#superclass : #ToScrollableElement,
	#traits : 'TToListInnerElement',
	#classTraits : 'TToListInnerElement classTrait',
	#instVars : [
		'dataSource',
		'dataSourceManager',
		'listElement',
		'dataSourceObserver',
		'trackElement'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'instance creation' }
ToInnerBarElement class >> onListElement: aListElement [

	^ self basicNew
		  onListElement: aListElement;
		  initialize
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> addAllHolders: anArray at: aPosition [

	anArray reverseDo: [ :h | self addHolder: h at: aPosition].
	anArray do: [ :h | self notifyChildAttached: h node  ]
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> addFakeNode: aNode [

	trackElement addFakeNode: aNode
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> addHolder: anHolder at: aPosition [

	trackElement addChild: anHolder node at: aPosition + 1
]

{ #category : #'private - commands' }
ToInnerBarElement >> addedDataSourceCommand: aCommand [
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> applyConfiguration [

	super applyConfiguration.
	listElement isHFitContent
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].

	listElement isVFitContent
		ifTrue: [ self vFitContent ]
		ifFalse: [ self vMatchParent ].

	trackElement applyConfiguration
]

{ #category : #layout }
ToInnerBarElement >> checkFullyVisibleNodes [

	| invisibleNodes visibleNodes |
	(listElement isFlowable or: [ listElement autoDistribute ])
		ifTrue: [
				invisibleNodes := #(  ).
				visibleNodes := self nodes asArray ]
		ifFalse: [
				invisibleNodes := self nodesSelect: [ :n |
					                  n isFullyVisibleInInnerElement not ].
				visibleNodes := self nodes difference: invisibleNodes ].

	self dispatchEvent: (ToBarVisibleNodeListChangedEvent new
			 visibleNodes: visibleNodes;
			 invisibleNodes: invisibleNodes;
			 yourself)
]

{ #category : #'private - commands' }
ToInnerBarElement >> consumePendingDataSourceCommands [
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

{ #category : #initialization }
ToInnerBarElement >> defaultScrollFlinger [

	"Return class, actuall instantiation happens in initialize"
	^ ToInfiniteScrollFlinger
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> fakeNode [ 

	^ trackElement fakeNode
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> findElementHolderForDataSourcePosition: aPosition [
	"Return the holder for the node in the given position of the data set"

	self nodesDo: [ :aNode |
		| holder |
		holder := aNode holder.
		holder position = aPosition ifTrue: [ ^ holder ] ].
	^ nil
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> fullyVisibleNodes [

	^ trackElement fullyVisibleNodes
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> fullyVisibleNodesDo: aBlock [

	trackElement fullyVisibleNodesDo: aBlock
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> fullyVisibleNodesSelect: aBlock [

	^ trackElement fullyVisibleNodesSelect: aBlock
]

{ #category : #initialization }
ToInnerBarElement >> initialize [

	super initialize.
	self initializeDataSource.
	self addEventHandler: ToInnerBarElementEventHandler new.
	self trackElement: self scrollableBarTrackElementClass new.
	self installFakeNode.

	self matchParent.
	self focusability: BlFocusability ignore
]

{ #category : #initialization }
ToInnerBarElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #accessing }
ToInnerBarElement >> innerElement [

	^ self
]

{ #category : #initialization }
ToInnerBarElement >> installFakeNode [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeNode |
	fakeNode := self nodeManager newFakeNodeIn: self.

	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	self addFakeNode: fakeNode.
	self nodeManager buildNode: fakeNode.
	self requestConfiguration
]

{ #category : #accessing }
ToInnerBarElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToInnerBarElement >> maxMeasuredNodeSize [

	^ trackElement maxMeasuredNodeSize
]

{ #category : #'instance creation' }
ToInnerBarElement >> newNodeHolderFromDataSource: aDataSource [

	^ listElement nodeManager newHolder
]

{ #category : #accessing }
ToInnerBarElement >> nodeManager [

	^ self listElement nodeManager
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> nodes [

	^ trackElement nodes
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> nodesDetect: aBlock [

	^ trackElement nodesDetect: aBlock 
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> nodesDo: aBlock [

	trackElement nodesDo: aBlock
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> nodesSelect: aBlock [

	^ trackElement nodesSelect: aBlock 
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> nodesWithIndexDo: aBlock [

	trackElement nodesWithIndexDo: aBlock
]

{ #category : #'hooks - layout' }
ToInnerBarElement >> onEnterLayoutOrScroll [
]

{ #category : #'hooks - layout' }
ToInnerBarElement >> onExitLayoutOrScroll [


]

{ #category : #'t - bar element' }
ToInnerBarElement >> onInvisibleNodes: theInvisibleNodes visibleNodes: theVisibleNodes [
]

{ #category : #'data source updates' }
ToInnerBarElement >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	self nodesDo: [ :node |
		| pos |
		pos := node holder position.
		(pos >= aPositionStart and: [ pos < (aPositionStart + anItemCount) ])
			ifTrue: [
				node requestConfiguration ] ]
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

{ #category : #initialization }
ToInnerBarElement >> onListElement: aListElement [

	listElement ifNotNil: [ BlImmutableObjectChangeError signal ].
	listElement := aListElement
]

{ #category : #'hooks - scrolling' }
ToInnerBarElement >> onScrolled: aPoint [
	"Sent when the scroll position of this InfiniteElement changes. Subclasses should use
	this method to respond to scrolling within the datasource's data set instead of an explicit event handler.
	I will always be invoked before event handlers. If a subclass needs to perform any additional upkeep
	or bookkeeping after scrolling but before events fired, this is a good place to do so"

	self checkFullyVisibleNodes
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> partlyVisibleNodesDo: aBlock [

	trackElement partlyVisibleNodesDo: aBlock
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> partlyVisibleNodesSelect: aBlock [

	^ trackElement partlyVisibleNodesSelect: aBlock
]

{ #category : #'hooks - layout' }
ToInnerBarElement >> prefetchingAllowed [

	^ false
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> removeAllNodes: anArray [

	trackElement removeAllNodes: anArray.
	anArray do: [ :node | self notifyChildDetached: node  ]
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> removeFakeNode [

	trackElement removeFakeNode
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> removeNode: aNode [

	trackElement removeNode: aNode 
]

{ #category : #scrolling }
ToInnerBarElement >> scrollDeltaFromDataSourcePosition: anIndex [

	| node bnds pad |
	node := self nodeAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisibleInInnerElement ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	pad := listElement isHorizontal
		       ifTrue: [ listElement padding left ]
		       ifFalse: [ listElement padding top ].
	^ bnds position - pad
]

{ #category : #scrolling }
ToInnerBarElement >> scrollDeltaTowardEndFromDataSourcePosition: anIndex [

	| node bnds offset padding |
	node := self nodeAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisibleInInnerElement ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	padding := listElement padding.
	offset := listElement isHorizontal
		          ifTrue: [ padding right - listElement width + bnds width ]
		          ifFalse: [
		          padding bottom - listElement height + bnds height ].
	^ bnds position + offset
]

{ #category : #scrolling }
ToInnerBarElement >> scrollDeltaTowardStartFromDataSourcePosition: anIndex [

	| node bnds pad |
	node := self nodeAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisibleInInnerElement ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	pad := listElement isHorizontal
		       ifTrue: [ listElement padding left ]
		       ifFalse: [ listElement padding top ].
	^ bnds position - pad
]

{ #category : #scrolling }
ToInnerBarElement >> scrollToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToInnerBarElement >> scrollTowardEndToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToInnerBarElement >> scrollTowardStartToDataSourcePosition: anIndex [

	(self scrollDeltaTowardStartFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #initialization }
ToInnerBarElement >> scrollableBarTrackElementClass [

	^ ToScrollableBarTrackElement 
]

{ #category : #scrolling }
ToInnerBarElement >> smoothScrollBy: aPoint [
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

{ #category : #scrolling }
ToInnerBarElement >> smoothScrollToDataSourcePosition: anIndex [

	(self scrollDeltaFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self smoothScrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToInnerBarElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"
		
	self stopScrollersInternal

	
]

{ #category : #scrolling }
ToInnerBarElement >> stopScrollersInternal [ 

	scrollFlinger stop
]

{ #category : #accessing }
ToInnerBarElement >> trackElement [
	" introduced for tests, should be used privately "
	^ trackElement 
]

{ #category : #accessing }
ToInnerBarElement >> trackElement: anElement [

	trackElement ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].
	trackElement := anElement.
	trackElement id: #track.
	trackElement onListElement: listElement .
	self addChild: trackElement 
]

{ #category : #initialization }
ToInnerBarElement >> uninstallFakeNode [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	" remove the fake node (to keep a constant minimum size ) "
	self removeFakeNode
]

{ #category : #'data source updates' }
ToInnerBarElement >> updatePositions [

	| pos |
	pos := 0.
	self nodesDo: [ :node |
		pos := pos + 1.
		node holder bindAtPosition: pos ]
]
