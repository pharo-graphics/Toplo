Class {
	#name : #ToAbstractListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator + TToElementWithPlaceholder',
	#classTraits : 'TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait',
	#instVars : [
		'selectionMode',
		'sharedEventDistributors',
		'dataSource'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'private - commands' }
ToAbstractListElement >> applyDataSourceFilterCommand: aDataSourceCommand [
]

{ #category : #'private - commands' }
ToAbstractListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
	" update the selection according to the sieve selection model"

	| sieve |
	sieve := aDataSourceCommand sieve.
	sieve pattern
		ifNotEmpty: [
			| start count |
			self selectionModel resetAll.
			start := aDataSourceCommand positionStart.
			count := aDataSourceCommand itemCount.
			start to: start + count - 1 do: [ :localIndex |
				| d originalIndex |
				d := self dataAccessor at: localIndex.
				originalIndex := sieve dataPositionIndex at: d.
				sieve selectionModel
					transferSelectionFromIndex: originalIndex
					toIndex: localIndex
					in: self selectionModel ] ]
		ifEmpty: [
		self selectionModel copySelectionFrom: sieve selectionModel ]
]

{ #category : #orientation }
ToAbstractListElement >> beHorizontal [

	self infinite layout beHorizontal
]

{ #category : #orientation }
ToAbstractListElement >> beVertical [

	self infinite layout beVertical
]

{ #category : #accessing }
ToAbstractListElement >> contextMenuSelectionElements [

	^ Array streamContents: [ :stream |
		  self childrenDo: [ :child |
			  (child isKindOf: ToListContextMenuSelectionElement) ifTrue: [
				  stream nextPut: child ] ] ]
]

{ #category : #accessing }
ToAbstractListElement >> data [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver data'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
]

{ #category : #accessing }
ToAbstractListElement >> dataAccessor [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractListElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToAbstractListElement >> dataSource: aDataSource [

	dataSource ifNotNil: [ BlImmutableObjectChangeError signal ].
	dataSource := aDataSource
]

{ #category : #accessing }
ToAbstractListElement >> dataUpdater [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver dataUpdater'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
]

{ #category : #initialization }
ToAbstractListElement >> defaultDataSource [ 

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListElement >> defaultEventHandler [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListElement >> defaultInfiniteElement [ 

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToAbstractListElement >> defaultNodeBuilder [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListElement >> defaultNodeFactory [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListElement >> defaultNodeHolderBuilder [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListElement >> defaultNodeHolderFactory [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListElement >> defaultNodeReleaser [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListElement >> defaultSelectionMode [

	^ ToListSelectionMode primaryOn: self
]

{ #category : #orientation }
ToAbstractListElement >> horizontal: aBoolean [

	self vertical: aBoolean not
]

{ #category : #initialization }
ToAbstractListElement >> infiniteSharedEvents [

	^ {
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  BlElementScrolledEvent }
]

{ #category : #initialization }
ToAbstractListElement >> initialize [

	super initialize.
	self initializeDataSource.

	self next: self defaultInfiniteElement.
	self next elevation: (BlRelativeElevation elevation: 10).

	self layout: self defaultLayout.	

	self selectionMode: self defaultSelectionMode.
	self addEventHandler: self defaultEventHandler.

	self addChild: self next.
	self installSharedEventDistributors.
	
	self contextMenuWindowManagerClass: ToListElementContextMenuWindowManager.
	self addEventHandler: ToListPrimarySelectionElementEventHandler new.
	self addEventHandler:	ToListElementContextMenuSelectionEventHandler new.
	self addEventHandler: ToElementCommandEventHandler new.
	
	self matchParent
]

{ #category : #initialization }
ToAbstractListElement >> initializeDataSource [ 

	self dataSource: self defaultDataSource
]

{ #category : #initialization }
ToAbstractListElement >> installSharedEventDistributors [
	"installs shared event distributors between the list element, the selection strategy,
	the infinite, the data and the data source. 
	This gives the possibility to directly add event handlers on shared events :
		self when: ToInfiniteSelectionChangedEvent do: [ bla bla ] 
		instead of 
		self infinite when: ToSelectionChangedEvent do: [ bla bla ] "

	| infiniteSharedHandler |
	infiniteSharedHandler := BlSharedEventDistributor new
		                         shareEvents: self infiniteSharedEvents;
		                         yourself.
	sharedEventDistributors := { infiniteSharedHandler }.
	sharedEventDistributors do: [ :handler | self addEventHandler: handler ].
	self infinite addEventHandler: infiniteSharedHandler.
	self addEventHandler: infiniteSharedHandler
]

{ #category : #orientation }
ToAbstractListElement >> isHorizontal [

	^ self infinite layout isHorizontal
]

{ #category : #testing }
ToAbstractListElement >> isMultipleSelection [

	^ self selectionMode isMultipleSelection
]

{ #category : #orientation }
ToAbstractListElement >> isVertical [

	^ self infinite layout isVertical
]

{ #category : #accessing }
ToAbstractListElement >> itemCount [

	^ self dataSource itemCount
]

{ #category : #'instance creation' }
ToAbstractListElement >> newPrimarySelectionModel [

	^ self subclassResponsibility 
]

{ #category : #skin }
ToAbstractListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #'instance creation' }
ToAbstractListElement >> newSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractListElement >> nodeBuilder [

	"aValuable takes 2 args: first, the node to build and second, its holder in the list element "

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractListElement >> nodeFactory [
	" returns aValuable that takes a node holder as unique argument and which running results in a new node "

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractListElement >> nodeHolderBuilder [

	"aValuable takes 1 arg: the holder to build and second "

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractListElement >> nodeReleaser [
	"aValuable takes 2 args: first, the ToNode to release and second, its holder in the list element "

	^ self subclassResponsibility
]

{ #category : #'event firing' }
ToAbstractListElement >> notifyDataSourceItemsChanged: aDataSourceEvent [

	| preNotification |
	preNotification := ToListDataSourceItemsChangePreNotificationEvent new
		                   sourceEvent: aDataSourceEvent;
		                   yourself.
	self dispatchEvent: preNotification.
	preNotification sourceEvent ifNil: [ ^ self ].
	self dispatchEvent: preNotification sourceEvent
]

{ #category : #'event firing' }
ToAbstractListElement >> notifyDataSourceItemsFiltered: aDataSourceEvent [

	
	self dispatchEvent: aDataSourceEvent
]

{ #category : #'event firing' }
ToAbstractListElement >> notifyPrimarySelectionDirty [

	self dispatchEvent: ToListPrimarySelectionDirtyEvent new
]

{ #category : #'private - commands' }
ToAbstractListElement >> offsetPositionRecordsForFilter: aStartPosition itemCount: anItemCount fromSieve: aSieve [

	aSieve pattern
		ifNotEmpty: [
			self dataAccessor withIndexDo: [ :d :localIndex |
				| originalIndex |
				originalIndex := aSieve dataPositionIndex at: d.
				aSieve selectionModel
					transferSelectionFromIndex: originalIndex
					toIndex: localIndex
					in: self selectionModel ] ]
		ifEmpty: [
		self selectionModel copySelectionFrom: aSieve selectionModel ]
]

{ #category : #'t - element with placeholder' }
ToAbstractListElement >> placeholderElevation [

	^ self infinite elevation
]

{ #category : #accessing }
ToAbstractListElement >> primarySelectionElements [

	^ Array streamContents: [ :stream |
		  self childrenDo: [ :child |
			  (child isKindOf: ToListPrimarySelectionElement) ifTrue: [
				  stream nextPut: child ] ] ]
]

{ #category : #accessing }
ToAbstractListElement >> selecter [ 

	^ self selectionMode selecter
]

{ #category : #accessing }
ToAbstractListElement >> selectionMode [

	^ selectionMode
]

{ #category : #accessing }
ToAbstractListElement >> selectionMode: aSelectionMode [

	selectionMode ifNotNil: [
		selectionMode onUninstalledIn: self ].
	selectionMode := aSelectionMode.
	selectionMode ifNotNil: [
		selectionMode onInstalledIn: self ].
	self dispatchEvent: ToListPrimarySelectionModeChangedEvent new.
	self requestNewSkin
]

{ #category : #accessing }
ToAbstractListElement >> selectionModel [

	^ self selectionMode selectionModel
]

{ #category : #'private - commands' }
ToAbstractListElement >> sieveResultWith: aSieve [

	self dataAccessor sieveResultWith: aSieve
]

{ #category : #initialization }
ToAbstractListElement >> uninstallSharedEventDistributors [
	" see installSharedEventDistributor "

	sharedEventDistributors ifNil: [ ^ self ].

	sharedEventDistributors do: [ :handler |
		self removeEventHandler: handler.
		self infinite removeEventHandlersSuchThat: [ :h | handler = h ] ].

	sharedEventDistributors := nil
]

{ #category : #orientation }
ToAbstractListElement >> vertical: aBoolean [

	aBoolean
		ifTrue: [ self beVertical ]
		ifFalse: [ self beHorizontal ]
]
