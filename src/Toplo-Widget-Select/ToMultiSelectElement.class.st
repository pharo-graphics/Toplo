Class {
	#name : #ToMultiSelectElement,
	#superclass : #ToElementBarDep,
	#instVars : [
		'filtrable',
		'windowManager',
		'hideSelected',
		'maxSelectedCount',
		'multipleSelection'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'accessing - list' }
ToMultiSelectElement >> addGroup: anObject withData: aCollection [

	| grpIdx |
	self dataAccessor add: anObject.
	grpIdx := self dataAccessor itemCount.
	self setGroupIndex: grpIdx.
	self dataAccessor addAll: aCollection
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> allowSelectedCount: aNumber [

	^ maxSelectedCount isZero or: [ aNumber <= maxSelectedCount ]
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> assertMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> checkHideSelectionFromListElement [

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
ToMultiSelectElement >> checkMaxSelectedCountFromListElement [

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
ToMultiSelectElement >> closeWindow [

	^ self windowManager closeWindow
]

{ #category : #'accessing - window' }
ToMultiSelectElement >> currentWindow [ 

	^ self windowManager currentWindow
]

{ #category : #private }
ToMultiSelectElement >> fakeNode [

	^ self childWithId: #fakeNode ifNone: [  ]
]

{ #category : #accessing }
ToMultiSelectElement >> filterString [ 

	^ self nodeContainer filterString
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> filterStringChanged [

	self pattern: self filterString
]

{ #category : #accessing }
ToMultiSelectElement >> filtrable [

	^ filtrable
]

{ #category : #accessing }
ToMultiSelectElement >> filtrable: aBoolean [

	filtrable := aBoolean.
	aBoolean
		ifTrue: [ self textInputElement beEditable ]
		ifFalse: [ self textInputElement beReadonly ].
]

{ #category : #accessing }
ToMultiSelectElement >> hideSelected [

	^ hideSelected 
]

{ #category : #accessing }
ToMultiSelectElement >> hideSelected: aBoolean [

	hideSelected := aBoolean
]

{ #category : #accessing }
ToMultiSelectElement >> iconContainer [

	^ self endElement
]

{ #category : #accessing }
ToMultiSelectElement >> iconContainer: anIconContainer [

	self iconContainer = anIconContainer ifTrue: [ ^ self ].
	self iconContainer ifNotNil: [
		self iconContainer onUninstalledIn: self ].
	anIconContainer selectionModel: self selectionModel.
	self endElement: anIconContainer.
	anIconContainer onInstalledIn: self
]

{ #category : #initialization }
ToMultiSelectElement >> initialize [

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
ToMultiSelectElement >> inputTextField [ 

	^ self nodeContainer inputTextField
]

{ #category : #accessing }
ToMultiSelectElement >> installNodeContainer [ 

	super installNodeContainer.
	windowManager listElement selectionMode multiple: self isMultipleSelection.
	self requestNewSkin 
]

{ #category : #testing }
ToMultiSelectElement >> isFiltrable [ 

	^ filtrable
]

{ #category : #testing }
ToMultiSelectElement >> isMultipleSelection [

	^ multipleSelection 
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> listDataNodeBuilder: aBuilder [

	self windowManager listDataNodeBuilder: aBuilder
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> listElement [

	^ self windowManager listElement
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> listNodeBuilder: aValuable [

	self listElement nodeBuilder: aValuable
]

{ #category : #accessing }
ToMultiSelectElement >> maxSelectedCount [

	^ maxSelectedCount
]

{ #category : #accessing }
ToMultiSelectElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber.
	self iconContainer maxSelectedCount: aNumber
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> multipleSelection: aBoolean [

	multipleSelection := aBoolean.
	self installNodeContainerAndRefresh
]

{ #category : #initialization }
ToMultiSelectElement >> multipleSelectionByDefault [ 

	^ false
]

{ #category : #'instance creation' }
ToMultiSelectElement >> newIconContainer [

	^ ToMultiSelectIconContainer new forFiltering: self isFiltrable 
]

{ #category : #skin }
ToMultiSelectElement >> newRawSkin [ 

	^ ToSelectElementSkin new
]

{ #category : #'instance creation' }
ToMultiSelectElement >> newShortcutsStore [ 

	^ ToSelectShortcutsStore new
]

{ #category : #'instance creation' }
ToMultiSelectElement >> newWindowManager [

	| wm |
	wm := ToSelectListWindowManager new.
	wm onInstalledIn: self.
	^ wm
]

{ #category : #accessing }
ToMultiSelectElement >> nodeBuilder: aValuable [

	self nodeContainer nodeBuilder: aValuable
]

{ #category : #'instance creation' }
ToMultiSelectElement >> nodeContainerClass [

	^ self isMultipleSelection
		  ifTrue: [ ToMultipleSelectContainerElement ]
		  ifFalse: [ ToSingleSelectContainerElement ]
]

{ #category : #'accessing - selection' }
ToMultiSelectElement >> onSelectionChanged [

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
ToMultiSelectElement >> onSelectionChangedInListElement [

	self showHidePlaceholder.
	self nodeContainer refresh.

	self checkHideSelectionFromListElement.
	self checkMaxSelectedCountFromListElement.

	self listElement notifyPrimarySelectionDirty.
	self nodeContainer requestLayout
]

{ #category : #window }
ToMultiSelectElement >> onWindowClosed [

	self nodeContainer onWindowClosed
]

{ #category : #window }
ToMultiSelectElement >> onWindowOpened [

	self nodeContainer onWindowOpened
]

{ #category : #accessing }
ToMultiSelectElement >> pattern [

	^ self sieve pattern
]

{ #category : #accessing }
ToMultiSelectElement >> pattern: aPattern [

	self sieve pattern: aPattern
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> popupMaxHeight: aNumber [

	self windowManager maxHeight: aNumber
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> popupMinHeight: aNumber [

	self windowManager minHeight: aNumber
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> popupPositionHook: aValuable [

	self windowManager positionHook: aValuable
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> popupSizeHook: aValuable [

	self windowManager sizeHook: aValuable
]

{ #category : #'accessing - window' }
ToMultiSelectElement >> popupWindowEvent: anEvent [ 

	^ self windowManager popupWindowEvent: anEvent 
]

{ #category : #accessing }
ToMultiSelectElement >> selectionModel: aSelectionModel [

	self iconContainer selectionModel: self selectionModel
]

{ #category : #'accessing - list' }
ToMultiSelectElement >> setGroupIndex: anIndex [

	self listElement groupSelecter selectIndex: anIndex.
	self listElement unselectableSelecter selectIndex: anIndex
]

{ #category : #private }
ToMultiSelectElement >> showHidePlaceholder [

	self selectionModel ifEmpty: [
		self inputTextField text ifEmpty: [
			^ self showPlaceholder ] ].
	self hidePlaceholder
]

{ #category : #accessing }
ToMultiSelectElement >> sieve [

	^ windowManager sieve
]

{ #category : #initialization }
ToMultiSelectElement >> singleByDefault [

	^ self multipleSelectionByDefault not
]

{ #category : #accessing }
ToMultiSelectElement >> textInputElement [ 

	^ self nodeContainer textInputElement
]

{ #category : #private }
ToMultiSelectElement >> updateSelectedCountLabel [

	self iconContainer updateSelectedCountLabel
]

{ #category : #accessing }
ToMultiSelectElement >> windowManager [

	^ windowManager
]

{ #category : #accessing }
ToMultiSelectElement >> windowManager: aSelectWindowManager [

	windowManager := aSelectWindowManager 
]
