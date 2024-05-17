Class {
	#name : #ToSelectElement,
	#superclass : #ToElementBar,
	#instVars : [
		'filtrable',
		'windowManager',
		'hideSelected',
		'maxSelectedCount',
		'multipleSelection'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing - list' }
ToSelectElement >> addGroup: anObject withData: aCollection [

	| grpIdx |
	self dataAccessor add: anObject.
	grpIdx := self dataAccessor itemCount.
	self setGroupIndex: grpIdx.
	self dataAccessor addAll: aCollection
]

{ #category : #'accessing - selection' }
ToSelectElement >> allowSelectedCount: aNumber [

	^ maxSelectedCount isZero or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToSelectElement >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToSelectElement >> checkHideSelectionFromListElement [

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
ToSelectElement >> checkMaxSelectedCountFromListElement [

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
ToSelectElement >> closeWindow [

	^ self windowManager closeWindow
]

{ #category : #'accessing - window' }
ToSelectElement >> currentWindow [ 

	^ self windowManager currentWindow
]

{ #category : #private }
ToSelectElement >> fakeNode [

	^ self childWithId: #fakeNode ifNone: [  ]
]

{ #category : #accessing }
ToSelectElement >> filterString [ 

	^ self nodeContainer filterString
]

{ #category : #'accessing - selection' }
ToSelectElement >> filterStringChanged [

	self pattern: self filterString
]

{ #category : #accessing }
ToSelectElement >> filtrable [

	^ filtrable
]

{ #category : #accessing }
ToSelectElement >> filtrable: aBoolean [

	filtrable := aBoolean.
	aBoolean
		ifTrue: [ self textInputElement beEditable ]
		ifFalse: [ self textInputElement beReadonly ].
]

{ #category : #accessing }
ToSelectElement >> hideSelected [

	^ hideSelected 
]

{ #category : #accessing }
ToSelectElement >> hideSelected: aBoolean [

	hideSelected := aBoolean
]

{ #category : #accessing }
ToSelectElement >> iconContainer [

	^ self endElement
]

{ #category : #accessing }
ToSelectElement >> iconContainer: anIconContainer [

	self iconContainer = anIconContainer ifTrue: [ ^ self ].
	self iconContainer ifNotNil: [
		self iconContainer onUninstalledIn: self ].
	anIconContainer selectionModel: self selectionModel.
	self endElement: anIconContainer.
	anIconContainer onInstalledIn: self
]

{ #category : #initialization }
ToSelectElement >> initialize [

	| sharedEventsDistributor |
	super initialize.
	self id: #selectElement.
	filtrable := true.
	hideSelected := false.
	maxSelectedCount := 0.
	
	" for the popup "
	windowManager := self newWindowManager.
	self iconContainer: self newIconContainer.

	self multipleSelection: self multipleSelectionByDefault.
	sharedEventsDistributor := BlSharedEventDistributor new.
	sharedEventsDistributor
		adjustMousePosition: false;
		shareEvents: { ToCollectionFilteredEvent }.

	self addEventHandler: sharedEventsDistributor.
	self listElement addEventHandler: sharedEventsDistributor
]

{ #category : #accessing }
ToSelectElement >> inputTextField [ 

	^ self nodeContainer inputTextField
]

{ #category : #accessing }
ToSelectElement >> installNodeContainer [ 

	super installNodeContainer.
	windowManager listElement selectionMode multiple: self isMultipleSelection.
	self requestNewSkin 
]

{ #category : #testing }
ToSelectElement >> isFiltrable [ 

	^ filtrable
]

{ #category : #testing }
ToSelectElement >> isMultipleSelection [

	^ multipleSelection 
]

{ #category : #'accessing - list' }
ToSelectElement >> listDataNodeBuilder: aBuilder [

	self windowManager listDataNodeBuilder: aBuilder
]

{ #category : #'accessing - list' }
ToSelectElement >> listElement [

	^ self windowManager listElement
]

{ #category : #'accessing - list' }
ToSelectElement >> listNodeBuilder: aValuable [

	self listElement nodeBuilder: aValuable
]

{ #category : #accessing }
ToSelectElement >> maxSelectedCount [

	^ maxSelectedCount
]

{ #category : #accessing }
ToSelectElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber.
	self iconContainer maxSelectedCount: aNumber
]

{ #category : #'accessing - selection' }
ToSelectElement >> multipleSelection: aBoolean [

	multipleSelection := aBoolean.
	self installNodeContainerAndRefresh
]

{ #category : #initialization }
ToSelectElement >> multipleSelectionByDefault [ 

	^ false
]

{ #category : #'instance creation' }
ToSelectElement >> newIconContainer [

	^ ToSelectIconContainer new forFiltering: self isFiltrable 
]

{ #category : #skin }
ToSelectElement >> newRawSkin [ 

	^ ToSelectElementSkin new
]

{ #category : #'instance creation' }
ToSelectElement >> newShortcutsStore [ 

	^ ToSelectShortcutsStore new
]

{ #category : #'instance creation' }
ToSelectElement >> newWindowManager [

	| wm |
	wm := ToSelectListWindowManager new.
	wm onInstalledIn: self.
	^ wm
]

{ #category : #accessing }
ToSelectElement >> nodeBuilder: aValuable [

	self nodeContainer nodeBuilder: aValuable
]

{ #category : #'instance creation' }
ToSelectElement >> nodeContainerClass [

	^ self isMultipleSelection
		  ifTrue: [ ToMultipleSelectContainerElement ]
		  ifFalse: [ ToSingleSelectContainerElement ]
]

{ #category : #'accessing - selection' }
ToSelectElement >> onSelectionChanged [

	| listData |
	listData := self listElement dataAccessor.
	" update list according to my selection model"
	listData withIndexDo: [ :d :localIndex |
		| originalIndex |
		originalIndex := self sieve dataPositionIndex at: d.
		self selectionModel
			transferSelectionFromIndex: originalIndex
			toIndex: localIndex
			in: self listElement selectionModel ].
	self refresh.
	self listElement notifyPrimarySelectionDirty
]

{ #category : #'accessing - selection' }
ToSelectElement >> onSelectionChangedInListElement [

	self showHidePlaceholder.
	self nodeContainer refresh.

	self checkHideSelectionFromListElement.
	self checkMaxSelectedCountFromListElement.

	self listElement notifyPrimarySelectionDirty.
	self nodeContainer requestLayout
]

{ #category : #window }
ToSelectElement >> onWindowClosed [

	self nodeContainer onWindowClosed
]

{ #category : #window }
ToSelectElement >> onWindowOpened [

	self nodeContainer onWindowOpened
]

{ #category : #accessing }
ToSelectElement >> pattern [

	^ self sieve pattern
]

{ #category : #accessing }
ToSelectElement >> pattern: aPattern [

	self sieve pattern: aPattern
]

{ #category : #'accessing - list' }
ToSelectElement >> popupMaxHeight: aNumber [

	self windowManager maxHeight: aNumber
]

{ #category : #'accessing - list' }
ToSelectElement >> popupMinHeight: aNumber [

	self windowManager minHeight: aNumber
]

{ #category : #'accessing - list' }
ToSelectElement >> popupPositionHook: aValuable [

	self windowManager positionHook: aValuable
]

{ #category : #'accessing - list' }
ToSelectElement >> popupSizeHook: aValuable [

	self windowManager sizeHook: aValuable
]

{ #category : #'accessing - window' }
ToSelectElement >> popupWindowEvent: anEvent [ 

	^ self windowManager popupWindowEvent: anEvent 
]

{ #category : #accessing }
ToSelectElement >> selectionModel: aSelectionModel [

	self iconContainer selectionModel: self selectionModel
]

{ #category : #'accessing - list' }
ToSelectElement >> setGroupIndex: anIndex [

	self listElement groupSelecter selectIndex: anIndex.
	self listElement unselectableSelecter selectIndex: anIndex
]

{ #category : #private }
ToSelectElement >> showHidePlaceholder [

	self selectionModel ifEmpty: [
		self inputTextField text ifEmpty: [
			^ self showPlaceholder ] ].
	self hidePlaceholder
]

{ #category : #accessing }
ToSelectElement >> sieve [

	^ windowManager sieve
]

{ #category : #initialization }
ToSelectElement >> singleByDefault [

	^ self multipleSelectionByDefault not
]

{ #category : #accessing }
ToSelectElement >> textInputElement [ 

	^ self nodeContainer textInputElement
]

{ #category : #private }
ToSelectElement >> updateSelectedCountLabel [

	self iconContainer updateSelectedCountLabel
]

{ #category : #accessing }
ToSelectElement >> windowManager [

	^ windowManager
]

{ #category : #accessing }
ToSelectElement >> windowManager: aSelectWindowManager [

	windowManager := aSelectWindowManager 
]
