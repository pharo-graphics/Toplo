Class {
	#name : #ToSelectElementBar,
	#superclass : #ToElementBar,
	#instVars : [
		'filtrable',
		'windowManager',
		'hideSelected',
		'maxSelectedCount'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing - list' }
ToSelectElementBar >> addGroup: anObject withData: aCollection [

	| grpIdx |
	self dataAccessor add: anObject.
	grpIdx := self dataAccessor itemCount.
	self setGroupIndex: grpIdx.
	self dataAccessor addAll: aCollection
]

{ #category : #'accessing - selection' }
ToSelectElementBar >> allowSelectedCount: aNumber [

	^ maxSelectedCount isZero or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToSelectElementBar >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToSelectElementBar >> checkHideSelectionFromListElement [

	hideSelected ifFalse: [ ^ self ].
	self listElement dataAccessor withIndexDo: [ :d :localIndex |
		| originalIndex |
		originalIndex := self sieve dataPositionIndex at: d.
		(self listElement selectionModel containsIndex: localIndex)
			ifTrue: [ self listElement selectionModel hideIndex: localIndex ]
			ifFalse: [ self listElement selectionModel unhideIndex: localIndex ].
		self listElement selectionModel
			transferSelectionFromIndex: localIndex
			toIndex: originalIndex
			in: self selectionModel ].
	self listElement dataSource notifyChanged.
]

{ #category : #'accessing - selection' }
ToSelectElementBar >> checkMaxSelectedCountFromListElement [

	| unselectableSM groupeSM |
	maxSelectedCount isZero ifTrue: [ ^ self ].
	
	unselectableSM := self listElement unselectableSelectionModel.
	groupeSM := self listElement groupSelectionModel.

	self updateSelectedCountLabel.

	self assertMaxSelectedCount: self selectionModel selectedIndexesCount.
	self listElement dataAccessor withIndexDo: [ :d :localIndex |
		| originalIndex |
		originalIndex := self sieve dataPositionIndex at: d.
		(groupeSM containsIndex: localIndex) ifFalse: [
			self selectionModel selectedIndexesCount < maxSelectedCount
				ifTrue: [ unselectableSM deselectIndex: localIndex ]
				ifFalse: [
					(self selectionModel containsIndex: originalIndex) ifFalse: [
						unselectableSM selectIndex: localIndex ] ] ].

		self listElement selectionModel
			transferSelectionFromIndex: localIndex
			toIndex: originalIndex
			in: self selectionModel ].
		
	self listElement dataSource notifyChanged
]

{ #category : #'accessing - window' }
ToSelectElementBar >> closeWindow [

	^ self windowManager closeWindow
]

{ #category : #'accessing - window' }
ToSelectElementBar >> currentWindow [ 

	^ self windowManager currentWindow
]

{ #category : #accessing }
ToSelectElementBar >> dataAccessor: aDataAccessor [

	super dataAccessor: aDataAccessor.
	aDataAccessor addEventHandler:
		(ToObservableCollectionMirrorUpdater new mirror:
			 windowManager listElement dataAccessor)
]

{ #category : #private }
ToSelectElementBar >> fakeNode [

	^ self childWithId: #fakeNode ifNone: [  ]
]

{ #category : #accessing }
ToSelectElementBar >> filterString [ 

	^ self nodeContainer filterString
]

{ #category : #'accessing - selection' }
ToSelectElementBar >> filterStringChanged [

	self pattern: self filterString
]

{ #category : #accessing }
ToSelectElementBar >> filtrable [

	^ filtrable
]

{ #category : #accessing }
ToSelectElementBar >> filtrable: aBoolean [

	filtrable := aBoolean.
	aBoolean
		ifTrue: [ self textInputElement beEditable ]
		ifFalse: [ self textInputElement beReadonly ].
]

{ #category : #accessing }
ToSelectElementBar >> hideSelected [

	^ hideSelected 
]

{ #category : #accessing }
ToSelectElementBar >> hideSelected: aBoolean [

	hideSelected := aBoolean
]

{ #category : #accessing }
ToSelectElementBar >> iconContainer [

	^ triplet endElement
]

{ #category : #accessing }
ToSelectElementBar >> iconContainer: anIconContainer [

	self iconContainer = anIconContainer ifTrue: [ ^ self ].
	self iconContainer ifNotNil: [
		self iconContainer onUninstalledIn: self ].
	self endElement: anIconContainer.
	anIconContainer onInstalledIn: self
]

{ #category : #initialization }
ToSelectElementBar >> initialize [

	| sharedEventsDistributor |
	super initialize.
	self id: #selectElement.
	filtrable := true.
	nodeWrapping := true.
	hideSelected := false.
	maxSelectedCount := 0.

	" for the popup "
	windowManager := self newWindowManager.

	self iconContainer: self newIconContainer.
	self selectionModel: self sieve selectionModel.
	self dataAccessor: ToObservableCollection new.

	self multipleSelection: false.

	self layout: BlLinearLayout horizontal.
	self fitContent.

	sharedEventsDistributor := BlSharedEventDistributor new.
	sharedEventsDistributor
		adjustMousePosition: false;
		shareEvents: { ToCollectionFilteredEvent }.

	self addEventHandler: sharedEventsDistributor.
	self listElement addEventHandler: sharedEventsDistributor
]

{ #category : #accessing }
ToSelectElementBar >> inputTextField [ 

	^ self nodeContainer inputTextField
]

{ #category : #testing }
ToSelectElementBar >> isFiltrable [ 

	^ filtrable
]

{ #category : #'accessing - list' }
ToSelectElementBar >> listDataNodeBuilder: aBuilder [

	self windowManager listDataNodeBuilder: aBuilder
]

{ #category : #'accessing - list' }
ToSelectElementBar >> listElement [

	^ self windowManager listElement
]

{ #category : #'accessing - list' }
ToSelectElementBar >> listNodeBuilder: aValuable [

	self listElement nodeBuilder: aValuable
]

{ #category : #accessing }
ToSelectElementBar >> maxSelectedCount [

	^ maxSelectedCount
]

{ #category : #accessing }
ToSelectElementBar >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber.
	self iconContainer maxSelectedCount: aNumber
]

{ #category : #accessing }
ToSelectElementBar >> multipleSelection: aBoolean [

	super multipleSelection: aBoolean.
	windowManager listElement selectionMode multiple: aBoolean.
	self requestNewSkin 
]

{ #category : #'instance creation' }
ToSelectElementBar >> newIconContainer [

	^ ToSelectIconContainer new forFiltering: self isFiltrable 
]

{ #category : #'instance creation' }
ToSelectElementBar >> newMultipleSelectionNodeContainer [

	^  ToMultipleSelectNodeContainerElement new
]

{ #category : #skin }
ToSelectElementBar >> newRawSkin [ 

	^ ToSelectElementSkin new
]

{ #category : #'instance creation' }
ToSelectElementBar >> newShortcutsStore [ 

	^ ToSelectShortcutsStore new
]

{ #category : #'instance creation' }
ToSelectElementBar >> newSingleSelectionNodeContainer [

	^  ToSingleSelectNodeContainerElement new

]

{ #category : #'instance creation' }
ToSelectElementBar >> newWindowManager [

	| wm |
	wm := ToSelectListWindowManager new.
	wm onInstalledIn: self.
	^ wm
]

{ #category : #accessing }
ToSelectElementBar >> nodeBuilder: aValuable [

	self nodeContainer nodeBuilder: aValuable
]

{ #category : #'accessing - selection' }
ToSelectElementBar >> onSelectionChanged [

	| toRemove listData |
	super onSelectionChanged.
	listData := self listElement dataAccessor.
	toRemove := Array streamContents: [ :stream |
		            listData withIndexDo: [ :d :localIndex |
			            | originalIndex |
			            originalIndex := self sieve dataPositionIndex at: d.
			            (self selectionModel containsIndex: originalIndex)
				            ifFalse: [ stream nextPut: localIndex ] ] ].

	self listElement selectionModel deselectIndexes: toRemove.
	self onSelectionChangedInListElement
]

{ #category : #'accessing - selection' }
ToSelectElementBar >> onSelectionChangedInListElement [

	self showHidePlaceholder.
	self nodeContainer refresh.

	self checkHideSelectionFromListElement.
	self checkMaxSelectedCountFromListElement.

	self listElement notifyPrimarySelectionDirty.
	self nodeContainer requestLayout
]

{ #category : #window }
ToSelectElementBar >> onWindowClosed [

	self nodeContainer onWindowClosed
]

{ #category : #window }
ToSelectElementBar >> onWindowOpened [

	self nodeContainer onWindowOpened
]

{ #category : #accessing }
ToSelectElementBar >> pattern [

	^ self sieve pattern
]

{ #category : #accessing }
ToSelectElementBar >> pattern: aPattern [

	self sieve pattern: aPattern
]

{ #category : #'accessing - list' }
ToSelectElementBar >> popupMaxHeight: aNumber [

	self windowManager maxHeight: aNumber
]

{ #category : #'accessing - list' }
ToSelectElementBar >> popupMinHeight: aNumber [

	self windowManager minHeight: aNumber
]

{ #category : #'accessing - list' }
ToSelectElementBar >> popupPositionHook: aValuable [

	self windowManager positionHook: aValuable
]

{ #category : #'accessing - list' }
ToSelectElementBar >> popupSizeHook: aValuable [

	self windowManager sizeHook: aValuable
]

{ #category : #'accessing - window' }
ToSelectElementBar >> popupWindowEvent: anEvent [ 

	^ self windowManager popupWindowEvent: anEvent 
]

{ #category : #'accessing - selection' }
ToSelectElementBar >> selecter [

	^ self listElement selecter
]

{ #category : #accessing }
ToSelectElementBar >> selectionModel: aSelectionModel [

	super selectionModel: aSelectionModel.
	self iconContainer selectionModel: aSelectionModel
]

{ #category : #'accessing - list' }
ToSelectElementBar >> setGroupIndex: anIndex [

	self listElement groupSelecter selectIndex: anIndex.
	self listElement unselectableSelecter selectIndex: anIndex
]

{ #category : #private }
ToSelectElementBar >> showHidePlaceholder [

	self selectionModel ifEmpty: [
		self inputTextField text ifEmpty: [
			^ self showPlaceholder ] ].
	^ super showHidePlaceholder
]

{ #category : #accessing }
ToSelectElementBar >> sieve [

	^ windowManager sieve
]

{ #category : #accessing }
ToSelectElementBar >> textInputElement [ 

	^ self nodeContainer textInputElement
]

{ #category : #private }
ToSelectElementBar >> updateSelectedCountLabel [

	self iconContainer updateSelectedCountLabel
]

{ #category : #accessing }
ToSelectElementBar >> windowManager [

	^ windowManager
]

{ #category : #accessing }
ToSelectElementBar >> windowManager: aSelectWindowManager [

	windowManager := aSelectWindowManager 
]
