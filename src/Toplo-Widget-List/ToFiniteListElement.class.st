Class {
	#name : #ToFiniteListElement,
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
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'instance creation' }
ToFiniteListElement class >> onListElement: aListElement [

	^ self basicNew
		  onListElement: aListElement;
		  initialize
]

{ #category : #'accessing - nodes' }
ToFiniteListElement >> addAllHolders: anArray at: aPosition [

	anArray reverseDo: [ :h | self addHolder: h at: aPosition].
	anArray do: [ :h | self notifyChildAttached: h nodeContainer  ]
]

{ #category : #'accessing - nodes' }
ToFiniteListElement >> addHolder: anHolder [

	trackElement addChild: anHolder nodeContainer
]

{ #category : #'accessing - nodes' }
ToFiniteListElement >> addHolder: anHolder at: aPosition [

	trackElement addChild: anHolder nodeContainer at: aPosition
]

{ #category : #'private - commands' }
ToFiniteListElement >> addedDataSourceCommand: aCommand [
]

{ #category : #configuration }
ToFiniteListElement >> applyConfiguration [

	super applyConfiguration.
	self fitParent: listElement.
	self childrenDo: [ :container | container applyConfiguration ]
]

{ #category : #accessing }
ToFiniteListElement >> cleanUpRecyclerAt: anIndex [
]

{ #category : #layout }
ToFiniteListElement >> consumeFinalStepCommands [

	dataSourceManager consumeFinalStepCommandsIn: self
]

{ #category : #'private - commands' }
ToFiniteListElement >> consumePendingDataSourceCommands [
]

{ #category : #accessing }
ToFiniteListElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToFiniteListElement >> dataSourceManager [

	^ dataSourceManager 
]

{ #category : #initialization }
ToFiniteListElement >> defaultDataSource [ 

	^ listElement dataSource.
]

{ #category : #initialization }
ToFiniteListElement >> defaultDataSourceManager [

	^ ToFiniteListDataSourceManager new
		  innerListElement: self;
		  yourself
]

{ #category : #initialization }
ToFiniteListElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToFiniteListDataSourceObserver
]

{ #category : #initialization }
ToFiniteListElement >> defaultScrollFlinger [

	"Return class, actuall instantiation happens in initialize"
	^ ToListScrollFlinger
]

{ #category : #'t - list inner element' }
ToFiniteListElement >> findElementHolderForDataSourcePosition: aPosition [
	"Return the holder for the node in the given position of the data set"

	self nodeContainersDo: [ :container |
		| holder |
		holder := container holder.
		holder position = aPosition ifTrue: [ ^ holder ] ].
	^ nil
]

{ #category : #testing }
ToFiniteListElement >> hasPendingCommands [

	^ dataSourceManager hasPendingCommands
]

{ #category : #initialization }
ToFiniteListElement >> initialize [

	super initialize.
	
	self elevation: (BlRelativeElevation elevation: 10).
	self initializeDataSource.
	self addEventHandler: ToFiniteListElementEventHandler new.
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
ToFiniteListElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager.
	self addEventHandlerOn: BlElementRemovedFromParentEvent doOnce: [
			dataSource onDetached: self.
			dataSource removeEventHandler: dataSourceObserver.
			dataSourceManager := nil ]
]

{ #category : #accessing }
ToFiniteListElement >> innerElement [

	^ self
]

{ #category : #accessing }
ToFiniteListElement >> listElement [

	^ listElement
]

{ #category : #'instance creation' }
ToFiniteListElement >> newNodeHolderFromDataSource: aDataSource [

	^ listElement nodeManager newHolder
]

{ #category : #configuration }
ToFiniteListElement >> newToConfiguration [

	^ ToListInnerElementConfiguration new
]

{ #category : #'t - list inner element' }
ToFiniteListElement >> nodeContainers [

	^ trackElement nodeContainers
]

{ #category : #'t - list inner element' }
ToFiniteListElement >> nodeContainersDetect: aBlock [

	^ trackElement nodeContainersDetect: aBlock 
]

{ #category : #'t - list inner element' }
ToFiniteListElement >> nodeContainersDo: aBlock [

	trackElement nodeContainersDo: aBlock
]

{ #category : #'t - list inner element' }
ToFiniteListElement >> nodeContainersReject: aBlock [

	^ trackElement nodeContainersReject: aBlock 
]

{ #category : #'t - list inner element' }
ToFiniteListElement >> nodeContainersSelect: aBlock [

	^ trackElement nodeContainersSelect: aBlock 
]

{ #category : #'t - list inner element' }
ToFiniteListElement >> nodeContainersWithIndexDo: aBlock [

	trackElement nodeContainersWithIndexDo: aBlock
]

{ #category : #accessing }
ToFiniteListElement >> nodeManager [

	^ self listElement nodeManager
]

{ #category : #'data source updates' }
ToFiniteListElement >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [
]

{ #category : #'hooks - layout' }
ToFiniteListElement >> onEnterLayoutOrScroll [
]

{ #category : #'hooks - layout' }
ToFiniteListElement >> onExitLayoutOrScroll [


]

{ #category : #'data source updates' }
ToFiniteListElement >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	self nodeContainersDo: [ :container |
		| pos |
		pos := container holder position.
		(pos >= aPositionStart and: [ pos < (aPositionStart + anItemCount) ])
			ifTrue: [
				container applyConfiguration ] ]
]

{ #category : #'data source updates' }
ToFiniteListElement >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

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
ToFiniteListElement >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	| allContainers |
	allContainers := self nodeContainersSelect: [ :container |
		         container holder position
			         between: aPositionStart 
			         and: aPositionStart + anItemCount - 1].
	self removeAllNodeContainers: allContainers.
	self updatePositions

]

{ #category : #'data source updates' }
ToFiniteListElement >> onItemsChanged [

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

{ #category : #'hooks - layout' }
ToFiniteListElement >> onLayoutDone [ 

	super onLayoutDone.
	self dataSourceManager consumeFinalStepCommandsIn: self
]

{ #category : #initialization }
ToFiniteListElement >> onListElement: aListElement [

	listElement ifNotNil: [ BlImmutableObjectChangeError signal ].
	listElement := aListElement
]

{ #category : #'t - list inner element' }
ToFiniteListElement >> partlyVisibleNodesDo: aBlock [

	trackElement partlyVisibleNodesDo: aBlock
]

{ #category : #'hooks - layout' }
ToFiniteListElement >> prefetchingAllowed [

	^ false
]

{ #category : #'accessing - nodes' }
ToFiniteListElement >> removeAllNodeContainers: anArray [

	anArray reverseDo: [ :container | 
		trackElement removeNodeContainer: container.
		self notifyChildDetached: container  ]
]

{ #category : #'accessing - nodes' }
ToFiniteListElement >> removeNodeContainer: aNode [

	trackElement removeNodeContainer: aNode 
]

{ #category : #scrolling }
ToFiniteListElement >> scrollDeltaFromDataSourcePosition: anIndex [

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
ToFiniteListElement >> scrollDeltaTowardEndFromDataSourcePosition: anIndex [

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
ToFiniteListElement >> scrollDeltaTowardStartFromDataSourcePosition: anIndex [

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
ToFiniteListElement >> scrollToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToFiniteListElement >> scrollTowardEndToDataSourcePosition: anIndex [

	(self scrollDeltaTowardEndFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToFiniteListElement >> scrollTowardStartToDataSourcePosition: anIndex [

	(self scrollDeltaTowardStartFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self scrollBy: p x negated @ p y ]
]

{ #category : #initialization }
ToFiniteListElement >> scrollableFiniteListTrackElementClass [

	^ ToFiniteListTrackElement 
]

{ #category : #scrolling }
ToFiniteListElement >> smoothScrollBy: aPoint [
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
ToFiniteListElement >> smoothScrollToDataSourcePosition: anIndex [

	(self scrollDeltaFromDataSourcePosition: anIndex) ifNotNil: [ :p |
		self smoothScrollBy: p x negated @ p y ]
]

{ #category : #scrolling }
ToFiniteListElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"
		
	self stopScrollersInternal

	
]

{ #category : #scrolling }
ToFiniteListElement >> stopScrollersInternal [ 

	scrollFlinger stop
]

{ #category : #accessing }
ToFiniteListElement >> trackElement [
	" introduced for tests, should be used privately "
	^ trackElement 
]

{ #category : #accessing }
ToFiniteListElement >> trackElement: anElement [

	trackElement ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].
	trackElement := anElement.
	trackElement id: #track.
	trackElement onListElement: listElement .
	self addChild: trackElement 
]

{ #category : #'data source updates' }
ToFiniteListElement >> updatePositions [

	| pos |
	pos := 0.
	self nodeContainersDo: [ :container |
		pos := pos + 1.
		container holder bindAtPosition: pos ]
]

{ #category : #configuration }
ToFiniteListElement >> withDecoration: aDecorationClass [
]
