Class {
	#name : #ToAbstractListElement,
	#superclass : #ToElement,
	#traits : 'TToCheckableSelectionManager + TToListElementDecorator + TToElementWithPlaceholder + TToOrientable',
	#classTraits : 'TToCheckableSelectionManager classTrait + TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait + TToOrientable classTrait',
	#instVars : [
		'next',
		'dataSource',
		'nodeManager',
		'selectionModeMap',
		'mouseMoveReplayRequested'
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
ToAbstractListElement >> addedDataSourceCommand: aCommand [

	self innerElementDo: [ :inner | inner addedDataSourceCommand: aCommand ]
]

{ #category : #configuration }
ToAbstractListElement >> applyConfiguration [

	super applyConfiguration.
	self innerElement applyConfiguration
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
ToAbstractListElement >> checkMouseMoveReplayRequest [

	mouseMoveReplayRequested ifFalse: [ ^ self ].
	self spaceDo: [ :sp |
		sp mouseProcessor handleLastMouseMove ].
	mouseMoveReplayRequested := false
]

{ #category : #layout }
ToAbstractListElement >> consumeFinalStepCommands [

	self innerElement consumeFinalStepCommands

	
]

{ #category : #initialization }
ToAbstractListElement >> contextMenuManagerClass [

	^ ToListElementContextMenuManager
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

	self contextMenuSelectionMode ifNotNil: [ :m | m onUninstalledIn: self ].
	aSelectionMode ifNotNil: [ aSelectionMode onInstalledIn: self ]
]

{ #category : #accessing }
ToAbstractListElement >> contextMenuSelectionModel [

	^ self	 contextMenuSelectionMode selectionModel
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
ToAbstractListElement >> dataSourceManager [

	^ self innerElement dataSourceManager 
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
ToAbstractListElement >> defaultContextMenuSelectionMode [

	^ ToListContextMenuSelectionMode new
]

{ #category : #initialization }
ToAbstractListElement >> defaultDataSource [

	^ ToSortableInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToAbstractListElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToAbstractListElement >> defaultInnerElement [

	^ self defaultInnerElementClass onListElement: self
]

{ #category : #initialization }
ToAbstractListElement >> defaultInnerElementClass [

	^ ToInfiniteElement
]

{ #category : #initialization }
ToAbstractListElement >> defaultLayout [

	^ BlLinearLayout vertical
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
ToAbstractListElement >> deselectedAtPosition: anInteger [

	self selecter deselectIndex: anInteger
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> disabledAtPosition: anInteger [

	self disabledSelecter selectOneMoreIndex: anInteger
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> disabledSelecter [ 

	^ self disabledSelectionMode selecter
]

{ #category : #accessing }
ToAbstractListElement >> disabledSelectionMode [

	^ self selectionModeWithEventClass: ToListDisabledSelectionChangedEvent
]

{ #category : #accessing }
ToAbstractListElement >> disabledSelectionModel [

	^ self selectionModel disabledSelectionModel
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> enabledAtPosition: anInteger [

	self disabledSelecter deselectIndex: anInteger
]

{ #category : #layout }
ToAbstractListElement >> extentChanged [
]

{ #category : #accessing }
ToAbstractListElement >> fakeNodeContainer [

	^ nil
]

{ #category : #'t - item' }
ToAbstractListElement >> flagAsDisabled: aBoolean [

	aBoolean ifTrue: [
		self selecter deselectAll.
		self secondarySelecter deselectAll ].
	super flagAsDisabled: aBoolean
]

{ #category : #'selection updating' }
ToAbstractListElement >> forceUpdateAllSelections [

	self whenLayoutedDoOnce: [
			self selectionModes do: [ :mode |
					mode requestNewRepresentation.
					self updateModeSelectionFrom: mode ] ].
	self requestLayout
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> hiddenAtPosition: anInteger [

	self hiddenSelecter selectIndex: anInteger
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
	
	mouseMoveReplayRequested := false.
	nodeManager := self defaultNodeManager.
	selectionModeMap := IdentityDictionary new.

	self initializeDataSource.
	self initializeInnerElement.

	self layout: self defaultLayout.

	self addEventHandler: self defaultEventHandler.
	self primarySelectionMode: self defaultPrimarySelectionMode.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self contextMenuSelectionMode: self defaultContextMenuSelectionMode.
	self newUnselectableSelectionMode onInstalledIn: self.
	self newHiddenSelectionMode onInstalledIn: self.
	self newDisabledSelectionMode onInstalledIn: self.

	self matchParent 
]

{ #category : #initialization }
ToAbstractListElement >> initializeDataSource [ 

	self dataSource: self defaultDataSource
]

{ #category : #initialization }
ToAbstractListElement >> initializeInnerElement [

	next := self defaultInnerElement.
	self next elevation: (BlRelativeElevation elevation: 10).
	self addChild: self next
]

{ #category : #'t - list element decorator - infinite accessing' }
ToAbstractListElement >> innerElementDo: aValuable [

	aValuable value: self innerElement
]

{ #category : #testing }
ToAbstractListElement >> isMultipleSelection [

	^ self primarySelectionMode isMultipleSelection
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> isSelectedAtPosition: anInteger [

	^ self selectionModel containsIndex: anInteger
]

{ #category : #accessing }
ToAbstractListElement >> itemCount [

	^ self dataSource itemCount
]

{ #category : #'instance creation' }
ToAbstractListElement >> newDisabledSelectionMode [
	" note that a disabled mode need an event handler to force the building of disabled nodes "

	^ ToListDisabledSelectionMode parentMode: self primarySelectionMode
]

{ #category : #'instance creation' }
ToAbstractListElement >> newHiddenSelectionMode [

	^ ToListHiddenSelectionMode parentMode: self primarySelectionMode
]

{ #category : #skin }
ToAbstractListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #'instance creation' }
ToAbstractListElement >> newSieve [

	^ self sieveClass new
		  onInstalledIn: self;
		  yourself
]

{ #category : #'instance creation' }
ToAbstractListElement >> newUnselectableSelectionMode [


	^ ToListUnselectableSelectionMode parentMode: self primarySelectionMode
]

{ #category : #'t - list element decorator - infinite accessing' }
ToAbstractListElement >> next [

	^ next
]

{ #category : #accessing }
ToAbstractListElement >> nodeManager [ 

	^ nodeManager
]

{ #category : #'selection updating' }
ToAbstractListElement >> notifyClickOnNode: aNode fromEvent: anEvent [

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

	aNode dispatchAuthorisationRequest: req
]

{ #category : #notifications }
ToAbstractListElement >> notifyDataSourceChanged [

	
	self dataSource notifyChanged
]

{ #category : #notifications }
ToAbstractListElement >> notifyDataSourceItemsFiltered: aDataSourceEvent [

	
	self dispatchEvent: aDataSourceEvent
]

{ #category : #'private - commands' }
ToAbstractListElement >> offsetPositionRecordsForFilter: aStartPosition itemCount: anItemCount fromSieve: aSieve [

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
ToAbstractListElement >> onLayoutDone [

	super onLayoutDone.
	self checkMouseMoveReplayRequest 
]

{ #category : #'private - commands' }
ToAbstractListElement >> onSievedWith: aSieve [

	self dataSource onSievedWith: aSieve.
	self requestLayout
]

{ #category : #'t - element with placeholder' }
ToAbstractListElement >> placeholderClass [

	^ ToEmptyPlaceholderLayer
]

{ #category : #layout }
ToAbstractListElement >> postponeAction: aValuable [

	self dataSourceManager postponeAction: aValuable for: self
]

{ #category : #accessing }
ToAbstractListElement >> primarySelectionMode [

	^ self selectionModeWithEventClass: ToListPrimarySelectionChangedEvent 
]

{ #category : #accessing }
ToAbstractListElement >> primarySelectionMode: aSelectionMode [

	self primarySelectionMode ifNotNil: [ :m | m onUninstalledIn: self ].
	aSelectionMode ifNotNil: [ aSelectionMode onInstalledIn: self ].
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

{ #category : #layout }
ToAbstractListElement >> requestLayout: aSourceElement [

	super requestLayout: aSourceElement.
	(aSourceElement = self next or: [ aSourceElement parent = self next ])
		ifTrue: [ self requestMouseMoveReplay ]
]

{ #category : #layout }
ToAbstractListElement >> requestMouseMoveReplay [

	mouseMoveReplayRequested := true
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

	self secondarySelectionMode ifNotNil: [ :m | m onUninstalledIn: self ].
	aSelectionMode ifNotNil: [ aSelectionMode onInstalledIn: self ].
	self dispatchEvent: ToListSecondarySelectionModeChangedEvent new.
	self requestNewSkin.

]

{ #category : #accessing }
ToAbstractListElement >> secondarySelectionModel [

	^ self secondarySelectionMode selectionModel
]

{ #category : #accessing }
ToAbstractListElement >> secondarySelectionOption [

	^ self secondarySelectionMode selectionOption
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> selectableAtPosition: anInteger [

	self unselectableSelecter deselectIndex: anInteger
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> selectedAtPosition: anInteger [

	self selecter selectIndex: anInteger
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> selecter [

	^ self primarySelectionMode selecter
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> selectionElementsDo: aBlock [

	selectionModeMap valuesDo: [ :mode |
		mode selectionOptionDo: [ :opt | opt selectionElements do: [ :se | aBlock value: se ] ] ]
]

{ #category : #accessing }
ToAbstractListElement >> selectionMode [

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

{ #category : #accessing }
ToAbstractListElement >> selectionOption [

	^ self primarySelectionMode selectionOption
]

{ #category : #'instance creation' }
ToAbstractListElement >> sieveClass [

	^ ToListElementSieve
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> unselectableAtPosition: anInteger [

	self unselectableSelecter selectOneMoreIndex: anInteger
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

{ #category : #'selection updating' }
ToAbstractListElement >> updateAllSelections [

	self selectionModes do: [ :mode | self updateModeSelectionFrom: mode ]
]

{ #category : #'selection updating' }
ToAbstractListElement >> updateModeSelectionFrom: aMode [

	aMode selectionOption ifNotNil: [ :option |
		option
			updateSelectionIn: self
			withSelectionModel: aMode selectionModel ]
]

{ #category : #'selection updating' }
ToAbstractListElement >> updatePrimarySelection [

	self updateModeSelectionFrom: self selectionMode
]

{ #category : #'selection updating' }
ToAbstractListElement >> updateSecondarySelection [

	self updateModeSelectionFrom: self secondarySelectionMode
]

{ #category : #'selection updating' }
ToAbstractListElement >> updateSelectionAfter: aValuable [

	self selecter
		updateSelectionAfter: aValuable
		withDataAccessor: self dataAccessor.
	self postponeAction: [ self notifyDataSourceChanged ]
]

{ #category : #'accessing selecters' }
ToAbstractListElement >> visibleAtPosition: anInteger [

	self hiddenSelecter deselectIndex: anInteger
]
