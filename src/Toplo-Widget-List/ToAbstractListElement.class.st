Class {
	#name : #ToAbstractListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator + TToElementWithPlaceholder + TToOrientable',
	#classTraits : 'TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait + TToOrientable classTrait',
	#instVars : [
		'next',
		'dataSource',
		'nodeManager',
		'commandChecker',
		'withContextMenuSelection',
		'selectionModeMap'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #accessing }
ToAbstractListElement >> addSelectionMode: aSelectionMode [

	selectionModeMap
		at: aSelectionMode selectionChangedEventClass
		ifPresent: [ Error signal: 'Duplicate selection mode' ].
	selectionModeMap at: aSelectionMode selectionChangedEventClass put: aSelectionMode
]

{ #category : #'private - commands' }
ToAbstractListElement >> allowApplicationOfCommand: aCommand [

	^ self commandChecker allowCommand: aCommand
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
ToAbstractListElement >> commandChecker [

	^ commandChecker
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> contextMenuSelecter [ 

	^ self contextMenuSelectionMode selecter
]

{ #category : #accessing }
ToAbstractListElement >> contextMenuSelectionMode [

	^ 	self selectionModeWithEventClass: ToListContextMenuSelectionChangedEvent
]

{ #category : #accessing }
ToAbstractListElement >> contextMenuSelectionMode: aSelectionMode [

	self contextMenuSelectionMode ifNotNil: [ :m | m uninstall ].
	aSelectionMode ifNotNil: [ aSelectionMode on: self ]
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
ToAbstractListElement >> defaultCommandCheckerClass [

	^ ToListElementCommandChecker 
]

{ #category : #initialization }
ToAbstractListElement >> defaultContextMenuSelectionMode [

	^ ToListContextMenuSelectionMode new
]

{ #category : #initialization }
ToAbstractListElement >> defaultContextMenuWindowManagerClass [

	^ ToListElementContextMenuWindowManager
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
ToAbstractListElement >> defaultInnerContainer [ 

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
ToAbstractListElement >> defaultPrimarySelectionMode [

	^ self defaultPrimarySelectionModeClass new
]

{ #category : #initialization }
ToAbstractListElement >> defaultPrimarySelectionModeClass [

	^ ToListPrimarySelectionMode
]

{ #category : #initialization }
ToAbstractListElement >> defaultSecondarySelectionMode [

	^ ToListSecondarySelectionMode new.

]

{ #category : #'accessing selecters' }
ToAbstractListElement >> disabledSelecter [ 

	^ self disabledSelectionMode selecter
]

{ #category : #'instance creation' }
ToAbstractListElement >> disabledSelectionMode [

	^ self selectionModeWithEventClass: ToListDisabledSelectionChangedEvent
]

{ #category : #accessing }
ToAbstractListElement >> disabledSelectionModel [

	^ self selectionModel disabledSelectionModel
]

{ #category : #accessing }
ToAbstractListElement >> fakeNode [

	^ nil
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> hiddenSelecter [ 

	^ self hiddenSelectionMode selecter 
]

{ #category : #accessing }
ToAbstractListElement >> hiddenSelectionMode [

	^ self selectionModeWithEventClass: ToListHiddenSelectionChangedEvent 
]

{ #category : #accessing }
ToAbstractListElement >> hiddenSelectionModel [  

	^ self selectionModel hiddenSelectionModel 
]

{ #category : #initialization }
ToAbstractListElement >> initialize [

	super initialize.

	nodeManager := self defaultNodeManager.
	withContextMenuSelection := true.
	selectionModeMap := IdentityDictionary new.

	self initializeDataSource.
	self initializeCommandChecker.
	self initializeInnerContainer.

	self layout: self defaultLayout.

	self addEventHandler: self defaultEventHandler.
	self primarySelectionMode: self defaultPrimarySelectionMode.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self contextMenuSelectionMode: self defaultContextMenuSelectionMode.
	self contextMenuWindowManagerClass:
		self defaultContextMenuWindowManagerClass.

	self matchParent
]

{ #category : #initialization }
ToAbstractListElement >> initializeCommandChecker [

	commandChecker := self defaultCommandCheckerClass new.
	commandChecker listElement: self
]

{ #category : #initialization }
ToAbstractListElement >> initializeDataSource [ 

	self dataSource: self defaultDataSource
]

{ #category : #initialization }
ToAbstractListElement >> initializeInnerContainer [

	next := self defaultInnerContainer.
	self next elevation: (BlRelativeElevation elevation: 10).
	self addChild: self next.

]

{ #category : #testing }
ToAbstractListElement >> isMultipleSelection [

	^ self primarySelectionMode isMultipleSelection
]

{ #category : #accessing }
ToAbstractListElement >> isWithContextMenuSelection [

	^ withContextMenuSelection
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
ToAbstractListElement >> newDisabledSelectionMode [

	^ self newSubSelectionModeWithEventClass: ToListDisabledSelectionChangedEvent
]

{ #category : #'instance creation' }
ToAbstractListElement >> newHiddenSelectionMode [

	^ self newSubSelectionModeWithEventClass: ToListHiddenSelectionChangedEvent
]

{ #category : #skin }
ToAbstractListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #'instance creation' }
ToAbstractListElement >> newSubSelectionModeWithEventClass: aSelectionChangedEventClass [

	^ (ToListSubSelectionMode parentMode: self primarySelectionMode)
		  selectionChangedEventClass: aSelectionChangedEventClass;
		  yourself
]

{ #category : #'instance creation' }
ToAbstractListElement >> newUnselectableSelectionMode [


	^ self newSubSelectionModeWithEventClass: ToListUnselectableSelectionChangedEvent
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

	nodeManager holderClass: aNodeHolderClass
]

{ #category : #accessing }
ToAbstractListElement >> nodeManager [ 

	^ nodeManager
]

{ #category : #accessing }
ToAbstractListElement >> nodeUnbuilder: aValuable [

	"aValuable takes 3 args: first, the node to build and second, its holder in the list element and the data item"
	nodeManager nodeUnbuilder: aValuable
]

{ #category : #'event firing' }
ToAbstractListElement >> notifyDataSourceChanged [

	
	self dataSource notifyChanged
]

{ #category : #'event firing' }
ToAbstractListElement >> notifyDataSourceItemChanged: aDataSourceEvent [

	| request |
	request := ToListDataSourceItemChangeRequestEvent new
		           dataSourceEvent: aDataSourceEvent;
		           requestedAction: [ self dispatchEvent: aDataSourceEvent ];
		           yourself.
	self dispatchAuthorisationRequest: request
]

{ #category : #'event firing' }
ToAbstractListElement >> notifyDataSourceItemsFiltered: aDataSourceEvent [

	
	self dispatchEvent: aDataSourceEvent
]

{ #category : #'event firing' }
ToAbstractListElement >> notifyPrimarySelectionDirty [

	self dispatchEvent: (ToListPrimarySelectionDirtyEvent new
			 selectionOption: self primarySelectionMode option;
			 itemCount: self itemCount;
			 yourself)
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

{ #category : #'hooks - scrolling' }
ToAbstractListElement >> onScrolled: aPoint [
]

{ #category : #'t - element with placeholder' }
ToAbstractListElement >> placeholderElevation [

	^ self innerContainer elevation
]

{ #category : #accessing }
ToAbstractListElement >> primarySelectionMode [

	^ self selectionModeWithEventClass: ToListPrimarySelectionChangedEvent 
]

{ #category : #accessing }
ToAbstractListElement >> primarySelectionMode: aSelectionMode [

	self primarySelectionMode ifNotNil: [ :m | m uninstall ].
	aSelectionMode ifNotNil: [ aSelectionMode on: self ].
	self dispatchEvent: ToListPrimarySelectionModeChangedEvent new.
	self requestNewSkin
]

{ #category : #accessing }
ToAbstractListElement >> removeSelectionMode: aSelectionMode [

	selectionModeMap
		at: aSelectionMode selectionChangedEventClass
		ifAbsent: [ Error signal: 'Selection mode not found' ].
	selectionModeMap removeKey: aSelectionMode selectionChangedEventClass
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> secondarySelecter [ 

	^ self secondarySelectionMode selecter
]

{ #category : #accessing }
ToAbstractListElement >> secondarySelectionMode [

	^ self selectionModeWithEventClass: ToListSecondarySelectionChangedEvent
]

{ #category : #accessing }
ToAbstractListElement >> secondarySelectionMode: aSelectionMode [

	self secondarySelectionMode ifNotNil: [ :m | m uninstall ].
	aSelectionMode ifNotNil: [ aSelectionMode on: self ].
	self dispatchEvent: ToListSecondarySelectionModeChangedEvent new.
	self requestNewSkin.

]

{ #category : #accessing }
ToAbstractListElement >> secondarySelectionModel [

	^ self secondarySelectionMode selectionModel
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> selecter [

	^ self primarySelectionMode selecter
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> selectionElementsDo: aBlock [

	selectionModeMap valuesDo: [ :mode |
		mode optionDo: [ :opt | opt selectionElements do: [ :se | aBlock value: se ] ] ]
]

{ #category : #accessing }
ToAbstractListElement >> selectionMode [

	self
		deprecated: 'use #primarySelectionMode'
		transformWith:
		'`@rcvr selectionMode' -> '`@rcvr primarySelectionMode'.
	^ self primarySelectionMode
]

{ #category : #accessing }
ToAbstractListElement >> selectionMode: aSelectionMode [

	self
		deprecated: 'use #primarySelectionMode:'
		transformWith:
		'`@rcvr selectionMode: `@arg'
		-> '`@rcvr primarySelectionMode: `@arg'.

	self primarySelectionMode: aSelectionMode
]

{ #category : #accessing }
ToAbstractListElement >> selectionModeWithEventClass: aSelectionChangedEventClass [

	^ selectionModeMap at: aSelectionChangedEventClass ifAbsent: [  ]
]

{ #category : #accessing }
ToAbstractListElement >> selectionModel [

	^ self primarySelectionMode selectionModel
]

{ #category : #accessing }
ToAbstractListElement >> selectionModes [

	^ selectionModeMap values
]

{ #category : #'private - commands' }
ToAbstractListElement >> sieveResultWith: aSieve [

	self dataAccessor sieveResultWith: aSieve
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> unselectableSelecter [

	^ self unselectableSelectionMode selecter
]

{ #category : #accessing }
ToAbstractListElement >> unselectableSelectionMode [

	^ self selectionModeWithEventClass: ToListUnselectableSelectionChangedEvent 
]

{ #category : #accessing }
ToAbstractListElement >> unselectableSelectionModel [

	^ self selectionModel unselectableSelectionModel
]

{ #category : #accessing }
ToAbstractListElement >> withContextMenuSelection: aBoolean [

	withContextMenuSelection := aBoolean
]
