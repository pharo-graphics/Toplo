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
		'innerElementClass',
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

	dataAccessor ifNil: [ self dataAccessor: self defaultDataAccessor ].
	^ dataAccessor 
]

{ #category : #accessing }
ToBasicListElement >> dataAccessor: aDataAccessor [

	dataAccessor ifNotNil: [ BlImmutableObjectChangeError signal ].
	dataAccessor := aDataAccessor.
	dataAccessor onInstalledInListElement: self.
]

{ #category : #accessing }
ToBasicListElement >> dataSource [

	dataSource ifNil: [ self dataSource: self defaultDataSource ].
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
ToBasicListElement >> defaultDataAccessor [

	^ ToBasicListDataAccessor new
]

{ #category : #initialization }
ToBasicListElement >> defaultDataSource [

	^ ToListSortableCollectionDataSource new
]

{ #category : #initialization }
ToBasicListElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToBasicListElement >> defaultInnerElementClass [

	^ ToInfiniteElement
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

{ #category : #'accessing selecters' }
ToBasicListElement >> deselectedAtPosition: anInteger [

	self selecter deselectIndex: anInteger
]

{ #category : #'accessing - selection modes' }
ToBasicListElement >> dirtySelectionModes [

	^ self selectionModes select: [ :m | m dirty ]
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

{ #category : #'t - item' }
ToBasicListElement >> flagAsDisabled: aBoolean [

	aBoolean ifTrue: [
			self selecter deselectAll.
			self secondarySelecter deselectAll ].
	super flagAsDisabled: aBoolean
]

{ #category : #'selection updating' }
ToBasicListElement >> forceUpdateAllSelectionsNow [

	self selectionModes do: [ :mode |
			mode forceUpdateSelectionIn: self ]
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
	
	self layout: self defaultLayout.

	self addEventHandler: self defaultEventHandler.
	self primarySelectionMode: self defaultPrimarySelectionMode.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self contextMenuSelectionMode: self defaultContextMenuSelectionMode.
	self newUnselectableSelectionMode onInstalledIn: self.
	self newHiddenSelectionMode onInstalledIn: self.
	self newDisabledSelectionMode onInstalledIn: self.

	self matchParent.
	" get the innerElement to build it and allow selection 
	of items to be done *** before *** it is added in a space"
	self innerElement
]

{ #category : #initialization }
ToBasicListElement >> initializeInnerElement [

	self innerElement: self newInnerElement
]

{ #category : #'t - list element decorator - infinite accessing' }
ToBasicListElement >> innerElement [

	innerElement ifNil: [ self initializeInnerElement ].
	^ innerElement innerElement
]

{ #category : #accessing }
ToBasicListElement >> innerElement: anInnerElement [

	innerElement = anInnerElement ifTrue: [ ^ self ].
	innerElement ifNotNil: [ :inner | 
		inner removeFromParent ].
	innerElement := anInnerElement.
	innerElement ifNotNil: [ :inner |
			self addChild: innerElement.
			self notifyDataSourceChanged ].
	self onInnerElementChanged
]

{ #category : #accessing }
ToBasicListElement >> innerElementClass [

	^ innerElementClass ifNil: [
		  innerElementClass := self defaultInnerElementClass ]
]

{ #category : #accessing }
ToBasicListElement >> innerElementClass: anInnerElementClass [

	innerElementClass = anInnerElementClass ifTrue: [ ^ self ].
	innerElementClass := anInnerElementClass.
	innerElement ifNotNil: [
			innerElement removeFromParent.
			innerElement := nil.
			self requestConfiguration.
			self requestLayout ]
]

{ #category : #'fake container' }
ToBasicListElement >> isFakeNodeContainer: aNodeContainer [ 

	^ false
]

{ #category : #testing }
ToBasicListElement >> isMultipleSelection [

	^ self primarySelectionMode isMultipleSelection
]

{ #category : #testing }
ToBasicListElement >> isOrientable [

	^ self innerElement isOrientable
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

{ #category : #'instance creation' }
ToBasicListElement >> newHiddenSelectionMode [

	^ ToListHiddenSelectionMode parentMode: self primarySelectionMode
]

{ #category : #'instance creation' }
ToBasicListElement >> newInnerElement [

	^ self innerElementClass onListElement: self
]

{ #category : #skin }
ToBasicListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #configuration }
ToBasicListElement >> newToConfiguration [ 

	^ ToListConfiguration new
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

{ #category : #'private - commands' }
ToBasicListElement >> onAppliedDataSourceFilterCommand: aDataSourceCommand [
]

{ #category : #'private - commands' }
ToBasicListElement >> onAppliedDataSourceSieveCommand: aDataSourceCommand [
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

{ #category : #accessing }
ToBasicListElement >> onInnerElementChanged [
]

{ #category : #'hooks - layout' }
ToBasicListElement >> onLayoutDone [

	super onLayoutDone.
	self selectionModes do: [ :mode | mode checkSelectionIn: self ].
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

{ #category : #'selection updating' }
ToBasicListElement >> requestUpdateAllSelections [

	self selectionModes do: [ :mode | self requestUpdateSelectionMode: mode ]
]

{ #category : #'selection updating' }
ToBasicListElement >> requestUpdatePrimarySelection [

	self requestUpdateSelectionMode: self selectionMode
]

{ #category : #'selection updating' }
ToBasicListElement >> requestUpdateSecondarySelection [

	self requestUpdateSelectionMode: self secondarySelectionMode
]

{ #category : #'selection updating' }
ToBasicListElement >> requestUpdateSelectionMode: aMode [

	aMode dirty: true.
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

	^ self innerElementClass = ToInfiniteElement 
]

{ #category : #accessing }
ToBasicListElement >> useInfiniteLayout: aBoolean [

	| requiredClass |
	requiredClass := aBoolean
		                 ifTrue: [ ToInfiniteElement ]
		                 ifFalse: [ ToScrollableFiniteListElement ].
	innerElementClass = requiredClass ifTrue: [ ^ self ].
	self innerElementClass: requiredClass
]

{ #category : #'accessing selecters' }
ToBasicListElement >> visibleAtPosition: anInteger [

	self hiddenSelecter deselectIndex: anInteger
]
