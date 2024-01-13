Class {
	#name : #ToInfiniteElement,
	#superclass : #BlInfiniteElement,
	#traits : 'TBlLayoutResizable',
	#classTraits : 'TBlLayoutResizable classTrait',
	#instVars : [
		'nodeBuilder',
		'preserveSelectionOnFocused',
		'requestFocusOnMouseDown',
		'nodeClass',
		'selectionStrategy'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'selection events' }
ToInfiniteElement >> cherryPickIndex: anIndex [

	self
		deprecated: 'Use selection cherryPickIndex: instead'
		transformWith: '`@receiver cherryPickIndex: `@arg' -> '`@receiver selection cherryPickIndex: `@arg'.
	self selection cherryPickIndex: anIndex
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
ToInfiniteElement >> defaultSelectionStrategy [

	^ ToInfiniteNullSelectionStrategy new
	"^ ToStandardListSelectionStrategy new"
]

{ #category : #'selection events' }
ToInfiniteElement >> deselectAll [
	self
		deprecated: 'Use selection deselectAll instead'
		transformWith: '`@receiver deselectAll' -> '`@receiver selection deselectAll'.

	self selection deselectAll
]

{ #category : #'selection events' }
ToInfiniteElement >> deselectIndex: anIndex [

	self
		deprecated: 'Use selection deselectIndex: instead'
		transformWith: '`@receiver deselectIndex: `@arg' -> '`@receiver selection deselectIndex: `@arg'.
	self selection deselectIndex: anIndex
]

{ #category : #'scrolled event' }
ToInfiniteElement >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'selection action dispatching' }
ToInfiniteElement >> dispatchDeselectAll [

	self dispatchEvent: ToListDeselectAllEvent new
]

{ #category : #'selection action dispatching' }
ToInfiniteElement >> dispatchDeselectIndex: anIndex [

	self dispatchEvent: (ToListDeselectIndexEvent new
			 index: anIndex;
			 yourself)
]

{ #category : #'selection action dispatching' }
ToInfiniteElement >> dispatchDeselectIndexes: aCollection [

	self dispatchEvent: (ToListDeselectIndexesEvent new
			 indexes: aCollection;
			 yourself)
]

{ #category : #'selection action dispatching' }
ToInfiniteElement >> dispatchRemoveSelectedIndexesFrom: anIndex itemCount: aNumber [

	self dispatchEvent: (ToListRemoveSelectedIndexesEvent new
			 startIndex: anIndex;
			 itemCount: aNumber;
			 yourself)
]

{ #category : #'selection action dispatching' }
ToInfiniteElement >> dispatchSelectAll [

	self dispatchEvent: ToListSelectAllEvent new
]

{ #category : #'selection action dispatching' }
ToInfiniteElement >> dispatchSelectFrom: aStartIndex toIndex: anEndIndex [

	self dispatchEvent: (ToListSelectFromToIndexEvent new
			 interval: (aStartIndex to: anEndIndex);
			 yourself)
]

{ #category : #'selection action dispatching' }
ToInfiniteElement >> dispatchSelectIndex: anIndex [

	self dispatchEvent: (ToListSelectIndexEvent new
			 index: anIndex;
			 yourself)
]

{ #category : #'selection action dispatching' }
ToInfiniteElement >> dispatchSelectIndexes: aCollection [

	self dispatchEvent: (ToListSelectIndexesEvent new
			 indexes: aCollection;
			 yourself)
]

{ #category : #'selection action dispatching' }
ToInfiniteElement >> dispatchSelectOnlyIndex: anIndex [

	self dispatchEvent: (ToListSelectIndexOnlyEvent new
			 index: anIndex;
			 yourself)
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchSelectionChangedAfter: aBlock [

	| prevIndexes currentIndexes event |
	prevIndexes := self selectionStrategy selectedIndexes.

	aBlock value.

	currentIndexes := self selectionStrategy selectedIndexes.
	prevIndexes = currentIndexes ifTrue: [ ^ self ].
	event := ToInfiniteSelectionChangedEvent
		         previousIndexes: prevIndexes
		         currentIndexes: currentIndexes.
	self dispatchEvent: event
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchSelectionDirtyAfter: aBlock [

	aBlock value.
	self dispatchEvent: ToInfiniteSelectionDirtyEvent new
]

{ #category : #'selection action dispatching' }
ToInfiniteElement >> dispatchShiftSelectionFrom: anIndex itemCount: aNumber [

	self dispatchEvent: (ToListShiftSelectionEvent new
			 startIndex: anIndex;
			 itemCount: aNumber;
			 yourself)
]

{ #category : #'selection events' }
ToInfiniteElement >> dispatchStrongSelectionChanged [

	self dispatchEvent: (ToStrongSelectionEvent indexes: self selection selectedIndexes)
]

{ #category : #'scrolled event' }
ToInfiniteElement >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent 
]

{ #category : #testing }
ToInfiniteElement >> hasSelection [

	self
		deprecated: 'Use selection isNotEmpty instead'
		transformWith: '`@receiver hasSelection' -> '`@receiver selection isNotEmpty'.	
	^ self selection isNotEmpty
]

{ #category : #'t - infinite accessing' }
ToInfiniteElement >> infinite [ 

	^ self
]

{ #category : #initialization }
ToInfiniteElement >> initialize [

	super initialize.
	requestFocusOnMouseDown := true.
	self addEventHandler: ToSkinStateGenerator new.
	self addEventHandler: ToInfiniteElementEventHandler new.
	selectionStrategy := self defaultSelectionStrategy.
	selectionStrategy onInstalledIn: self.
	self privateData: ToObservableCollection new.
	
	self preserveSelectionOnFocused: self preserveSelectionOnFocusedByDefault.
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

{ #category : #accessing }
ToInfiniteElement >> nodeHolderBuilder [

	^ [ :theHolder |
	  | newNode |
	  newNode := self newNode.
	  self selectionStrategy onNewNode: newNode.
	  theHolder node: newNode.
	  self nodeBuilder value: theHolder node value: theHolder ]
]

{ #category : #initialization }
ToInfiniteElement >> nodeHolderClass [

	^ ToNodeHolder 
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [

	self dispatchSelectionDirtyAfter: [
		super
			offsetPositionRecordsForInsert: aStartPosition
			itemCount: anItemCount ]
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForMove: aFromPosition to: aToPosition [

	self dispatchSelectionDirtyAfter: [
		super offsetPositionRecordsForMove: aFromPosition to: aToPosition ]
]

{ #category : #'private - commands' }
ToInfiniteElement >> offsetPositionRecordsForRemove: aStartPosition itemCount: anItemCount applyToPreLayout: applyToPreLayout [

	self dispatchSelectionDirtyAfter: [
		super
			offsetPositionRecordsForRemove: aStartPosition
			itemCount: anItemCount
			applyToPreLayout: applyToPreLayout ]
]

{ #category : #accessing }
ToInfiniteElement >> preserveSelectionOnFocused [

	^ preserveSelectionOnFocused
]

{ #category : #accessing }
ToInfiniteElement >> preserveSelectionOnFocused: aBoolean [

	preserveSelectionOnFocused := aBoolean
]

{ #category : #initialization }
ToInfiniteElement >> preserveSelectionOnFocusedByDefault [

	^ true
]

{ #category : #accessing }
ToInfiniteElement >> primarySelection [

	self
		deprecated: 'Use selection instead'
		transformWith: '`@receiver primarySelection' -> '`@receiver selection'.
	^ self selectionStrategy 
]

{ #category : #'private - accessing' }
ToInfiniteElement >> privateData: aCollection [

	dataSource addEventHandler: (BlEventHandler
			 on: BlInfiniteDataSourceChanged
			 do: [ self selectionStrategy infiniteDataSourceChanged ]).
	dataSource data: aCollection
]

{ #category : #accessing }
ToInfiniteElement >> requestFocusOnMouseDown [

	^ requestFocusOnMouseDown 
]

{ #category : #accessing }
ToInfiniteElement >> requestFocusOnMouseDown: aBoolean [

	requestFocusOnMouseDown := aBoolean
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

{ #category : #'selection events' }
ToInfiniteElement >> selectAll [

	self
		deprecated: 'Use selection selectAll instead'
		transformWith: '`@receiver selectAll' -> '`@receiver selection selectAll'.

	self selection selectAll
]

{ #category : #'selection events' }
ToInfiniteElement >> selectIndex: index [

	self
		deprecated: 'Use selection selectIndex: instead'
		transformWith: '`@receiver selectIndex: `@arg' -> '`@receiver selection selectIndex: `@arg'.
	self selection selectIndex: index
]

{ #category : #'selection events' }
ToInfiniteElement >> selectIndexes: aCollection [

	self
		deprecated: 'Use selection selectIndexes: instead'
		transformWith: '`@receiver selectIndexes: `@arg' -> '`@receiver selection selectIndexes: `@arg'.
	self selection selectIndexes: aCollection
]

{ #category : #'selection events' }
ToInfiniteElement >> selectOnlyIndex: index [

	self
		deprecated: 'Use selection selectOnlyIndex: instead'
		transformWith: '`@receiver selectOnlyIndex: `@arg' -> '`@receiver selection selectOnlyIndex: `@arg'.
	self selection selectOnlyIndex: index
]

{ #category : #'selection events' }
ToInfiniteElement >> selectToIndex: anIndex [

	self
		deprecated: 'Use selection selectToIndex: instead'
		transformWith: '`@receiver selectToIndex: `@arg' -> '`@receiver selection selectToIndex: `@arg'.
	self selection selectToIndex: anIndex
]

{ #category : #accessing }
ToInfiniteElement >> selectedIndex [

	self
		deprecated: 'Use selection selectedIndex instead'
		transformWith: '`@receiver selectedIndex' -> '`@receiver selection selectedIndex'.
	^ self selection selectedIndex
]

{ #category : #accessing }
ToInfiniteElement >> selectedIndexes [

	self
		deprecated: 'Use selection selectedIndexes instead'
		transformWith: '`@receiver selectedIndexes' -> '`@receiver selection selectedIndexes'.
	^ self selection selectedIndexes
]

{ #category : #accessing }
ToInfiniteElement >> selection [

	self
		deprecated: 'Use selectionStrategy instead'
		transformWith: '`@receiver selection' -> '`@receiver selectionStrategy'.

	^ self selectionStrategy 
]

{ #category : #accessing }
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

{ #category : #'selection events' }
ToInfiniteElement >> shiftSelectionAfterAddingAt: aStartPosition itemCount: anItemCount [

	self
		deprecated: 'Use selection shiftAfterAddingAt:itemCount: instead'
		transformWith: '`@receiver shiftSelectionAfterAddingAt: `@arg1 itemCount: `@arg2' -> '`@receiver selection shiftAfterAddingAt: `@arg1 itemCount: `@arg2 '.
	self selection shiftAfterAddingAt: aStartPosition itemCount: anItemCount
]

{ #category : #'selection events' }
ToInfiniteElement >> shiftSelectionAfterRemovingAt: aStartPosition itemCount: anItemCount [ 

	self
		deprecated: 'Use selection shiftSelectionAfterRemovingAt:itemCount: instead'
		transformWith: '`@receiver shiftSelectionAfterRemovingAt: `@arg1 itemCount: `@arg2' -> '`@receiver selection shiftAfterRemovingAt: `@arg1 itemCount: `@arg2 '.
	self selection shiftAfterRemovingAt: aStartPosition itemCount: anItemCount
]
