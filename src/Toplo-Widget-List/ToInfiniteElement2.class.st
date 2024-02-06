Class {
	#name : #ToInfiniteElement2,
	#superclass : #BlInfiniteElement,
	#traits : 'TBlLayoutResizable',
	#classTraits : 'TBlLayoutResizable classTrait',
	#instVars : [
		'nodeBuilder',
		'nodeClass',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #deprecated }
ToInfiniteElement2 >> cherryPickIndex: anIndex [

	self
		deprecated: 'Use selection cherryPickIndex: instead'
		transformWith: '`@receiver cherryPickIndex: `@arg' -> '`@receiver selectionStrategy cherryPickIndex: `@arg'.
	self selectionStrategy cherryPickIndex: anIndex
]

{ #category : #accessing }
ToInfiniteElement2 >> client [

	^ self
]

{ #category : #accessing }
ToInfiniteElement2 >> data [

	^ dataSource data
]

{ #category : #accessing }
ToInfiniteElement2 >> dataSource: aDataSource [

	super dataSource: aDataSource.
	self dispatchEvent: ToDataSourceAttachedEvent new
]

{ #category : #initialization }
ToInfiniteElement2 >> defaultDataSource [

	^ ToInfiniteObservableCollectionDataSource new
]

{ #category : #initialization }
ToInfiniteElement2 >> defaultLayout [

	^ BlInfiniteLinearLayout new
]

{ #category : #initialization }
ToInfiniteElement2 >> defaultMouseScrollEventHandler [

	^ BlInfiniteMouseScrollListener new
		  restrictedByOrientation: true;
		  yourself
]

{ #category : #initialization }
ToInfiniteElement2 >> defaultNodeBuilder [

	^ [ :node :holder | node addChild: ((ToLabel text: holder data asString) hMatchParent) ]
]

{ #category : #deprecated }
ToInfiniteElement2 >> deselectAll [
	self
		deprecated: 'Use selection deselectAll instead'
		transformWith: '`@receiver deselectAll' -> '`@receiver selectionStrategy deselectAll'.

	self selectionStrategy deselectAll
]

{ #category : #deprecated }
ToInfiniteElement2 >> deselectIndex: anIndex [

	self
		deprecated: 'Use selection deselectIndex: instead'
		transformWith: '`@receiver deselectIndex: `@arg' -> '`@receiver selectionStrategy deselectIndex: `@arg'.
	self selectionStrategy deselectIndex: anIndex
]

{ #category : #'scrolled event' }
ToInfiniteElement2 >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #deprecated }
ToInfiniteElement2 >> dispatchSelectionChangedAfter: aBlock [

	| prevIndexes currentIndexes event |
	
	self deprecated: 'Delegate to selection strategy instead'.
	
	prevIndexes := self selectionStrategy selectedIndexes.

	aBlock value.

	currentIndexes := self selectionStrategy selectedIndexes.
	prevIndexes = currentIndexes ifTrue: [ ^ self ].
	event := ToInfiniteSelectionChangedEvent
		         previousIndexes: prevIndexes
		         currentIndexes: currentIndexes.
	self dispatchEvent: event
]

{ #category : #'scrolled event' }
ToInfiniteElement2 >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent 
]

{ #category : #testing }
ToInfiniteElement2 >> hasSelection [

	self
		deprecated: 'Use selection isNotEmpty instead'
		transformWith: '`@receiver hasSelection' -> '`@receiver selectionStrategy isNotEmpty'.	
	^ self selectionStrategy isNotEmpty
]

{ #category : #'t - infinite accessing' }
ToInfiniteElement2 >> infinite [ 

	^ self
]

{ #category : #initialization }
ToInfiniteElement2 >> initialize [

	super initialize.
	self privateData: ToObservableCollection new.
	self nodeBuilder: self defaultNodeBuilder.
	self matchParent
]

{ #category : #initialization }
ToInfiniteElement2 >> newNode [

	^ self nodeClass new
]

{ #category : #'instance creation' }
ToInfiniteElement2 >> newNodeHolderFromDataSource: aDataSource [

	^ self nodeHolderClass new infiniteElement: self
]

{ #category : #accessing }
ToInfiniteElement2 >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #accessing }
ToInfiniteElement2 >> nodeBuilder [

	"aValuable takes 2 args: first, the ToNode to build and second, the data"
	^ nodeBuilder 
]

{ #category : #accessing }
ToInfiniteElement2 >> nodeBuilder: aValuable [

	"aValuable takes 2 args: first, the ToNode to build and second, its holder in the list element "
	nodeBuilder := aValuable
]

{ #category : #initialization }
ToInfiniteElement2 >> nodeClass [

	^ nodeClass ifNil: [ nodeClass := ToNode ]
]

{ #category : #initialization }
ToInfiniteElement2 >> nodeClass: aNodeClass [

	nodeClass := aNodeClass
]

{ #category : #'accessing - children' }
ToInfiniteElement2 >> nodeContainingGlobalPosition: aPoint [

	self childrenDo: [ :node |
		(node containsGlobalPoint: aPoint) ifTrue: [ ^ node ] ].
	^ nil
]

{ #category : #accessing }
ToInfiniteElement2 >> nodeHolderBuilder [

	^ [ :theHolder |
	  | newNode |
	  newNode := self newNode.
	  theHolder node: newNode.
	  self nodeBuilder value: theHolder node value: theHolder ]
]

{ #category : #initialization }
ToInfiniteElement2 >> nodeHolderClass [

	^ ToNodeHolder2
]

{ #category : #'private - commands' }
ToInfiniteElement2 >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [

	super
		offsetPositionRecordsForInsert: aStartPosition
		itemCount: anItemCount.
	self dispatchEvent: ToListSelectionDirtyEvent new
]

{ #category : #'private - commands' }
ToInfiniteElement2 >> offsetPositionRecordsForMove: aFromPosition to: aToPosition [

	super offsetPositionRecordsForMove: aFromPosition to: aToPosition.
	self dispatchEvent: ToListSelectionDirtyEvent new
]

{ #category : #'private - commands' }
ToInfiniteElement2 >> offsetPositionRecordsForRemove: aStartPosition itemCount: anItemCount applyToPreLayout: applyToPreLayout [

	super
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: applyToPreLayout.
	self dispatchEvent: ToListSelectionDirtyEvent new
]

{ #category : #deprecated }
ToInfiniteElement2 >> primarySelection [

	self
		deprecated: 'Use selection instead'
		transformWith: '`@receiver primarySelection' -> '`@receiver selectionStrategy'.
	^ self selectionStrategy 
]

{ #category : #'private - accessing' }
ToInfiniteElement2 >> privateData: aCollection [

	dataSource data: aCollection
]

{ #category : #'t - resizeable' }
ToInfiniteElement2 >> resizableConstraintsDo: aBlock [
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
ToInfiniteElement2 >> scrollToDataSourcePosition: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"

	self scrollToPosition: anIndex.

	"aWish smooth
		ifTrue: [ self listElement smoothScrollToPosition: aWish index ]
		ifFalse: [ self listElement scrollToPosition: aWish index ]"
]

{ #category : #private }
ToInfiniteElement2 >> scrollToIndex: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"

	self scrollToPosition: anIndex.

	"aWish smooth
		ifTrue: [ self listElement smoothScrollToPosition: aWish index ]
		ifFalse: [ self listElement scrollToPosition: aWish index ]"
]

{ #category : #private }
ToInfiniteElement2 >> scrollToIndexAtTop: anIndex [
	"Request a scrollable widget to scroll to an item (logical or physical) at a given index,
	which can, for example, be a data source position or child index"
	"As a result, item at anIndex is positionned at the top of the listElement"

	self scrollToPosition: anIndex offset: self layout computeExtraLayoutSpace y.
]

{ #category : #deprecated }
ToInfiniteElement2 >> selectAll [

	self
		deprecated: 'Use selection selectAll instead'
		transformWith: '`@receiver selectAll' -> '`@receiver selectionStrategy selectAll'.

	self selectionStrategy selectAll
]

{ #category : #deprecated }
ToInfiniteElement2 >> selectIndex: index [

	self
		deprecated: 'Use selection selectIndex: instead'
		transformWith: '`@receiver selectIndex: `@arg' -> '`@receiver selectionStrategy selectIndex: `@arg'.
	self selectionStrategy selectIndex: index
]

{ #category : #deprecated }
ToInfiniteElement2 >> selectIndexes: aCollection [

	self
		deprecated: 'Use selection selectIndexes: instead'
		transformWith: '`@receiver selectIndexes: `@arg' -> '`@receiver selectionStrategy selectIndexes: `@arg'.
	self selectionStrategy selectIndexes: aCollection
]

{ #category : #deprecated }
ToInfiniteElement2 >> selectOnlyIndex: index [

	self
		deprecated: 'Use selection selectOnlyIndex: instead'
		transformWith: '`@receiver selectOnlyIndex: `@arg' -> '`@receiver selectionStrategy selectOnlyIndex: `@arg'.
	self selectionStrategy selectOnlyIndex: index
]

{ #category : #deprecated }
ToInfiniteElement2 >> selectToIndex: anIndex [

	self
		deprecated: 'Use selection selectToIndex: instead'
		transformWith: '`@receiver selectToIndex: `@arg' -> '`@receiver selectionStrategy selectToIndex: `@arg'.
	self selectionStrategy selectToIndex: anIndex
]

{ #category : #deprecated }
ToInfiniteElement2 >> selectedIndex [

	self
		deprecated: 'Use selection selectedIndex instead'
		transformWith: '`@receiver selectedIndex' -> '`@receiver selectionStrategy selectedIndex'.
	^ self selectionStrategy selectedIndex
]

{ #category : #deprecated }
ToInfiniteElement2 >> selectedIndexes [

	self
		deprecated: 'Use selection selectedIndexes instead'
		transformWith: '`@receiver selectedIndexes' -> '`@receiver selectionStrategy selectedIndexes'.
	^ self selectionStrategy selectedIndexes
]

{ #category : #deprecated }
ToInfiniteElement2 >> selection [

	self
		deprecated: 'Use selectionStrategy instead'
		transformWith: '`@receiver selection' -> '`@receiver selectionStrategy'.

	^ self selectionStrategy 
]

{ #category : #deprecated }
ToInfiniteElement2 >> selection: aSelectionStrategy [

	self
		deprecated: 'Use selectionStrategy: instead'
		transformWith: '`@receiver selection: `@arg' -> '`@receiver selectionStrategy: `@arg'.
	self selectionStrategy: aSelectionStrategy
]

{ #category : #accessing }
ToInfiniteElement2 >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToInfiniteElement2 >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #deprecated }
ToInfiniteElement2 >> shiftSelectionAfterAddingAt: aStartPosition itemCount: anItemCount [

	self
		deprecated: 'Use selection shiftAfterAddingAt:itemCount: instead'
		transformWith: '`@receiver shiftSelectionAfterAddingAt: `@arg1 itemCount: `@arg2' -> '`@receiver selectionStrategy shiftAfterAddingAt: `@arg1 itemCount: `@arg2 '.
	self selectionStrategy shiftAfterAddingAt: aStartPosition itemCount: anItemCount
]

{ #category : #deprecated }
ToInfiniteElement2 >> shiftSelectionAfterRemovingAt: aStartPosition itemCount: anItemCount [

	self
		deprecated:
		'Use selection shiftSelectionAfterRemovingAt:itemCount: instead'
		transformWith:
			'`@receiver shiftSelectionAfterRemovingAt: `@arg1 itemCount: `@arg2'
			->
			'`@receiver selectionStrategy shiftAfterRemovingAt: `@arg1 itemCount: `@arg2 '.
	self selectionStrategy
		shiftAfterRemovingAt: aStartPosition
		itemCount: anItemCount
]
