Class {
	#name : #ToBasicListElement,
	#superclass : #ToElement,
	#traits : 'TToCheckableSelectionManager + TToListElementDecorator + TToElementWithPlaceholder + TToOrientable',
	#classTraits : 'TToCheckableSelectionManager classTrait + TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait + TToOrientable classTrait',
	#instVars : [
		'dataSource',
		'dataAccessor',
		'nodeManager',
		'selectionModeMap',
		'mouseMoveReplayRequested',
		'fakeDataItem',
		'useInfiniteLayout',
		'innerElement'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'instance creation' }
ToBasicListElement class >> finite [

	^ self basicNew
		  useInfiniteLayout: false;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
ToBasicListElement class >> infinite [

	^ self new
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> addFakeNodeContainer: aNodeContainer [

	self addChild: aNodeContainer at: 1
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> addSelectionMode: aSelectionMode [

	selectionModeMap
		at: aSelectionMode selectionChangedEventClass
		ifPresent: [ Error signal: 'Duplicate selection mode' ].
	selectionModeMap at: aSelectionMode selectionChangedEventClass put: aSelectionMode
]

{ #category : #'private - commands' }
ToBasicListElement >> addedDataSourceCommand: aCommand [

	self innerElementDo: [ :inner | inner addedDataSourceCommand: aCommand ]
]

{ #category : #configuration }
ToBasicListElement >> applyConfiguration [

	super applyConfiguration.
	self childrenDo: #applyConfiguration
]

{ #category : #'private - commands' }
ToBasicListElement >> applyDataSourceFilterCommand: aDataSourceCommand [
]

{ #category : #'private - commands' }
ToBasicListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
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
						d := self dataSource at: localIndex.
						originalIndex := sieve originalIndexOf: d.
						sieve selectionModel
							transferSelectionFromIndex: originalIndex
							toIndex: localIndex
							in: self selectionModel ] ]
		ifEmpty: [
		self selectionModel copySelectionFrom: sieve selectionModel ]
]

{ #category : #layout }
ToBasicListElement >> checkMouseMoveReplayRequest [

	mouseMoveReplayRequested ifFalse: [ ^ self ].
	self spaceDo: [ :sp |
		sp mouseProcessor handleLastMouseMove ].
	mouseMoveReplayRequested := false
]

{ #category : #layout }
ToBasicListElement >> consumeFinalStepCommands [

	self innerElement consumeFinalStepCommands

	
]

{ #category : #'t - element with context menu' }
ToBasicListElement >> contextMenuManagerClass [

	^ ToListElementContextMenuManager
]

{ #category : #'accessing selecters' }
ToBasicListElement >> contextMenuSelecter [ 

	^ self contextMenuSelectionMode selecter
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> contextMenuSelectionMode [

	^ 	self selectionModeWithEventClass: ToListContextMenuSelectionChangedEvent
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> contextMenuSelectionMode: aSelectionMode [

	self contextMenuSelectionMode ifNotNil: [ :m | m onUninstalledIn: self ].
	aSelectionMode ifNotNil: [ aSelectionMode onInstalledIn: self ]
]

{ #category : #'accessing - selection models' }
ToBasicListElement >> contextMenuSelectionModel [

	^ self	 contextMenuSelectionMode selectionModel
]

{ #category : #accessing }
ToBasicListElement >> dataAccessor [ 

	^ dataAccessor
]

{ #category : #accessing }
ToBasicListElement >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToBasicListElement >> dataSource: aDataSource [

	dataSource ifNotNil: [ BlImmutableObjectChangeError signal ].
	dataSource := aDataSource
]

{ #category : #accessing }
ToBasicListElement >> dataSourceManager [

	^ self innerElement dataSourceManager 
]

{ #category : #initialization }
ToBasicListElement >> defaultContextMenuSelectionMode [

	^ ToListContextMenuSelectionMode new
]

{ #category : #initialization }
ToBasicListElement >> defaultDataSource [

	^ ToSortableInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToBasicListElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> defaultFakeDataItem [

	^ nil
]

{ #category : #initialization }
ToBasicListElement >> defaultInnerElement [

	^ self defaultInnerElementClass onListElement: self
]

{ #category : #initialization }
ToBasicListElement >> defaultInnerElementClass [

	^ self useInfiniteLayout
		  ifTrue: [ ToInfiniteElement ]
		  ifFalse: [ ToInnerFiniteListElement ]
]

{ #category : #initialization }
ToBasicListElement >> defaultLayout [

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToBasicListElement >> defaultNodeManager [

	^ self defaultNodeManagerClass new
]

{ #category : #initialization }
ToBasicListElement >> defaultNodeManagerClass [

	^ ToBasicListNodeManager 
]

{ #category : #initialization }
ToBasicListElement >> defaultPrimarySelectionMode [

	^ self defaultPrimarySelectionModeClass new
]

{ #category : #initialization }
ToBasicListElement >> defaultPrimarySelectionModeClass [

	^ ToListPrimarySelectionMode
]

{ #category : #initialization }
ToBasicListElement >> defaultSecondarySelectionMode [

	^ ToListSecondarySelectionMode new.

]

{ #category : #initialization }
ToBasicListElement >> defaultUseInfiniteLayout [

	^ true
]

{ #category : #'accessing selecters' }
ToBasicListElement >> deselectedAtPosition: anInteger [

	self selecter deselectIndex: anInteger
]

{ #category : #'accessing selecters' }
ToBasicListElement >> disabledAtPosition: anInteger [

	self disabledSelecter selectOneMoreIndex: anInteger
]

{ #category : #'accessing selecters' }
ToBasicListElement >> disabledSelecter [ 

	^ self disabledSelectionMode selecter
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> disabledSelectionMode [

	^ self selectionModeWithEventClass: ToListDisabledSelectionChangedEvent
]

{ #category : #'accessing - selection models' }
ToBasicListElement >> disabledSelectionModel [

	^ self selectionModel disabledSelectionModel
]

{ #category : #'accessing selecters' }
ToBasicListElement >> enabledAtPosition: anInteger [

	self disabledSelecter deselectIndex: anInteger
]

{ #category : #layout }
ToBasicListElement >> extentChanged [
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> fakeDataItem [

	^ fakeDataItem
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> fakeDataItem: anObject [

	fakeDataItem := anObject
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> fakeNodeContainer [

	^ (self hasChildren and: [ self firstChild isFake ])
		  ifTrue: [ self firstChild ]
		  ifFalse: [ ]
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> fakeNodeContainer: aNodeContainer [

	self addChild: aNodeContainer at: 1
]

{ #category : #'t - item' }
ToBasicListElement >> flagAsDisabled: aBoolean [

	aBoolean ifTrue: [
			self selecter deselectAll.
			self secondarySelecter deselectAll ].
	super flagAsDisabled: aBoolean
]

{ #category : #'selection updating' }
ToBasicListElement >> forceUpdateAllSelections [

	self whenLayoutedDoOnce: [
			self selectionModes do: [ :mode |
					mode requestNewRepresentation.
					self updateModeSelectionFrom: mode ] ].
	self requestLayout
]

{ #category : #'accessing selecters' }
ToBasicListElement >> hiddenAtPosition: anInteger [

	self hiddenSelecter selectIndex: anInteger
]

{ #category : #'accessing selecters' }
ToBasicListElement >> hiddenSelecter [ 

	^ self hiddenSelectionMode selecter 
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> hiddenSelectionMode [

	^ self selectionModeWithEventClass: ToListHiddenSelectionChangedEvent 
]

{ #category : #'accessing - selection models' }
ToBasicListElement >> hiddenSelectionModel [  

	^ self selectionModel hiddenSelectionModel 
]

{ #category : #initialization }
ToBasicListElement >> initialize [

	super initialize.
	
	mouseMoveReplayRequested := false.
	selectionModeMap := IdentityDictionary new.

	self initializeDataSource.
	self initializeDataAccessor.

	self layout: self defaultLayout.

	self addEventHandler: self defaultEventHandler.
	self primarySelectionMode: self defaultPrimarySelectionMode.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self contextMenuSelectionMode: self defaultContextMenuSelectionMode.
	self newUnselectableSelectionMode onInstalledIn: self.
	self newHiddenSelectionMode onInstalledIn: self.
	self newDisabledSelectionMode onInstalledIn: self.

	self initializeInnerElement.
	fakeDataItem := self defaultFakeDataItem.
	self installFakeNodeContainer.

	self matchParent 
]

{ #category : #initialization }
ToBasicListElement >> initializeDataAccessor [

	dataAccessor := self dataSource
]

{ #category : #initialization }
ToBasicListElement >> initializeDataSource [ 

	self dataSource: self defaultDataSource
]

{ #category : #initialization }
ToBasicListElement >> initializeInnerElement [

	innerElement := self defaultInnerElement.
	innerElement elevation: (BlRelativeElevation elevation: 10).
	self addChild: innerElement
]

{ #category : #configuration }
ToBasicListElement >> innerConfiguration [ 

	^ self innerElement toConfiguration
]

{ #category : #configuration }
ToBasicListElement >> innerConfigurationDo: aBlock [

	^ aBlock value: self innerConfiguration
]

{ #category : #'t - list element decorator - infinite accessing' }
ToBasicListElement >> innerElement [

	"innerElement ifNil: [
			self initializeInnerElement.
			fakeDataItem := self defaultFakeDataItem.
			self installFakeNodeContainer.
			self notifyDataSourceChanged ]."
	^ innerElement innerElement
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> installFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeContainer holder |
	holder := self nodeManager newHolder.
	holder infiniteElement: self innerElement.
	holder dataItem: self fakeDataItem.
	holder bindAtPosition: 0.
	fakeContainer := self newFakeNodeContainer.
	" assigning the holder builds the middleContainer (which is the node of the fake node container) "
	fakeContainer holder: holder.
	fakeContainer id: #fakeNodeContainer.
	fakeContainer node id: #fakeNode.
	holder setupNodeContainerWith: fakeContainer.
	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	self addFakeNodeContainer: fakeContainer.
	self nodeManager buildNode: fakeContainer node.
	self requestConfiguration
]

{ #category : #testing }
ToBasicListElement >> isMultipleSelection [

	^ self primarySelectionMode isMultipleSelection
]

{ #category : #'accessing selecters' }
ToBasicListElement >> isSelectedAtPosition: anInteger [

	^ self selectionModel containsIndex: anInteger
]

{ #category : #accessing }
ToBasicListElement >> itemCount [

	^ self dataSource itemCount
]

{ #category : #layout }
ToBasicListElement >> minNodeWidth [

	^ 0
]

{ #category : #'instance creation' }
ToBasicListElement >> newDisabledSelectionMode [
	" note that a disabled mode need an event handler to force the building of disabled nodes "

	^ ToListDisabledSelectionMode parentMode: self primarySelectionMode
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> newFakeNodeContainer [ 

	^ ToFakeNodeContainer new
]

{ #category : #'instance creation' }
ToBasicListElement >> newHiddenSelectionMode [

	^ ToListHiddenSelectionMode parentMode: self primarySelectionMode
]

{ #category : #skin }
ToBasicListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #'instance creation' }
ToBasicListElement >> newSieve [

	^ self sieveClass new
		  onInstalledIn: self;
		  yourself
]

{ #category : #configuration }
ToBasicListElement >> newToConfiguration [ 

	^ ToBasicListElementConfiguration new
]

{ #category : #'instance creation' }
ToBasicListElement >> newUnselectableSelectionMode [


	^ ToListUnselectableSelectionMode parentMode: self primarySelectionMode
]

{ #category : #'t - list element decorator - infinite accessing' }
ToBasicListElement >> next [

	^ self innerElement
]

{ #category : #accessing }
ToBasicListElement >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	self nodeManager nodeFactory: aValuable.
	self notifyDataSourceChanged
]

{ #category : #accessing }
ToBasicListElement >> nodeManager [ 

	^ nodeManager ifNil: [ nodeManager := self defaultNodeManager ]
]

{ #category : #'selection updating' }
ToBasicListElement >> notifyClickOnNode: aNode fromEvent: anEvent [

	| req min |
	aNode isAttachedToSceneGraph ifFalse: [ ^ self ].
	self isDisabled ifTrue: [ ^ self ].

	" in case the listElement is not focused (and focusable), 
	check if the selection has to be preserved.
	If it is to be preserve the do nothing here.
	The listElement event handler will request the focus"
	(self isFocusable and: [ self hasFocus not ]) ifTrue: [
		" the node may have the focus for keyboard input as an example.
		The listElement should not take the focus in this case "
		aNode hasFocus ifFalse: [self requestFocus].
		min := self selectionMode minSelectedIndexesCountForSelectionPreserving.
		self selectionModel selectedIndexesCount > min ifTrue: [
			^ self ] ].
	
	req := ToListClickOnNodeRequestEvent new
		       requestedAction: [
			       aNode dispatchEvent: (ToListClickOnNodeEvent new
						        fillFromTime: aNode space time;
						        sourceEvent: anEvent;
						        yourself) ];
		       yourself.

	aNode dispatchRequest: req
]

{ #category : #notifications }
ToBasicListElement >> notifyDataSourceChanged [

	
	self dataSource notifyChanged
]

{ #category : #notifications }
ToBasicListElement >> notifyDataSourceItemsFiltered: aDataSourceEvent [

	
	self dispatchEvent: aDataSourceEvent
]

{ #category : #'private - commands' }
ToBasicListElement >> offsetPositionRecordsForFilter: aStartPosition itemCount: anItemCount fromSieve: aSieve [

	aSieve pattern
		ifNotEmpty: [
			self dataSource withIndexDo: [ :d :localIndex |
				| originalIndex |
				originalIndex := aSieve originalIndexOf: d.
				aSieve selectionModel
					transferSelectionFromIndex: originalIndex
					toIndex: localIndex
					in: self selectionModel ] ]
		ifEmpty: [
		self selectionModel copySelectionFrom: aSieve selectionModel ]
]

{ #category : #'hooks - layout' }
ToBasicListElement >> onLayoutDone [

	super onLayoutDone.
	self checkMouseMoveReplayRequest 
]

{ #category : #'private - commands' }
ToBasicListElement >> onSievedWith: aSieve [

	self dataSource onSievedWith: aSieve.
	self requestLayout
]

{ #category : #'t - element with placeholder' }
ToBasicListElement >> placeholderClass [

	^ ToEmptyPlaceholderLayer
]

{ #category : #layout }
ToBasicListElement >> postponeAction: aValuable [

	self innerElement postponeAction: aValuable for: self
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> primarySelectionMode [

	^ self selectionModeWithEventClass: ToListPrimarySelectionChangedEvent 
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> primarySelectionMode: aSelectionMode [

	self primarySelectionMode ifNotNil: [ :m | m onUninstalledIn: self ].
	aSelectionMode ifNotNil: [ aSelectionMode onInstalledIn: self ].
	self dispatchEvent: ToListPrimarySelectionModeChangedEvent new.
	self requestNewSkin
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> reinstallFakeNodeContainer [
	" the fake node is added in case of an empty data source to ensure a 
	suitable minimum height according to the node class, the node builder 
	and the data kind."

	| fakeContainer holder |
	fakeContainer := self fakeNodeContainer.
	holder := fakeContainer holder.
	holder dataItem: self fakeDataItem.
	" add the fake node (to keep a constant minimum size ).
	Pay attention to add the fake node ** before ** the fake node building "
	self nodeManager buildNode: fakeContainer node.
	self requestConfiguration
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> removeSelectionMode: aSelectionMode [

	selectionModeMap
		at: aSelectionMode selectionChangedEventClass
		ifAbsent: [ Error signal: 'Selection mode not found' ].
	selectionModeMap removeKey: aSelectionMode selectionChangedEventClass
]

{ #category : #layout }
ToBasicListElement >> requestLayout: aSourceElement [

	super requestLayout: aSourceElement.
	(aSourceElement = innerElement or: [ aSourceElement parent = innerElement ])
		ifTrue: [ self requestMouseMoveReplay ]
]

{ #category : #layout }
ToBasicListElement >> requestMouseMoveReplay [

	mouseMoveReplayRequested := true
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> sample [

	^ self fakeDataItem
]

{ #category : #'t - finite list element - fake container' }
ToBasicListElement >> sample: aDataItem [

	self fakeDataItem: aDataItem.
	self reinstallFakeNodeContainer.
	self requestLayout
	
]

{ #category : #'accessing selecters' }
ToBasicListElement >> secondarySelecter [ 

	^ self secondarySelectionMode selecter
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> secondarySelectionMode [

	^ self selectionModeWithEventClass: ToListSecondarySelectionChangedEvent
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> secondarySelectionMode: aSelectionMode [

	self secondarySelectionMode ifNotNil: [ :m | m onUninstalledIn: self ].
	aSelectionMode ifNotNil: [ aSelectionMode onInstalledIn: self ].
	self dispatchEvent: ToListSecondarySelectionModeChangedEvent new.
	self requestNewSkin.

]

{ #category : #'accessing - selection models' }
ToBasicListElement >> secondarySelectionModel [

	^ self secondarySelectionMode selectionModel
]

{ #category : #accessing }
ToBasicListElement >> secondarySelectionOption [

	^ self secondarySelectionMode selectionOption
]

{ #category : #'accessing selecters' }
ToBasicListElement >> selectableAtPosition: anInteger [

	self unselectableSelecter deselectIndex: anInteger
]

{ #category : #'accessing selecters' }
ToBasicListElement >> selectedAtPosition: anInteger [

	self selecter selectIndex: anInteger
]

{ #category : #'accessing selecters' }
ToBasicListElement >> selecter [

	^ self primarySelectionMode selecter
]

{ #category : #'accessing selecters' }
ToBasicListElement >> selectionElementsDo: aBlock [

	selectionModeMap valuesDo: [ :mode |
		mode selectionOptionDo: [ :opt | opt selectionElements do: [ :se | aBlock value: se ] ] ]
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> selectionMode [

	^ self primarySelectionMode
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> selectionModeWithEventClass: aSelectionChangedEventClass [

	^ selectionModeMap at: aSelectionChangedEventClass ifAbsent: [  ]
]

{ #category : #'accessing - selection models' }
ToBasicListElement >> selectionModel [

	^ self primarySelectionMode selectionModel
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> selectionModes [

	^ selectionModeMap values
]

{ #category : #accessing }
ToBasicListElement >> selectionOption [

	^ self primarySelectionMode selectionOption
]

{ #category : #'instance creation' }
ToBasicListElement >> sieveClass [

	^ ToListElementSieve
]

{ #category : #sorting }
ToBasicListElement >> sort: aSortBlock [

	self selecter
		updateSelectionAfter: [ self dataAccessor sort: aSortBlock ]
		withDataAccessor: self dataAccessor
]

{ #category : #'accessing selecters' }
ToBasicListElement >> unselectableAtPosition: anInteger [

	self unselectableSelecter selectOneMoreIndex: anInteger
]

{ #category : #'accessing selecters' }
ToBasicListElement >> unselectableSelecter [

	^ self unselectableSelectionMode selecter
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> unselectableSelectionMode [

	^ self selectionModeWithEventClass: ToListUnselectableSelectionChangedEvent 
]

{ #category : #'accessing - selection models' }
ToBasicListElement >> unselectableSelectionModel [

	^ self selectionModel unselectableSelectionModel
]

{ #category : #'selection updating' }
ToBasicListElement >> updateAllSelections [

	self selectionModes do: [ :mode | self updateModeSelectionFrom: mode ]
]

{ #category : #'selection updating' }
ToBasicListElement >> updateModeSelectionFrom: aMode [

	aMode selectionOption ifNotNil: [ :option |
		option
			updateSelectionIn: self
			withSelectionModel: aMode selectionModel ]
]

{ #category : #'selection updating' }
ToBasicListElement >> updatePrimarySelection [

	self updateModeSelectionFrom: self selectionMode
]

{ #category : #'selection updating' }
ToBasicListElement >> updateSecondarySelection [

	self updateModeSelectionFrom: self secondarySelectionMode
]

{ #category : #'selection updating' }
ToBasicListElement >> updateSelectionAfter: aValuable [

	self selecter
		updateSelectionAfter: aValuable
		withDataAccessor: self dataAccessor.
	self postponeAction: [ self notifyDataSourceChanged ]
]

{ #category : #configuration }
ToBasicListElement >> useCheckbox [

	^ self toConfigurationDo: [ :conf | conf useCheckbox ]
]

{ #category : #configuration }
ToBasicListElement >> useCheckbox: aBoolean [

	self toConfigurationDo: [ :conf | conf useCheckbox: aBoolean ]
]

{ #category : #accessing }
ToBasicListElement >> useInfiniteLayout [

	^ useInfiniteLayout ifNil: [
		  useInfiniteLayout := self defaultUseInfiniteLayout ]
]

{ #category : #accessing }
ToBasicListElement >> useInfiniteLayout: aBoolean [ 

	useInfiniteLayout = aBoolean ifTrue: [ ^ self ].
	useInfiniteLayout := aBoolean
]

{ #category : #'accessing selecters' }
ToBasicListElement >> visibleAtPosition: anInteger [

	self hiddenSelecter deselectIndex: anInteger
]
