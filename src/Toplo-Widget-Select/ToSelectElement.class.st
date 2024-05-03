Class {
	#name : #ToSelectElement,
	#superclass : #ToElement,
	#traits : 'TToElementWithTripletElement',
	#classTraits : 'TToElementWithTripletElement classTrait',
	#instVars : [
		'triplet'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
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

{ #category : #accessing }
ToSelectElement >> dataAccessor [ 

	^ self elementBar dataAccessor
]

{ #category : #accessing }
ToSelectElement >> dataAccessor: aDataAccessor [

	self elementBar dataAccessor: aDataAccessor.
	aDataAccessor addEventHandler:
		(ToObservableCollectionMirrorUpdater new mirror:
			 windowManager listElement dataAccessor).

]

{ #category : #'accessing - selection' }
ToSelectElement >> deselectAll [

	self elementBar deselectAll
]

{ #category : #'accessing - selection' }
ToSelectElement >> deselectIndex: anIndex [

	self elementBar deselectIndex: anIndex
]

{ #category : #'accessing - selection' }
ToSelectElement >> deselectIndexes: anArray [

	self elementBar deselectIndexes: anArray
]

{ #category : #accessing }
ToSelectElement >> elementBar [

	^ triplet middleElement
]

{ #category : #accessing }
ToSelectElement >> fakeDataItem: aDataItem [

	self elementBar fakeDataItem: aDataItem
]

{ #category : #'accessing - selection' }
ToSelectElement >> filterStringChanged [

	self pattern: self elementBar filterString
]

{ #category : #accessing }
ToSelectElement >> filtrable [

	^ self elementBar filtrable 
]

{ #category : #accessing }
ToSelectElement >> filtrable: aBoolean [

	self elementBar filtrable: aBoolean.
	self iconContainer forFiltering: aBoolean.
	self requestNewSkin
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

	^ triplet endElement
]

{ #category : #accessing }
ToSelectElement >> iconContainer: anIconContainer [

	self iconContainer = anIconContainer ifTrue: [ ^ self ].
	self iconContainer ifNotNil: [
		self iconContainer onUninstalledIn: self ].
	self endElement: anIconContainer.
	anIconContainer onInstalledIn: self
]

{ #category : #initialization }
ToSelectElement >> initialize [

	| sharedEventsDistributor |
	super initialize.
	triplet := ToTripletElement new.
	triplet
		hMatchParent;
		vFitContent.
	self middleContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	self addChild: triplet.

	hideSelected := false.
	maxSelectedCount := 0.

	" for the popup "
	windowManager := self newWindowManager.

	self middleElement: self newElementBar.
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

{ #category : #testing }
ToSelectElement >> isFiltrable [

	^ self filtrable
]

{ #category : #testing }
ToSelectElement >> isMultipleSelection [ 

	^ self elementBar isMultipleSelection 
]

{ #category : #testing }
ToSelectElement >> isSingleSelection [ 

	^ self isMultipleSelection not
]

{ #category : #'accessing - list' }
ToSelectElement >> listGroupNodeBuilder: aBuilder [

	self windowManager listGroupNodeBuilder: aBuilder
]

{ #category : #accessing }
ToSelectElement >> multipleSelection: aBoolean [

	self elementBar multipleSelection: aBoolean.
	self requestNewSkin
]

{ #category : #'instance creation' }
ToSelectElement >> newElementBar [

	^ ToSelectElementBar new
		  windowManager: windowManager;
		  vFitContent;
		  hMatchParent;
		  yourself
]

{ #category : #accessing }
ToSelectElement >> nodeContainer [

	^ self elementBar nodeContainer
]

{ #category : #'accessing - selection' }
ToSelectElement >> notifySelectionChanged [

	self elementBar notifySelectionChanged
]

{ #category : #window }
ToSelectElement >> onWindowClosed [

	self elementBar onWindowClosed
]

{ #category : #window }
ToSelectElement >> onWindowOpened [

	self elementBar onWindowOpened
]

{ #category : #accessing }
ToSelectElement >> pattern [

	^ self sieve pattern
]

{ #category : #'accessing - selection' }
ToSelectElement >> selectIndex: anIndex [

	| selectedAfter |
	selectedAfter := Array streamContents: [ :stream |
		                 stream nextPut: anIndex.
		                 stream nextPutAll: self selectedIndexes ].
	self assertMaxSelectedCount: selectedAfter asSet size.
	self elementBar selectIndex: anIndex
]

{ #category : #'accessing - selection' }
ToSelectElement >> selectIndexes: aCollection [

	| selectedAfter |
	selectedAfter := Array streamContents: [ :stream |
		                 stream nextPutAll: aCollection.
		                 stream nextPutAll: self selectedIndexes ].
	self elementBar selectIndexes: aCollection
]

{ #category : #'accessing - selection' }
ToSelectElement >> selectOnlyIndex: anIndex [

	self assertMaxSelectedCount: 1.
	self elementBar selectOnlyIndex: anIndex
]

{ #category : #'accessing - selection' }
ToSelectElement >> selectOnlyIndexes: aCollection [

	self assertMaxSelectedCount: aCollection asSet size.
	self elementBar selectOnlyIndexes: aCollection
]

{ #category : #'accessing - selection' }
ToSelectElement >> selectedData [

	^ self selectionModel selectedIndexesCollect: [ :idx | self dataAccessor at: idx ]
]

{ #category : #'accessing - selection' }
ToSelectElement >> selectedIndexes [

	^ self selectionModel selectedIndexes
]

{ #category : #accessing }
ToSelectElement >> selecter [

	^ self listElement selecter
]

{ #category : #accessing }
ToSelectElement >> selectionModel [

	^ self elementBar selectionModel
]

{ #category : #accessing }
ToSelectElement >> selectionModel: aSelectionModel [

	self elementBar selectionModel: aSelectionModel.
	self iconContainer selectionModel: aSelectionModel
]

{ #category : #'accessing - list' }
ToSelectElement >> setGroupIndex: anIndex [

	self listElement groupSelecter selectIndex: anIndex.
	self listElement unselectableSelecter selectIndex: anIndex
]

{ #category : #'accessing - list' }
ToSelectElement >> setGroupIndexes: anIntegerCollection [

	self listElement groupSelectionModel deselectAll.
	self listElement groupSelecter selectIndexes: anIntegerCollection.
	self listElement unselectableSelecter deselectAll.
	self listElement unselectableSelecter selectIndexes: anIntegerCollection
]

{ #category : #accessing }
ToSelectElement >> sieve [ 

	^ self windowManager sieve
]

{ #category : #accessing }
ToSelectElement >> textInputElement [ 

	^ self nodeContainer textInputElement
]

{ #category : #'t - element with triplet element' }
ToSelectElement >> tripletElement [ 

	^ triplet
]

{ #category : #accessing }
ToSelectElement >> windowManager [

	^ windowManager 
]
