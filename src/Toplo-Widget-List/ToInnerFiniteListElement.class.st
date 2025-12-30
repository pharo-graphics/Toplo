Class {
	#name : #ToInnerFiniteListElement,
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
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #'instance creation' }
ToInnerFiniteListElement class >> onListElement: aListElement [

	^ self basicNew
		  onListElement: aListElement;
		  initialize
]

{ #category : #'accessing - nodes' }
ToInnerFiniteListElement >> addAllHolders: anArray at: aPosition [

	anArray reverseDo: [ :h | self addHolder: h at: aPosition].
	anArray do: [ :h | self notifyChildAttached: h nodeContainer  ]
]

{ #category : #'accessing - nodes' }
ToInnerFiniteListElement >> addHolder: anHolder [

	trackElement addChild: anHolder nodeContainer
]

{ #category : #'accessing - nodes' }
ToInnerFiniteListElement >> addHolder: anHolder at: aPosition [

	trackElement addChild: anHolder nodeContainer at: aPosition
]

{ #category : #'private - commands' }
ToInnerFiniteListElement >> addedDataSourceCommand: aCommand [
]

{ #category : #configuration }
ToInnerFiniteListElement >> applyConfiguration [

	super applyConfiguration.
	listElement isHFitContent
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].

	listElement isVFitContent
		ifTrue: [ self vFitContent ]
		ifFalse: [ self vMatchParent ].

	self childrenDo: [ :container | container applyConfiguration ]
]

{ #category : #accessing }
ToInnerFiniteListElement >> cleanUpRecyclerAt: anIndex [
]

{ #category : #configuration }
ToInnerFiniteListElement >> configureNodeContainer: aNodeContainer [

	self toConfigurationDo: [ :conf |
			conf isFlowable
				ifTrue: [
						aNodeContainer isHExact ifFalse: [ aNodeContainer hFitContent ].
						aNodeContainer isVExact ifFalse: [ aNodeContainer vFitContent ] ]
				ifFalse: [
						listElement isVertical
							ifTrue: [
									aNodeContainer isHExact ifFalse: [
											listElement isHMatchParent
												ifTrue: [ aNodeContainer hMatchParent ]
												ifFalse: [ aNodeContainer hFitContent ] ].
									conf autoDistribute
										ifTrue: [ aNodeContainer vMatchParent ]
										ifFalse: [ aNodeContainer vFitContent ] ]
							ifFalse: [
									aNodeContainer isVExact ifFalse: [
											listElement isVMatchParent
												ifTrue: [ aNodeContainer vMatchParent ]
												ifFalse: [ aNodeContainer vFitContent ] ].
									conf autoDistribute
										ifTrue: [ aNodeContainer hMatchParent ]
										ifFalse: [ aNodeContainer hFitContent ] ] ] ]
]

{ #category : #layout }
ToInnerFiniteListElement >> consumeFinalStepCommands [
]

{ #category : #'private - commands' }
ToInnerFiniteListElement >> consumePendingDataSourceCommands [
]

{ #category : #accessing }
ToInnerFiniteListElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToInnerFiniteListElement >> dataSourceManager [

	^ dataSourceManager 
]

{ #category : #initialization }
ToInnerFiniteListElement >> defaultDataSource [ 

	^ listElement dataSource.
]

{ #category : #initialization }
ToInnerFiniteListElement >> defaultDataSourceManager [

	^ ToInnerFiniteListDataSourceManager new
		  innerBarElement: self;
		  yourself
]

{ #category : #initialization }
ToInnerFiniteListElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToInnerFiniteListDataSourceObserver
]

{ #category : #initialization }
ToInnerFiniteListElement >> defaultScrollFlinger [

	"Return class, actuall instantiation happens in initialize"
	^ ToInfiniteScrollFlinger
]

{ #category : #'t - list inner element' }
ToInnerFiniteListElement >> findElementHolderForDataSourcePosition: aPosition [
	"Return the holder for the node in the given position of the data set"

	self nodeContainersDo: [ :container |
		| holder |
		holder := container holder.
		holder position = aPosition ifTrue: [ ^ holder ] ].
	^ nil
]

{ #category : #initialization }
ToInnerFiniteListElement >> initialize [

	super initialize.
	self elevation: (BlRelativeElevation elevation: 10).
	self initializeDataSource.
	self addEventHandler: ToInnerFiniteListElementEventHandler new.
	self trackElement: self scrollableFiniteListTrackElementClass new.
	self matchParent.
	self focusability: BlFocusability ignore.
	listElement primarySelectionMode selectionOption
		grouped: false;
		beneath: true;
		triggerSelectionState: true.
	listElement contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: false.
]

{ #category : #initialization }
ToInnerFiniteListElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #accessing }
ToInnerFiniteListElement >> innerElement [

	^ self
]

{ #category : #accessing }
ToInnerFiniteListElement >> listElement [

	^ listElement
]

{ #category : #'instance creation' }
ToInnerFiniteListElement >> newNodeHolderFromDataSource: aDataSource [

	^ listElement nodeManager newHolder
]

{ #category : #configuration }
ToInnerFiniteListElement >> newToConfiguration [

	^ ToListInnerElementConfiguration new
]

{ #category : #'t - list inner element' }
ToInnerFiniteListElement >> nodeContainers [

	^ trackElement nodeContainers
]

{ #category : #'t - list inner element' }
ToInnerFiniteListElement >> nodeContainersDetect: aBlock [

	^ trackElement nodeContainersDetect: aBlock 
]

{ #category : #'t - list inner element' }
ToInnerFiniteListElement >> nodeContainersDo: aBlock [

	trackElement nodeContainersDo: aBlock
]

{ #category : #'t - list inner element' }
ToInnerFiniteListElement >> nodeContainersReject: aBlock [

	^ trackElement nodeContainersReject: aBlock 
]

{ #category : #'t - list inner element' }
ToInnerFiniteListElement >> nodeContainersSelect: aBlock [

	^ trackElement nodeContainersSelect: aBlock 
]

{ #category : #'t - list inner element' }
ToInnerFiniteListElement >> nodeContainersWithIndexDo: aBlock [

	trackElement nodeContainersWithIndexDo: aBlock
]

{ #category : #accessing }
ToInnerFiniteListElement >> nodeManager [

	^ self listElement nodeManager
]

{ #category : #'hooks - layout' }
ToInnerFiniteListElement >> onEnterLayoutOrScroll [
]

{ #category : #'hooks - layout' }
ToInnerFiniteListElement >> onExitLayoutOrScroll [


]

{ #category : #'data source updates' }
ToInnerFiniteListElement >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	self nodeContainersDo: [ :container |
		| pos |
		pos := container holder position.
		(pos >= aPositionStart and: [ pos < (aPositionStart + anItemCount) ])
			ifTrue: [
				container applyConfiguration ] ]
]

{ #category : #'data source updates' }
ToInnerFiniteListElement >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

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
ToInnerFiniteListElement >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	| allContainers |
	allContainers := self nodeContainersSelect: [ :container |
		         container holder position
			         between: aPositionStart 
			         and: aPositionStart + anItemCount - 1].
	self removeAllNodeContainers: allContainers.
	self updatePositions

]

{ #category : #'data source updates' }
ToInnerFiniteListElement >> onItemsChanged [

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
ToInnerFiniteListElement >> onListElement: aListElement [

	listElement ifNotNil: [ BlImmutableObjectChangeError signal ].
	listElement := aListElement
]

{ #category : #'t - list inner element' }
ToInnerFiniteListElement >> partlyVisibleNodesDo: aBlock [

	trackElement partlyVisibleNodesDo: aBlock
]

{ #category : #'hooks - layout' }
ToInnerFiniteListElement >> prefetchingAllowed [

	^ false
]

{ #category : #'accessing - nodes' }
ToInnerFiniteListElement >> removeAllNodeContainers: anArray [

	trackElement removeAllNodeContainers: anArray.
	anArray do: [ :container | self notifyChildDetached: container  ]
]

{ #category : #'accessing - nodes' }
ToInnerFiniteListElement >> removeNodeContainer: aNode [

	trackElement removeNodeContainer: aNode 
]

{ #category : #scrolling }
ToInnerFiniteListElement >> scrollDeltaFromDataSourcePosition: anIndex [

	| node bnds pad |
	node := self nodeContainerAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisibleInListElement ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	pad := listElement isHorizontal
		       ifTrue: [ listElement padding left ]
		       ifFalse: [ listElement padding top ].
	^ bnds position - pad
]

{ #category : #scrolling }
ToInnerFiniteListElement >> scrollDeltaTowardEndFromDataSourcePosition: anIndex [

	| node bnds offset padding |
	node := self nodeContainerAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisibleInListElement ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	padding := listElement padding.
	offset := listElement isHorizontal
		          ifTrue: [ padding right - listElement width + bnds width ]
		          ifFalse: [
		          padding bottom - listElement height + bnds height ].
	^ bnds position + offset
]

{ #category : #scrolling }
ToInnerFiniteListElement >> scrollDeltaTowardStartFromDataSourcePosition: anIndex [

	| node bnds pad |
	node := self nodeContainerAt: anIndex.
	node ifNil: [ ^ nil ].
	node isFullyVisibleInListElement ifTrue: [ ^ nil ].
	bnds := node measuredBounds inParent: listElement.
	pad := listElement isHorizontal
		       ifTrue: [ listElement padding left ]
		       ifFalse: [ listElement padding top ].
	^ bnds position - pad
]

{ #category : #scrolling }
ToInnerFiniteListElement >> scrollToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToInnerFiniteListElement >> scrollTowardEndToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToInnerFiniteListElement >> scrollTowardStartToDataSourcePosition: anIndex [

	(self scrollDeltaTowardStartFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #initialization }
ToInnerFiniteListElement >> scrollableFiniteListTrackElementClass [

	^ ToScrollableFiniteListTrackElement 
]

{ #category : #scrolling }
ToInnerFiniteListElement >> smoothScrollBy: aPoint [
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
ToInnerFiniteListElement >> smoothScrollToDataSourcePosition: anIndex [

	(self scrollDeltaFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self smoothScrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToInnerFiniteListElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"
		
	self stopScrollersInternal

	
]

{ #category : #scrolling }
ToInnerFiniteListElement >> stopScrollersInternal [ 

	scrollFlinger stop
]

{ #category : #accessing }
ToInnerFiniteListElement >> trackElement [
	" introduced for tests, should be used privately "
	^ trackElement 
]

{ #category : #accessing }
ToInnerFiniteListElement >> trackElement: anElement [

	trackElement ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].
	trackElement := anElement.
	trackElement id: #track.
	trackElement onListElement: listElement .
	self addChild: trackElement 
]

{ #category : #'data source updates' }
ToInnerFiniteListElement >> updatePositions [

	| pos |
	pos := 0.
	self nodeContainersDo: [ :container |
		pos := pos + 1.
		container holder bindAtPosition: pos ]
]
