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

	^ [ :node :holder |
	  node addChild:
		  (ToLabel text: holder dataItem asString) hMatchParent ]
]

{ #category : #'scrolled event' }
ToInfiniteElement2 >> disableScrolledEvent [

	self eventDispatcher disableScrolledEvent 
]

{ #category : #'scrolled event' }
ToInfiniteElement2 >> enableScrolledEvent [

	self eventDispatcher enableScrolledEvent 
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
	"'offsetPositionRecordsForInsert: ' trace. aStartPosition trace. ' itemCount: ' trace. anItemCount traceCr."

	self selectionModel shift: anItemCount from: aStartPosition.
	super
		offsetPositionRecordsForInsert: aStartPosition
		itemCount: anItemCount.
	self enqueueTask: (BlTaskAction new action: [
			 self dispatchEvent: ToListSelectionDirtyEvent new ])
]

{ #category : #'private - commands' }
ToInfiniteElement2 >> offsetPositionRecordsForMove: aFromPosition to: aToPosition [
	"'offsetPositionRecordsForMove: ' trace. aFromPosition trace. ' to: ' trace. aToPosition traceCr."

	super offsetPositionRecordsForMove: aFromPosition to: aToPosition.
	(self selectionModel containsIndex: aFromPosition) ifTrue: [
		self selectionModel deselectIndex: aFromPosition.
		self selectionModel selectIndex: aToPosition ].
	self enqueueTask: (BlTaskAction new action: [
			 self dispatchEvent: ToListSelectionDirtyEvent new ])
]

{ #category : #'private - commands' }
ToInfiniteElement2 >> offsetPositionRecordsForRemove: aStartPosition itemCount: anItemCount applyToPreLayout: applyToPreLayout [
	"self selectionModel underlyingModel selection trace."

	"' :: offsetPositionRecordsForRemove: ' trace. aStartPosition trace. ' itemCount: ' trace. anItemCount traceCr."

	super
		offsetPositionRecordsForRemove: aStartPosition
		itemCount: anItemCount
		applyToPreLayout: applyToPreLayout.

	self selectionModel
		deselectIndex: aStartPosition
		to: aStartPosition + anItemCount - 1.
	self selectionModel shift: anItemCount negated from: aStartPosition.

	"' -> ' trace. self selectionModel underlyingModel selection traceCr."
	self enqueueTask: (BlTaskAction new action: [
			 self dispatchEvent: ToListSelectionDirtyEvent new ])
]

{ #category : #private }
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

{ #category : #accessing }
ToInfiniteElement2 >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToInfiniteElement2 >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
