Class {
	#name : #ToAbstractListElement,
	#superclass : #ToElement,
	#traits : 'TToListElementDecorator + TToElementWithPlaceholder + TToOrientable',
	#classTraits : 'TToListElementDecorator classTrait + TToElementWithPlaceholder classTrait + TToOrientable classTrait',
	#instVars : [
		'next',
		'dataSource',
		'nodeManager',
		'selectionModeMap',
		'commandApplicationStrategy'
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

{ #category : #configuration }
ToAbstractListElement >> applyWidgetConfiguration [

	super applyWidgetConfiguration.
	self innerElement applyWidgetConfiguration
]

{ #category : #accessing }
ToAbstractListElement >> commandApplicationStrategy [

	^ commandApplicationStrategy
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
ToAbstractListElement >> defaultContextMenuManagerClass [

	^ ToListElementContextMenuManager
]

{ #category : #initialization }
ToAbstractListElement >> defaultContextMenuSelectionMode [

	^ ToListContextMenuSelectionMode new
]

{ #category : #initialization }
ToAbstractListElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToAbstractListElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToAbstractListElement >> defaultInnerElement [ 

	^ self subclassResponsibility 
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

	self disabledSelecter selectIndex: anInteger
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
ToAbstractListElement >> fakeNode [

	^ nil
]

{ #category : #'t - item' }
ToAbstractListElement >> flagAsDisabled: aBoolean [

	aBoolean ifTrue: [
		self selecter deselectAll.
		self secondarySelecter deselectAll ].
	super flagAsDisabled: aBoolean
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

	commandApplicationStrategy := self newCommandApplicationStrategy element: self.
	nodeManager := self defaultNodeManager.
	selectionModeMap := IdentityDictionary new.

	self initializeDataSource.
	self initializeInnerElement.

	self layout: self defaultLayout.

	self addEventHandler: self defaultEventHandler.
	self primarySelectionMode: self defaultPrimarySelectionMode.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self contextMenuSelectionMode: self defaultContextMenuSelectionMode.
	self contextMenuManagerClass: self defaultContextMenuManagerClass.
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

{ #category : #'t - menu item' }
ToAbstractListElement >> itemContaining: anElement [

	self = anElement ifTrue: [ ^ self ].
	self nodes do: [ :n |
		  (n itemContaining: anElement) ifNotNil: [ :found | ^ found ] ].
	^ nil
]

{ #category : #accessing }
ToAbstractListElement >> itemCount [

	^ self dataSource itemCount
]

{ #category : #'instance creation' }
ToAbstractListElement >> newCommandApplicationStrategy [

	^ ToDataSourceCommandApplicationStrategy new
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

{ #category : #'private - commands' }
ToAbstractListElement >> onSievedWith: aSieve [

	self dataAccessor onSievedWith: aSieve.
	self requestLayout
]

{ #category : #'t - element with placeholder' }
ToAbstractListElement >> placeholderClass [

	^ ToEmptyPlaceholderLayer
]

{ #category : #'t - element with placeholder' }
ToAbstractListElement >> placeholderElevation [

	^ self innerElement elevation
]

{ #category : #layout }
ToAbstractListElement >> posponeAction: aValuable [

	self innerElement requestLayout.
	self dataSourceManager posponeAction: aValuable
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

{ #category : #'selection updating' }
ToAbstractListElement >> refreshAllSelections [

	self whenLayoutedDoOnce: [ self updateAllSelections ].
	self requestLayout
]

{ #category : #'selection updating' }
ToAbstractListElement >> refreshPrimarySelection [

	self updateModeSelectionFrom: self selectionMode
]

{ #category : #'selection updating' }
ToAbstractListElement >> refreshSecondarySelection [

	self updateModeSelectionFrom: self secondarySelectionMode
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

{ #category : #'accessing selecters' }
ToAbstractListElement >> unselectableAtPosition: anInteger [

	self unselectableSelecter selectIndex: anInteger
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

{ #category : #'accessing selecters' }
ToAbstractListElement >> visibleAtPosition: anInteger [

	self hiddenSelecter deselectIndex: anInteger
]
