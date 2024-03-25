Class {
	#name : #ToSelectElement,
	#superclass : #ToElement,
	#instVars : [
		'windowManager',
		'fakeData',
		'filtrable',
		'data',
		'nodeWrapping',
		'selectionModel',
		'strategy',
		'hideSelected',
		'iconContainer',
		'headerElement',
		'maxSelectedCount'
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

{ #category : #'accessing selection' }
ToSelectElement >> allowSelectedCount: aNumber [

	^ self maxSelectedCount isZero or: [ aNumber <= self maxSelectedCount ]
]

{ #category : #'accessing selection' }
ToSelectElement >> checkMaxSelectedCount: aNumber [

	(self allowSelectedCount: aNumber) ifFalse: [
		self enqueueTask: (BlTaskAction new action: [
				 Error signal: 'Max selected count reached' ]) ]
]

{ #category : #'accessing window' }
ToSelectElement >> closeWindow [

	^ self windowManager closeWindow
]

{ #category : #'accessing window' }
ToSelectElement >> currentWindow [ 

	^ self windowManager currentWindow
]

{ #category : #accessing }
ToSelectElement >> dataAccessor [ 

	^ data
]

{ #category : #'accessing list' }
ToSelectElement >> dataNodeBuilder: aBuilder [

	self windowManager dataNodeBuilder: aBuilder
]

{ #category : #initialization }
ToSelectElement >> defaultStrategy [

	^ ToSingleSelectStrategy new
]

{ #category : #'accessing selection' }
ToSelectElement >> deselectAll [

	self selectionModel deselectAll.
	self notifySelectionChanged
]

{ #category : #private }
ToSelectElement >> fakeDataItem [

	^ fakeData ifNil: [ fakeData := '' ]
]

{ #category : #accessing }
ToSelectElement >> fakeDataItem: aDataItem [

	fakeData := aDataItem.
	self headerNodeContainer initializeFakeNode
]

{ #category : #private }
ToSelectElement >> fakeNode [

	^ self childWithId: #fakeNode ifNone: [  ]
]

{ #category : #accessing }
ToSelectElement >> filtrable [

	^ filtrable 
]

{ #category : #accessing }
ToSelectElement >> filtrable: aBoolean [

	filtrable = aBoolean ifTrue: [ ^ self ].
	filtrable := aBoolean.
	filtrable
		ifTrue: [ self textInputElement beEditable ]
		ifFalse: [ self textInputElement beReadonly ].
	self requestNewSkin
]

{ #category : #'accessing list' }
ToSelectElement >> groupNodeBuilder: aBuilder [

	self windowManager groupNodeBuilder: aBuilder
]

{ #category : #accessing }
ToSelectElement >> headerElement [

	^ headerElement
]

{ #category : #accessing }
ToSelectElement >> headerNodeBuilder: aValuable [

	self headerNodeContainer headerNodeBuilder: aValuable
]

{ #category : #accessing }
ToSelectElement >> headerNodeContainer [

	^ self headerElement headerNodeContainer
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

	^ iconContainer 
]

{ #category : #accessing }
ToSelectElement >> iconContainer: anIconContainer [

	iconContainer = anIconContainer ifTrue: [ ^ self ].
	iconContainer ifNotNil: [ 
		iconContainer onUninstalledIn: self.
		iconContainer removeFromParent ].
	anIconContainer ifNil: [ ^ self ].
	self addChild: anIconContainer.
	anIconContainer onInstalledIn: self.
	iconContainer := anIconContainer 
]

{ #category : #initialization }
ToSelectElement >> initialize [

	| sharedEventsDistributor |
	super initialize.

	hideSelected := false.
	nodeWrapping := true.
	maxSelectedCount := 0.
	
	data := ToObservableCollection new.
		
	" for the popup "
	windowManager := self newWindowManager.
	data addEventHandler:
		(ToObservableCollectionMirrorUpdater new mirror:
			 windowManager listElement dataAccessor).
	selectionModel := self sieve selectionModel.
	
	filtrable := true.
	self iconContainer: self newIconContainer.
	self strategy: self defaultStrategy.

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
ToSelectElement >> inputTextField [ 

	^ self headerNodeContainer inputTextField
]

{ #category : #initialization }
ToSelectElement >> installHeaderElement [

	headerElement := self newHeaderElement.
	headerElement onInstalledIn: self.
	self addChild: headerElement before: self iconContainer.

]

{ #category : #testing }
ToSelectElement >> isFiltrable [

	^ self filtrable
]

{ #category : #testing }
ToSelectElement >> isMultipleSelection [ 

	^ self strategy isMultipleSelection 
]

{ #category : #testing }
ToSelectElement >> isSingleSelection [ 

	^ self isMultipleSelection not
]

{ #category : #'accessing list' }
ToSelectElement >> listElement [

	^ self windowManager listElement
]

{ #category : #'accessing list' }
ToSelectElement >> listNodeBuilder: aValuable [

	self listElement nodeBuilder: aValuable
]

{ #category : #accessing }
ToSelectElement >> maxSelectedCount [

	^ maxSelectedCount
]

{ #category : #accessing }
ToSelectElement >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber
]

{ #category : #accessing }
ToSelectElement >> multiSelection: aBoolean [

	strategy ifNotNil: [ self strategy onUninstalledIn: self ].
	strategy := aBoolean
		        ifTrue: [ ToMultipleSelectStrategy new ]
		        ifFalse: [ ToSingleSelectStrategy new ].
	strategy onInstalledIn: self.
	self headerElement onUninstalledIn: self.
	
	self requestNewSkin
]

{ #category : #initialization }
ToSelectElement >> newHeaderElement [

	^ ToSelectHeaderElement new
]

{ #category : #initialization }
ToSelectElement >> newIconContainer [

	^ ToSelectIconContainer new
]

{ #category : #skin }
ToSelectElement >> newRawSkin [ 

	^ ToSelectElementSkin new
]

{ #category : #'instance creation' }
ToSelectElement >> newShortcutsStore [ 

	^ ToSelectShortcutsStore new
]

{ #category : #initialization }
ToSelectElement >> newWindowManager [

	| wm |
	wm := ToSelectListWindowManager new.
	wm onInstalledIn: self.
	^ wm
]

{ #category : #accessing }
ToSelectElement >> nodeWrapping [

	^ nodeWrapping 
]

{ #category : #accessing }
ToSelectElement >> nodeWrapping: aBoolean [

	nodeWrapping = aBoolean ifTrue: [ ^ self ].
	nodeWrapping := aBoolean.
	self headerNodeContainer onNodeWrappingChange  
]

{ #category : #'accessing selection' }
ToSelectElement >> notifySelectionChanged [

	self dispatchEvent: ToSelectSelectionChanged new
]

{ #category : #'accessing selection' }
ToSelectElement >> onSelectionChanged [

	self headerNodeContainer refresh.
	self checkMaxSelectedCount: self selectionModel selectedIndexesCount.
	self updateSelectedCountLabel.

	self headerNodeContainer requestLayout.

	self maxSelectedCount isZero ifTrue: [ ^ self ].
	self selectionModel selectedIndexesCount < self maxSelectedCount
		ifTrue: [
			self dataAccessor withIndexDo: [ :d :idx |
				| origIdx |
				origIdx := self sieve dataPositionIndex at: d.
				self listElement disabledSelecter deselectIndex: origIdx.
				self listElement unselectableSelecter deselectIndex: origIdx ].
			^ self ].
	self dataAccessor withIndexDo: [ :d :idx |
		| origIdx |
		origIdx := self sieve dataPositionIndex at: d.
		(self selectionModel containsIndex: origIdx) ifFalse: [
			self listElement disabledSelecter selectIndex: origIdx.
			self listElement unselectableSelecter selectIndex: origIdx ] ]
]

{ #category : #window }
ToSelectElement >> onWindowClosed [

	self headerElement onWindowClosed
]

{ #category : #window }
ToSelectElement >> onWindowOpened [

	self headerElement onWindowOpened
]

{ #category : #accessing }
ToSelectElement >> pattern [

	^ self sieve pattern
]

{ #category : #accessing }
ToSelectElement >> pattern: aPattern [

	self sieve pattern: aPattern
]

{ #category : #'t - element with placeholder' }
ToSelectElement >> placeholderBuilder: aValuable [
	" aValuable takes 2 args: 1 the placeholder to build, 2 the element. 
	If nil, the current builder is removed"

	self headerElement placeholderBuilder: aValuable
]

{ #category : #'t - element with placeholder' }
ToSelectElement >> placeholderText: aText [
	"The text to be shown when no data is selected "

	self headerElement placeholderText: aText
]

{ #category : #'accessing list' }
ToSelectElement >> popupMaxHeight: aNumber [

	self windowManager maxHeight: aNumber
]

{ #category : #'accessing list' }
ToSelectElement >> popupMinHeight: aNumber [

	self windowManager minHeight: aNumber
]

{ #category : #'accessing list' }
ToSelectElement >> popupPositionHook: aValuable [

	self windowManager positionHook: aValuable
]

{ #category : #'accessing list' }
ToSelectElement >> popupSizeHook: aValuable [

	self windowManager sizeHook: aValuable
]

{ #category : #'accessing window' }
ToSelectElement >> popupWindowEvent: anEvent [ 

	^ self windowManager popupWindowEvent: anEvent 
]

{ #category : #'accessing selection' }
ToSelectElement >> selectIndex: anIndex [

	| selectedAfter |
	selectedAfter := Array streamContents: [ :stream |
		                 stream nextPut: anIndex.
		                 stream nextPutAll: self selectedIndexes ].
	self checkMaxSelectedCount: selectedAfter asSet size.
	self selectionModel selectIndex: anIndex.
	self notifySelectionChanged
]

{ #category : #'accessing selection' }
ToSelectElement >> selectIndexes: aCollection [

	| selectedAfter |
	selectedAfter := Array streamContents: [ :stream |
		                 stream nextPutAll: aCollection.
		                 stream nextPutAll: self selectedIndexes ].
	self selectionModel selectIndexes: aCollection.
	self notifySelectionChanged
]

{ #category : #'accessing selection' }
ToSelectElement >> selectOnlyIndex: anIndex [

	self checkMaxSelectedCount: 1.
	self selectionModel deselectAll.
	self selectionModel selectIndex: anIndex.
	self notifySelectionChanged
]

{ #category : #'accessing selection' }
ToSelectElement >> selectOnlyIndexes: aCollection [

	self checkMaxSelectedCount: aCollection asSet size.
	self selectionModel deselectAll.
	self selectionModel selectIndexes: aCollection.
	self notifySelectionChanged
]

{ #category : #'accessing selection' }
ToSelectElement >> selectedData [

	^ self selectionModel selectedIndexesCollect: [ :idx | self dataAccessor at: idx ]
]

{ #category : #'accessing selection' }
ToSelectElement >> selectedIndexes [

	^ self selectionModel selectedIndexes
]

{ #category : #accessing }
ToSelectElement >> selecter [

	^ self listElement selecter
]

{ #category : #accessing }
ToSelectElement >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSelectElement >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #'accessing list' }
ToSelectElement >> setGroupIndex: anIndex [

	self listElement groupSelectionModel selectIndex: anIndex.
	self listElement unselectableSelecter selectIndex: anIndex
]

{ #category : #'accessing list' }
ToSelectElement >> setGroupIndexes: anIntegerCollection [

	self listElement groupSelectionModel deselectAll.
	self listElement groupSelectionModel selectIndexes: anIntegerCollection.
	self listElement unselectableSelecter deselectAll.
	self listElement unselectableSelecter selectIndexes: anIntegerCollection
]

{ #category : #accessing }
ToSelectElement >> sieve [ 

	^ self windowManager sieve
]

{ #category : #accessing }
ToSelectElement >> strategy [ 

	^ strategy
]

{ #category : #accessing }
ToSelectElement >> strategy: aToSelectStrategy [

	self strategy ifNotNil: [ self strategy onUninstalledIn: self ].
	strategy := aToSelectStrategy.
	strategy onInstalledIn: self.
	self headerElement ifNotNil: [ :he |
		he onUninstalledIn: self.
		he removeFromParent ].
	self installHeaderElement.
	self requestNewSkin
]

{ #category : #accessing }
ToSelectElement >> textInputElement [ 

	^ self headerNodeContainer textInputElement
]

{ #category : #private }
ToSelectElement >> updateSelectedCountLabel [

	self iconContainer updateSelectedCountLabel
]

{ #category : #accessing }
ToSelectElement >> windowManager [

	^ windowManager 
]
