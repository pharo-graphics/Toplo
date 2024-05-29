Class {
	#name : #ToAbstractListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator + TToElementWithPlaceholder + TToOrientable',
	#classTraits : 'TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait + TToOrientable classTrait',
	#instVars : [
		'next',
		'overContainer',
		'beneathContainer',
		'selectionMode',
		'secondarySelectionMode',
		'dataSource',
		'nodeManager'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'private - selection elements' }
ToAbstractListElement >> addBeneathSelectionElement: aSelectionElement [

	beneathContainer addChild: aSelectionElement
]

{ #category : #'private - selection elements' }
ToAbstractListElement >> addOverSelectionElement: aSelectionElement [

	overContainer addChild: aSelectionElement
]

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
				originalIndex := sieve originalIndexOf: d.
				sieve selectionModel
					transferSelectionFromIndex: originalIndex
					toIndex: localIndex
					in: self selectionModel ] ]
		ifEmpty: [
		self selectionModel copySelectionFrom: sieve selectionModel ]
]

{ #category : #accessing }
ToAbstractListElement >> beneathContainer [

	^ beneathContainer
]

{ #category : #accessing }
ToAbstractListElement >> contextMenuSelectionElements [

	^ Array streamContents: [ :stream |
		  self overContainer childrenDo: [ :child |
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

	^ self dataSource dataAccessor
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

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToAbstractListElement >> defaultInnerNodeContainer [ 

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListElement >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #initialization }
ToAbstractListElement >> defaultNodeManager [

	^ self defaultNodeManagerClass new
]

{ #category : #initialization }
ToAbstractListElement >> defaultNodeManagerClass [

	^ self subclassResponsibility   
]

{ #category : #initialization }
ToAbstractListElement >> defaultSecondarySelectionEventHandler [

	^ ToListSecondarySelectionElementEventHandler new
]

{ #category : #initialization }
ToAbstractListElement >> defaultSecondarySelectionMode [

	^ ToListSelectionMode secondary
]

{ #category : #initialization }
ToAbstractListElement >> defaultSelectionMode [

	^ ToListSelectionMode primary
]

{ #category : #accessing }
ToAbstractListElement >> disabledSelecter [ 

	^ self selecter subSelecterWithId: #disabled
]

{ #category : #accessing }
ToAbstractListElement >> disabledSelectionModel [

	^ self selectionModel disabledSelectionModel
]

{ #category : #accessing }
ToAbstractListElement >> hiddenSelecter [ 

	^ self selecter subSelecterWithId: #hidden
]

{ #category : #initialization }
ToAbstractListElement >> initialize [

	super initialize.
	self initializeDataSource.
	next := self defaultInnerNodeContainer.
	nodeManager := self defaultNodeManager.
	self next elevation: (BlRelativeElevation elevation: 10).

	beneathContainer := ToOverlayElement new.
	beneathContainer attachTo: self innerContainer.
	beneathContainer elevation: (BlRelativeElevation elevation: 5).  
	overContainer := ToOverlayElement new.
	overContainer attachTo: self innerContainer.
	overContainer elevation: (BlRelativeElevation elevation: 15). 
	self addChildren: { beneathContainer. overContainer }.

	self layout: self defaultLayout.	

	self selectionMode: self defaultSelectionMode.
	self addEventHandler: self defaultEventHandler.

	self addChild: self next.
	
	self contextMenuWindowManagerClass: ToListElementContextMenuWindowManager.
	self addEventHandler: ToListPrimarySelectionElementEventHandler new.
	self addEventHandler:	ToListElementContextMenuSelectionEventHandler new.
	self addEventHandler: ToElementCommandEventHandler new.
		
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self addEventHandler: self defaultSecondarySelectionEventHandler.
	
	self matchParent
]

{ #category : #initialization }
ToAbstractListElement >> initializeDataSource [ 

	self dataSource: self defaultDataSource
]

{ #category : #testing }
ToAbstractListElement >> isMultipleSelection [

	^ self selectionMode isMultipleSelection
]

{ #category : #accessing }
ToAbstractListElement >> itemCount [

	^ self dataSource itemCount
]

{ #category : #'t - orientable - accessing' }
ToAbstractListElement >> layoutStrategy [

	^ self innerContainer layout

	
]

{ #category : #'instance creation' }
ToAbstractListElement >> newPrimarySelectionModel [

	^ ToPrimarySelectionModel new
]

{ #category : #skin }
ToAbstractListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #'instance creation' }
ToAbstractListElement >> newSecondarySelectionModel [

	^ self selectionModel newSecondarySelectionModel
]

{ #category : #'instance creation' }
ToAbstractListElement >> newSelectionModel [

	^ ToSelectionModel new
		  itemCountGetter: [ self dataSource itemCount ];
		  yourself
]

{ #category : #'t - infinite accessing' }
ToAbstractListElement >> next [

	^ next
]

{ #category : #accessing }
ToAbstractListElement >> nodeBuilder: aValuable [

	"aValuable takes 3 args: first, the node to build and second, its holder in the list element and the data item"
	nodeManager nodeBuilder: aValuable
]

{ #category : #accessing }
ToAbstractListElement >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	nodeManager nodeFactory: aValuable
]

{ #category : #accessing }
ToAbstractListElement >> nodeHolderClass: aNodeHolderClass [

	nodeManager nodeHolderClass: aNodeHolderClass
]

{ #category : #accessing }
ToAbstractListElement >> nodeManager [ 

	^ nodeManager
]

{ #category : #'event firing' }
ToAbstractListElement >> notifyDataSourceChanged [

	
	self dataSource notifyChanged
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
				originalIndex := aSieve originalIndexOf: d.
				aSieve selectionModel
					transferSelectionFromIndex: originalIndex
					toIndex: localIndex
					in: self selectionModel ] ]
		ifEmpty: [
		self selectionModel copySelectionFrom: aSieve selectionModel ]
]

{ #category : #accessing }
ToAbstractListElement >> overContainer [

	^ overContainer
]

{ #category : #'t - element with placeholder' }
ToAbstractListElement >> placeholderElevation [

	^ self innerContainer elevation
]

{ #category : #accessing }
ToAbstractListElement >> primarySelectionElements [

	^ Array streamContents: [ :stream |
		  overContainer childrenDo: [ :child |
			  (child isKindOf: self selectionMode elementClass) ifTrue: [
				  stream nextPut: child ] ].
		  beneathContainer childrenDo: [ :child |
			  (child isKindOf: self selectionMode elementClass) ifTrue: [
				  stream nextPut: child ] ] ]
]

{ #category : #'t - infinite accessing' }
ToAbstractListElement >> scrollToIndexAtTop: anIndex [

	self
		deprecated: 'Use scrollToDataSourcePosition: instead'
		transformWith: '`@receiver scrollToIndexAtTop: `@argument'
			-> '`@receiver scrollToDataSourcePosition: `@argument'.
	self scrollToDataSourcePosition: anIndex
]

{ #category : #accessing }
ToAbstractListElement >> secondarySelecter [ 

	^ self secondarySelectionMode selecter
]

{ #category : #accessing }
ToAbstractListElement >> secondarySelectionElements [

	^ Array streamContents: [ :stream |
		  overContainer childrenDo: [ :child |
			  (child isKindOf: secondarySelectionMode elementClass) ifTrue: [
				  stream nextPut: child ] ].
		  beneathContainer childrenDo: [ :child |
			  (child isKindOf: secondarySelectionMode elementClass) ifTrue: [
				  stream nextPut: child ] ] ]
]

{ #category : #accessing }
ToAbstractListElement >> secondarySelectionMode [

	^ secondarySelectionMode
]

{ #category : #accessing }
ToAbstractListElement >> secondarySelectionMode: aSelectionMode [

	secondarySelectionMode ifNotNil: [ secondarySelectionMode onUninstalledIn: self ].
	secondarySelectionMode := aSelectionMode.
	secondarySelectionMode ifNotNil: [ secondarySelectionMode onInstalledIn: self ].
	self dispatchEvent: ToListSecondarySelectionModeChangedEvent new
]

{ #category : #accessing }
ToAbstractListElement >> secondarySelectionModel [

	^ self secondarySelectionMode selectionModel
]

{ #category : #accessing }
ToAbstractListElement >> selecter [ 

	^ selectionMode selecter
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

	^ selectionMode selectionModel
]

{ #category : #'private - commands' }
ToAbstractListElement >> sieveResultWith: aSieve [

	self dataAccessor sieveResultWith: aSieve
]

{ #category : #accessing }
ToAbstractListElement >> unselectableSelecter [

	^ self selecter subSelecterWithId: #unselectable
]

{ #category : #accessing }
ToAbstractListElement >> unselectableSelectionModel [

	^ self unselectableSelecter selectionModel
]

{ #category : #'additional selecters' }
ToAbstractListElement >> withAdditionalSelecterWithId: aSymbol withEventClass: anEventClass [

	| additional |
	additional := ToAdditionalSelecter new.
	additional uniqueId: aSymbol.
	additional eventClass: anEventClass.
	additional parentSelecter: self selecter.
	additional onInstalledIn: self.
	^ additional
	

]

{ #category : #'additional selecters' }
ToAbstractListElement >> withDisabledSelecter [

	self withAdditionalSelecterWithId: #disabled withEventClass: ToListDisabledSelectionChangedEvent
	

]

{ #category : #'additional selecters' }
ToAbstractListElement >> withHiddenSelecter [

	self withAdditionalSelecterWithId: #hidden withEventClass: ToListHiddenSelectionChangedEvent

]

{ #category : #'additional selecters' }
ToAbstractListElement >> withUnselectableSelecter [

	self withAdditionalSelecterWithId: #unselectable withEventClass: ToListUnselectableSelectionChangedEvent

]

{ #category : #'additional selecters' }
ToAbstractListElement >> withoutDisabledSelecter [

	(self selecter subSelecterWithId: #disabled) ifNotNil: [ :selecter |
		selecter onUninstalledIn: self ]
]

{ #category : #'additional selecters' }
ToAbstractListElement >> withoutHiddenSelecter [

	(self selecter subSelecterWithId: #hidden) ifNotNil: [ :selecter |
		selecter onUninstalledIn: self ]
]

{ #category : #'additional selecters' }
ToAbstractListElement >> withoutUnselectableSelecter [

	(self selecter subSelecterWithId: #unselectable) ifNotNil: [ :selecter |
		selecter onUninstalledIn: self ]
]
