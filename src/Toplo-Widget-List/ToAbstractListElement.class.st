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

{ #category : #accessing }
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
ToAbstractListElement >> contextMenuSelectionModel [

	^ self contextMenuSelecter selectionModel
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

	| mode |
	mode := ToListContextMenuSelectionMode new.
	mode listEventHandler:
		(self newContextMenuSelectionEventHandler selectionMode: mode).
	mode selecter: (ToListSelecter new
			 selectionModel: self newSelectionModel;
			 selectionChangedEventClass: ToListContextMenuSelectionChangedEvent;
			 yourself).
	mode elementBuilder: [ ToListContextMenuSelectionElement new ].
	^ mode
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
ToAbstractListElement >> defaultSecondarySelectionMode [

	| mode |
	mode := ToListSecondarySelectionMode new.
	mode listEventHandler:
		(self newSecondarySelectionEventHandler selectionMode: mode).
	mode selecter: (ToListSelecter new
			 commandApplierEventHandler:
				 ToDataSourceCommandApplierEventHandler new;
			 selectionModel: self newSecondarySelectionModel;
			 selectionChangedEventClass: ToListSecondarySelectionChangedEvent;
			 yourself).
	mode elementBuilder: [ ToListSecondarySelectionElement new ].
	^ mode
]

{ #category : #initialization }
ToAbstractListElement >> defaultSelectionMode [

	^ self defaultSelectionModeClass new
		  in: [ :mode |
			  mode listEventHandler:
					  (self newPrimarySelectionEventHandler selectionMode: mode) ];
		  selecter: (ToCompositeSelecter new
				   selectionModel: self newPrimarySelectionModel;
				   selectionChangedEventClass: ToListPrimarySelectionChangedEvent;
				   yourself);
		  elementBuilder: [ ToListPrimarySelectionElement new ];
		  yourself
]

{ #category : #initialization }
ToAbstractListElement >> defaultSelectionModeClass [

	^ ToListPrimarySelectionMode
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
ToAbstractListElement >> fakeNode [

	^ nil
]

{ #category : #accessing }
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
	self selectionMode: self defaultSelectionMode.
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
ToAbstractListElement >> newContextMenuSelectionEventHandler [

	^ ToListContextMenuSelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToAbstractListElement >> newDisabledSelectionMode [

	^ ToListAdditionalSelectionMode
		  selecter: self disabledSelecter
		  listEventHandler: ToListDisabledSelectionElementEventHandler new
		  elementBuilder: [ ToListDisabledSelectionElement new ]
]

{ #category : #'instance creation' }
ToAbstractListElement >> newPrimarySelectionEventHandler [

	^ ToListPrimarySelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToAbstractListElement >> newPrimarySelectionModel [

	^ ToPrimarySelectionModel new
		  on: self;
		  yourself
]

{ #category : #skin }
ToAbstractListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #'instance creation' }
ToAbstractListElement >> newSecondarySelectionEventHandler [

	^ ToListSecondarySelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToAbstractListElement >> newSecondarySelectionModel [

	^ self selectionModel newSecondarySelectionModel
		  on: self;
		  yourself
]

{ #category : #'instance creation' }
ToAbstractListElement >> newSelectionModel [

	^ ToSelectionModel new
		  itemCountGetter: [ self dataSource itemCount ];
		  yourself
]

{ #category : #'instance creation' }
ToAbstractListElement >> newUnselectableSelectionMode [

	^ ToListAdditionalSelectionMode
		  selecter: self unselectableSelecter
		  listEventHandler:
		  ToListUnselectableSelectionElementEventHandler new
		  elementBuilder: [ ToListUnselectableSelectionElement new ]
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
ToAbstractListElement >> notifyDataSourceItemChanged: aDataSourceEvent [

	| request |
	request := ToListDataSourceItemChangeRequestEvent new
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

{ #category : #'hooks - scrolling' }
ToAbstractListElement >> onScrolled: aPoint [
]

{ #category : #'t - element with placeholder' }
ToAbstractListElement >> placeholderElevation [

	^ self innerContainer elevation
]

{ #category : #accessing }
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
	additional := ToListSelecter
		              additionalNamed: aSymbol
		              inParentSelecter: self selecter
		              withEventClass: anEventClass.
	additional onInstalledIn: self.
	^ additional
]

{ #category : #accessing }
ToAbstractListElement >> withContextMenuSelection: aBoolean [

	withContextMenuSelection := aBoolean
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
