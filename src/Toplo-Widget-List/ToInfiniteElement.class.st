Class {
	#name : #ToInfiniteElement,
	#superclass : #BlInfiniteElement,
	#traits : 'TToElement + TBlLayoutResizable',
	#classTraits : 'TToElement classTrait + TBlLayoutResizable classTrait',
	#instVars : [
		'nodeBuilder',
		'nodeClass',
		'selectionStrategy'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #deprecated }
ToInfiniteElement >> cherryPickIndex: anIndex [

	self
		deprecated: 'Use selection cherryPickIndex: instead'
		transformWith: '`@receiver cherryPickIndex: `@arg' -> '`@receiver selectionStrategy cherryPickIndex: `@arg'.
	self selectionStrategy cherryPickIndex: anIndex
]

{ #category : #accessing }
ToInfiniteElement >> client [

	^ self
]

{ #category : #accessing }
ToInfiniteElement >> data [

	^ dataSource data
]

{ #category : #initialization }
ToInfiniteElement >> defaultDataSource [

	^ ToInfiniteObservableCollectionDataSource new
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

	^ [ :node :holder | node addChild: ((ToLabel text: holder data asString) hMatchParent) ]
]

{ #category : #initialization }
ToInfiniteElement >> defaultPeserveSelectionOnFocused [

	^ true
]

{ #category : #initialization }
ToInfiniteElement >> defaultSelectionStrategy [

	^ ToListNullSelectionStrategy new
	"^ ToStandardListSelectionStrategy new"
]

{ #category : #deprecated }
ToInfiniteElement >> deselectAll [
	self
		deprecated: 'Use selection deselectAll instead'
		transformWith: '`@receiver deselectAll' -> '`@receiver selectionStrategy deselectAll'.

	self selectionStrategy deselectAll
]

{ #category : #deprecated }
ToInfiniteElement >> deselectIndex: anIndex [

	self
		deprecated: 'Use selection deselectIndex: instead'
		transformWith: '`@receiver deselectIndex: `@arg' -> '`@receiver selectionStrategy deselectIndex: `@arg'.
	self selectionStrategy deselectIndex: anIndex
]

{ #category : #'scrolled event' }
ToInfiniteElement >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #deprecated }
ToInfiniteElement >> dispatchSelectionChangedAfter: aBlock [

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
ToInfiniteElement >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent 
]

{ #category : #testing }
ToInfiniteElement >> hasSelection [

	self
		deprecated: 'Use selection isNotEmpty instead'
		transformWith: '`@receiver hasSelection' -> '`@receiver selectionStrategy isNotEmpty'.	
	^ self selectionStrategy isNotEmpty
]

{ #category : #'t - infinite accessing' }
ToInfiniteElement >> infinite [ 

	^ self
]

{ #category : #initialization }
ToInfiniteElement >> initialize [

	super initialize.
	self initializeForToplo.
	selectionStrategy := self defaultSelectionStrategy.
	selectionStrategy onInstalledIn: self.
	self privateData: ToObservableCollection new.
	self nodeBuilder: self defaultNodeBuilder.
	self matchParent
]

{ #category : #initialization }
ToInfiniteElement >> newNode [

	^ self nodeClass new
]

{ #category : #'instance creation' }
ToInfiniteElement >> newNodeHolderFromDataSource: aDataSource [

	^ self nodeHolderClass new infiniteElement: self
]

{ #category : #skin }
ToInfiniteElement >> newRawSkin [

	^ ToInfiniteElementSkin new
]

{ #category : #accessing }
ToInfiniteElement >> nodeAt: anIndex [

	" return the holder for the data at anIndex according to currently viewed data range. 
	Returns nil if anIndex is not currently viewed in the infinite element"
	^ (self findElementHolderForDataSourcePosition: anIndex)
		  ifNotNil: [ :holder | holder itemElement ]
		  ifNil: [  ]
]

{ #category : #accessing }
ToInfiniteElement >> nodeBuilder [

	"aValuable takes 2 args: first, the ToNode to build and second, the data"
	^ nodeBuilder 
]

{ #category : #accessing }
ToInfiniteElement >> nodeBuilder: aValuable [

	"aValuable takes 2 args: first, the ToNode to build and second, its holder in the list element "
	nodeBuilder := aValuable
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

{ #category : #accessing }
ToInfiniteElement >> nodeHolderBuilder [

	^ [ :theHolder |
	  | newNode |
	  newNode := self newNode.
	  theHolder node: newNode.
	  self nodeBuilder value: theHolder node value: theHolder ]
]

{ #category : #initialization }
ToInfiniteElement >> nodeHolderClass [

	^ ToNodeHolder 
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [

	self selectionStrategy dispatchSelectionDirtyAfter: [
		super
			offsetPositionRecordsForInsert: aStartPosition
			itemCount: anItemCount ]
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForMove: aFromPosition to: aToPosition [

	self selectionStrategy dispatchSelectionDirtyAfter: [
		super offsetPositionRecordsForMove: aFromPosition to: aToPosition ]
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForRemove: aStartPosition itemCount: anItemCount applyToPreLayout: applyToPreLayout [

	self selectionStrategy dispatchSelectionDirtyAfter: [
		super
			offsetPositionRecordsForRemove: aStartPosition
			itemCount: anItemCount
			applyToPreLayout: applyToPreLayout ]
]

{ #category : #deprecated }
ToInfiniteElement >> primarySelection [

	self
		deprecated: 'Use selection instead'
		transformWith: '`@receiver primarySelection' -> '`@receiver selectionStrategy'.
	^ self selectionStrategy 
]

{ #category : #'private - accessing' }
ToInfiniteElement >> privateData: aCollection [

	dataSource addEventHandler: (BlEventHandler
			 on: BlInfiniteDataSourceChanged
			 do: [ self selectionStrategy onInfiniteDataSourceChanged ]).
	dataSource data: aCollection
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

{ #category : #deprecated }
ToInfiniteElement >> selectAll [

	self
		deprecated: 'Use selection selectAll instead'
		transformWith: '`@receiver selectAll' -> '`@receiver selectionStrategy selectAll'.

	self selectionStrategy selectAll
]

{ #category : #deprecated }
ToInfiniteElement >> selectIndex: index [

	self
		deprecated: 'Use selection selectIndex: instead'
		transformWith: '`@receiver selectIndex: `@arg' -> '`@receiver selectionStrategy selectIndex: `@arg'.
	self selectionStrategy selectIndex: index
]

{ #category : #deprecated }
ToInfiniteElement >> selectIndexes: aCollection [

	self
		deprecated: 'Use selection selectIndexes: instead'
		transformWith: '`@receiver selectIndexes: `@arg' -> '`@receiver selectionStrategy selectIndexes: `@arg'.
	self selectionStrategy selectIndexes: aCollection
]

{ #category : #deprecated }
ToInfiniteElement >> selectOnlyIndex: index [

	self
		deprecated: 'Use selection selectOnlyIndex: instead'
		transformWith: '`@receiver selectOnlyIndex: `@arg' -> '`@receiver selectionStrategy selectOnlyIndex: `@arg'.
	self selectionStrategy selectOnlyIndex: index
]

{ #category : #deprecated }
ToInfiniteElement >> selectToIndex: anIndex [

	self
		deprecated: 'Use selection selectToIndex: instead'
		transformWith: '`@receiver selectToIndex: `@arg' -> '`@receiver selectionStrategy selectToIndex: `@arg'.
	self selectionStrategy selectToIndex: anIndex
]

{ #category : #deprecated }
ToInfiniteElement >> selectedIndex [

	self
		deprecated: 'Use selection selectedIndex instead'
		transformWith: '`@receiver selectedIndex' -> '`@receiver selectionStrategy selectedIndex'.
	^ self selectionStrategy selectedIndex
]

{ #category : #deprecated }
ToInfiniteElement >> selectedIndexes [

	self
		deprecated: 'Use selection selectedIndexes instead'
		transformWith: '`@receiver selectedIndexes' -> '`@receiver selectionStrategy selectedIndexes'.
	^ self selectionStrategy selectedIndexes
]

{ #category : #deprecated }
ToInfiniteElement >> selection [

	self
		deprecated: 'Use selectionStrategy instead'
		transformWith: '`@receiver selection' -> '`@receiver selectionStrategy'.

	^ self selectionStrategy 
]

{ #category : #deprecated }
ToInfiniteElement >> selection: aSelectionStrategy [

	self
		deprecated: 'Use selectionStrategy: instead'
		transformWith: '`@receiver selection: `@arg' -> '`@receiver selectionStrategy: `@arg'.
	self selectionStrategy: aSelectionStrategy
]

{ #category : #accessing }
ToInfiniteElement >> selectionStrategy [

	^ selectionStrategy
]

{ #category : #accessing }
ToInfiniteElement >> selectionStrategy: aSelectionStrategy [

	selectionStrategy ifNotNil: [ :sstrat | sstrat onUninstalledIn: self ].
	selectionStrategy := aSelectionStrategy.
	selectionStrategy ifNotNil: [ :sstrat | sstrat onInstalledIn: self ].

]

{ #category : #deprecated }
ToInfiniteElement >> shiftSelectionAfterAddingAt: aStartPosition itemCount: anItemCount [

	self
		deprecated: 'Use selection shiftAfterAddingAt:itemCount: instead'
		transformWith: '`@receiver shiftSelectionAfterAddingAt: `@arg1 itemCount: `@arg2' -> '`@receiver selectionStrategy shiftAfterAddingAt: `@arg1 itemCount: `@arg2 '.
	self selectionStrategy shiftAfterAddingAt: aStartPosition itemCount: anItemCount
]

{ #category : #deprecated }
ToInfiniteElement >> shiftSelectionAfterRemovingAt: aStartPosition itemCount: anItemCount [

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
