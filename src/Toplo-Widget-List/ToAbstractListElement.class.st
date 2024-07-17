Class {
	#name : #ToAbstractListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator + TToElementWithPlaceholder + TToOrientable',
	#classTraits : 'TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait + TToOrientable classTrait',
	#instVars : [
		'next',
		'selectionMode',
		'secondarySelectionMode',
		'contextMenuSelectionMode',
		'dataSource',
		'nodeManager',
		'commandChecker',
		'withContextMenuSelection'
	],
	#category : #'Toplo-Widget-List-Core'
}

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

	^ contextMenuSelectionMode
]

{ #category : #accessing }
ToAbstractListElement >> contextMenuSelectionMode: aSelectionMode [

	contextMenuSelectionMode ifNotNil: [ contextMenuSelectionMode onUninstalledIn: self ].
	contextMenuSelectionMode := aSelectionMode.
	contextMenuSelectionMode ifNotNil: [ contextMenuSelectionMode onInstalledIn: self ]
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

	^ ToListSecondarySelectionMode new
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> disabledSelecter [ 

	^ self selecter subSelecterWithId: #disabled
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

	^ self selecter subSelecterWithId: #hidden
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

	self initializeDataSource.
	self initializeCommandChecker.
	self initializeInnerContainer.

	self layout: self defaultLayout.

	self addEventHandler: self defaultEventHandler.
	self selectionMode: self defaultPrimarySelectionMode.
	self contextMenuWindowManagerClass: self defaultContextMenuWindowManagerClass.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self contextMenuSelectionMode: self defaultContextMenuSelectionMode.

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

	^ self selectionMode isMultipleSelection
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

	^ ToListDisabledSelectionMode parentMode: self selectionMode
]

{ #category : #'instance creation' }
ToAbstractListElement >> newHiddenSelectionMode [

	^ ToListHiddenSelectionMode parentMode: self selectionMode
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

{ #category : #'instance creation' }
ToAbstractListElement >> newUnselectableSelectionMode [

	^ ToListUnselectableSelectionMode parentMode: self selectionMode
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

{ #category : #'accessing selecters' }
ToAbstractListElement >> secondarySelecter [ 

	^ self secondarySelectionMode selecter
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

{ #category : #'accessing selecters' }
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

{ #category : #'accessing selecters' }
ToAbstractListElement >> unselectableSelecter [

	^ self selecter subSelecterWithId: #unselectable
]

{ #category : #accessing }
ToAbstractListElement >> unselectableSelectionModel [

	^ self unselectableSelecter selectionModel
]

{ #category : #accessing }
ToAbstractListElement >> withContextMenuSelection: aBoolean [

	withContextMenuSelection := aBoolean
]

{ #category : #'configuring selecters' }
ToAbstractListElement >> withDisabledSelecter [

	self withSubSelecterWithId: #disabled withEventClass: ToListDisabledSelectionChangedEvent
	

]

{ #category : #'configuring selecters' }
ToAbstractListElement >> withHiddenSelecter [

	self withSubSelecterWithId: #hidden withEventClass: ToListHiddenSelectionChangedEvent

]

{ #category : #'configuring selecters' }
ToAbstractListElement >> withSubSelecterWithId: aSymbol withEventClass: anEventClass [

	| sub |
	sub := ToSubSelecter new
		       uniqueId: aSymbol;
		       selectionModel: ToSubSelectionModel new;
		       selectionChangedEventClass: anEventClass;
		       parentSelecter: self selecter;
		       yourself.
	sub onInstalledIn: self.
	^ sub
]

{ #category : #'configuring selecters' }
ToAbstractListElement >> withUnselectableSelecter [

	self withSubSelecterWithId: #unselectable withEventClass: ToListUnselectableSelectionChangedEvent

]

{ #category : #'configuring selecters' }
ToAbstractListElement >> withoutDisabledSelecter [

	(self selecter subSelecterWithId: #disabled) ifNotNil: [ :selecter |
		selecter onUninstalledIn: self ]
]

{ #category : #'configuring selecters' }
ToAbstractListElement >> withoutHiddenSelecter [

	(self selecter subSelecterWithId: #hidden) ifNotNil: [ :selecter |
		selecter onUninstalledIn: self ]
]

{ #category : #'configuring selecters' }
ToAbstractListElement >> withoutUnselectableSelecter [

	(self selecter subSelecterWithId: #unselectable) ifNotNil: [ :selecter |
		selecter onUninstalledIn: self ]
]
