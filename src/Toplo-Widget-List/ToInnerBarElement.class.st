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
		'trackElement',
		'previousInvisibleNodes'
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
	anArray do: [ :h | self notifyChildAttached: h nodeContainer  ]
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> addFakeNodeContainer: aNodeContainer [

	trackElement addFakeNodeContainer: aNodeContainer
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> addHolder: anHolder at: aPosition [

	trackElement addChild: anHolder nodeContainer at: aPosition + 1
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
				visibleNodes := self nodeContainers asArray ]
		ifFalse: [
				invisibleNodes := self nodeContainersSelect: [ :container |
					                  container isFullyVisibleInInnerElement not ].
				visibleNodes := self nodeContainers difference: invisibleNodes ].
	previousInvisibleNodes = invisibleNodes ifTrue: [ ^ self ].
	previousInvisibleNodes := invisibleNodes.
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
ToInnerBarElement >> fakeNodeContainer [ 

	^ trackElement fakeNodeContainer
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> findElementHolderForDataSourcePosition: aPosition [
	"Return the holder for the node in the given position of the data set"

	self nodeContainersDo: [ :container |
		| holder |
		holder := container holder.
		holder position = aPosition ifTrue: [ ^ holder ] ].
	^ nil
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> fullyVisibleNodeContainers [

	^ trackElement fullyVisibleNodeContainers
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> fullyVisibleNodeContainersDo: aBlock [

	trackElement fullyVisibleNodeContainersDo: aBlock
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> fullyVisibleNodeContainersSelect: aBlock [

	^ trackElement fullyVisibleNodeContainersSelect: aBlock
]

{ #category : #initialization }
ToInnerBarElement >> initialize [

	super initialize.
	self initializeDataSource.
	self addEventHandler: ToInnerBarElementEventHandler new.
	self trackElement: self scrollableBarTrackElementClass new.
	self installFakeNodeContainer.

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
ToInnerBarElement >> installFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeContainer |
	fakeContainer := self nodeManager newFakeNodeContainerIn: self.

	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	self addFakeNodeContainer: fakeContainer.
	self nodeManager buildNode: fakeContainer node.
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

{ #category : #'t - list node holder' }
ToInnerBarElement >> nodeContainers [

	^ trackElement nodeContainers
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> nodeContainersDetect: aBlock [

	^ trackElement nodeContainersDetect: aBlock 
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> nodeContainersDo: aBlock [

	trackElement nodeContainersDo: aBlock
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> nodeContainersSelect: aBlock [

	^ trackElement nodeContainersSelect: aBlock 
]

{ #category : #'t - list node holder' }
ToInnerBarElement >> nodeContainersWithIndexDo: aBlock [

	trackElement nodeContainersWithIndexDo: aBlock
]

{ #category : #accessing }
ToInnerBarElement >> nodeManager [

	^ self listElement nodeManager
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

	self nodeContainersDo: [ :container |
		| pos |
		pos := container holder position.
		(pos >= aPositionStart and: [ pos < (aPositionStart + anItemCount) ])
			ifTrue: [
				container applyConfiguration ] ]
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

	| allContainers |
	allContainers := self nodeContainersSelect: [ :container |
		         container holder position
			         between: aPositionStart 
			         and: aPositionStart + anItemCount - 1].
	self removeAllNodeContainers: allContainers.
	self updatePositions

]

{ #category : #'data source updates' }
ToInnerBarElement >> onItemsChanged [

	| holders |

	self removeAllNodeContainers: self nodeContainers.
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
ToInnerBarElement >> removeAllNodeContainers: anArray [

	trackElement removeAllNodeContainers: anArray.
	anArray do: [ :container | self notifyChildDetached: container  ]
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> removeFakeNodeContainer [

	trackElement fakeNodeContainer ifNil: [ ^ self ].
	trackElement removeFakeNodeContainer
]

{ #category : #'accessing - nodes' }
ToInnerBarElement >> removeNodeContainer: aNode [

	trackElement removeNodeContainer: aNode 
]

{ #category : #scrolling }
ToInnerBarElement >> scrollDeltaFromDataSourcePosition: anIndex [

	| node bnds pad |
	node := self nodeContainerAt: anIndex.
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
	node := self nodeContainerAt: anIndex.
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
	node := self nodeContainerAt: anIndex.
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
ToInnerBarElement >> uninstallFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	" remove the fake node (to keep a constant minimum size ) "
	self removeFakeNodeContainer
]

{ #category : #'data source updates' }
ToInnerBarElement >> updatePositions [

	| pos |
	pos := 0.
	self nodeContainersDo: [ :container |
		pos := pos + 1.
		container holder bindAtPosition: pos ]
]
