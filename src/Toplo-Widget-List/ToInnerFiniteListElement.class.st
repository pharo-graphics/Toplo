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
		'trackElement',
		'previousInvisibleNodeContainers'
	],
	#category : #'Toplo-Widget-List-InnerBar'
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
ToInnerFiniteListElement >> addHolder: anHolder at: aPosition [

	trackElement addChild: anHolder nodeContainer at: aPosition
]

{ #category : #'private - commands' }
ToInnerFiniteListElement >> addedDataSourceCommand: aCommand [
]

{ #category : #'t - list node holder' }
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

{ #category : #layout }
ToInnerFiniteListElement >> checkFullyVisibleNodeContainers [

	| invisibles visibles |
	(listElement isFlowable or: [ listElement autoDistribute ])
		ifTrue: [
				invisibles := #(  ).
				visibles := self nodeContainers asArray ]
		ifFalse: [
				invisibles := self nodeContainersReject: #isFullyVisibleInListElement.
				visibles := self nodeContainers difference: invisibles ].
	previousInvisibleNodeContainers = invisibles ifTrue: [ ^ self ].
	previousInvisibleNodeContainers := invisibles.
	self dispatchEvent: (ToBarVisibleNodeContainerListChangedEvent new
			 visibleNodeContainers: visibles;
			 invisibleNodeContainers: invisibles;
			 yourself) 
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

	^ ToInnerBarDataSourceManager new
		  innerBarElement: self;
		  yourself
]

{ #category : #initialization }
ToInnerFiniteListElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"

	^ ToInnerBarDataSourceObserver
]

{ #category : #initialization }
ToInnerFiniteListElement >> defaultScrollFlinger [

	"Return class, actuall instantiation happens in initialize"
	^ ToInfiniteScrollFlinger
]

{ #category : #'t - list node holder' }
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
	self initializeDataSource.
	self addEventHandler: ToInnerBarElementEventHandler new.
	self trackElement: self scrollableBarTrackElementClass new.
	self matchParent.
	self focusability: BlFocusability ignore
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

{ #category : #accessing }
ToInnerFiniteListElement >> maxMeasuredNodeSize [

	^ trackElement maxMeasuredNodeSize
]

{ #category : #'instance creation' }
ToInnerFiniteListElement >> newNodeHolderFromDataSource: aDataSource [

	^ listElement nodeManager newHolder
]

{ #category : #'t - list node holder' }
ToInnerFiniteListElement >> nodeContainers [

	^ trackElement nodeContainers
]

{ #category : #'t - list node holder' }
ToInnerFiniteListElement >> nodeContainersDetect: aBlock [

	^ trackElement nodeContainersDetect: aBlock 
]

{ #category : #'t - list node holder' }
ToInnerFiniteListElement >> nodeContainersDo: aBlock [

	trackElement nodeContainersDo: aBlock
]

{ #category : #'t - list node holder' }
ToInnerFiniteListElement >> nodeContainersReject: aBlock [

	^ trackElement nodeContainersReject: aBlock 
]

{ #category : #'t - list node holder' }
ToInnerFiniteListElement >> nodeContainersSelect: aBlock [

	^ trackElement nodeContainersSelect: aBlock 
]

{ #category : #'t - list node holder' }
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

{ #category : #'t - bar element' }
ToInnerFiniteListElement >> onInvisibleNodeContainers: theInvisibleContainers visibleNodeContainers: theVisibleContainers [
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

{ #category : #'hooks - scrolling' }
ToInnerFiniteListElement >> onScrolled: aPoint [
	"Sent when the scroll position of this InfiniteElement changes. Subclasses should use
	this method to respond to scrolling within the datasource's data set instead of an explicit event handler.
	I will always be invoked before event handlers. If a subclass needs to perform any additional upkeep
	or bookkeeping after scrolling but before events fired, this is a good place to do so"

	self checkFullyVisibleNodeContainers
]

{ #category : #'t - list node holder' }
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
ToInnerFiniteListElement >> scrollableBarTrackElementClass [

	^ ToScrollableBarTrackElement 
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
