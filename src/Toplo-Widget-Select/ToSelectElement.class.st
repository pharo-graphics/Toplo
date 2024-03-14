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
		'groupIndexes',
		'strategy',
		'hideSelected'
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

{ #category : #'accessing window' }
ToSelectElement >> closeWindow [

	^ self windowManager closeWindow
]

{ #category : #'accessing selection' }
ToSelectElement >> copySelectionFrom: anotherSelectionModel [
	" hide selected nodes if the hideSelected option is true "

	(self isMultipleSelection and: [ self hideSelected ]) ifTrue: [
		| hidden |
		hidden := Array streamContents: [ :stream |
			          self dataAccessor withIndexDo: [ :d :idx |
				          (self listElement selectionModel containsIndex: idx)
					          ifTrue: [ stream nextPut: idx ] ] ].
		self listElement hiddenSelecter selectOnlyIndexes: hidden ].
	self selectionModel selectedIndexes
	= anotherSelectionModel selectedIndexes ifTrue: [ ^ self ].
	self selectionModel copySelectionFrom: anotherSelectionModel.
	self notifySelectionChanged
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

{ #category : #private }
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
		ifTrue: [ self strategy textInputElement beEditable ]
		ifFalse: [ self strategy textInputElement beReadonly ].
	self requestNewSkin
]

{ #category : #'accessing list' }
ToSelectElement >> groupNodeBuilder: aBuilder [

	self windowManager groupNodeBuilder: aBuilder
]

{ #category : #accessing }
ToSelectElement >> headerElement [

	^ self childWithId: #headerElement 
]

{ #category : #accessing }
ToSelectElement >> headerNodeBuilder: aValuable [

	self strategy headerNodeBuilder: aValuable
]

{ #category : #accessing }
ToSelectElement >> headerNodeContainer [

	^ self childWithId: #headerNodeContainer
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
ToSelectElement >> icon [

	^ self childWithId: #icon ifNone: [  ]
]

{ #category : #accessing }
ToSelectElement >> icon: anElement [

	anElement = self icon ifTrue: [ ^ self ].
	self icon ifNotNil: [ :s | self icon removeFromParent ].
	anElement ifNil: [ ^ self ].
	anElement id: #icon.
	self iconContainer addChild: anElement
]

{ #category : #accessing }
ToSelectElement >> iconContainer [

	^ self childWithId: #iconContainer ifNone: [  ]
]

{ #category : #initialization }
ToSelectElement >> initialize [

	| sharedEventsDistributor headerElement |
	super initialize.

	hideSelected := false.
	nodeWrapping := true.
	
	data := ToObservableCollection new.
	groupIndexes := IdentitySet new.
	
	" for the popup "
	windowManager := self newWindowManager.
	data addEventHandler:
		(ToObservableCollectionMirrorUpdater new mirror:
			 windowManager listElement dataAccessor).
	selectionModel := self listElement newSelectionModel.
	
	" the element that holds the node container"
	headerElement := self newHeaderElement.
	self addChild: headerElement.
	self addChild: self newIconContainer.

	filtrable := true.
	strategy := ToSingleSelectStrategy new.
	strategy onInstalledIn: self.

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

	^ self strategy inputTextField
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
ToSelectElement >> multiSelection: aBoolean [

	strategy ifNotNil: [ self strategy onUninstalledIn: self ].
	strategy := aBoolean
		        ifTrue: [ ToMultipleSelectStrategy new ]
		        ifFalse: [ ToSingleSelectStrategy new ].
	strategy onInstalledIn: self.
	self requestNewSkin
]

{ #category : #initialization }
ToSelectElement >> newHeaderElement [

	^ ToSelectHeaderElement new
]

{ #category : #initialization }
ToSelectElement >> newIconContainer [

	^ ToElement new
		  fitContent;
		  id: #iconContainer;
		  layout: BlFrameLayout new;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : #skin }
ToSelectElement >> newRawSkin [ 

	^ ToSelectSkin new
]

{ #category : #'instance creation' }
ToSelectElement >> newShortcutsStore [ 

	^ ToSelectShortcutsStore new
]

{ #category : #initialization }
ToSelectElement >> newWindowManager [

	| wm |
	wm := ToSelectWindowManager new.
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
	self strategy adaptNodeContainerLayout 
]

{ #category : #'accessing selection' }
ToSelectElement >> notifySelectionChanged [

	self dispatchEvent: ToSelectSelectionChanged new
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
ToSelectElement >> selectIndexes: aCollection [

	self selectionModel selectIndexes: aCollection.
	self notifySelectionChanged
]

{ #category : #'accessing selection' }
ToSelectElement >> selectOnlyIndexes: aCollection [

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

	^ self selectionModel indices
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

	groupIndexes add: anIndex.
	self listElement unselectableSelecter selectIndex: anIndex
]

{ #category : #'accessing list' }
ToSelectElement >> setGroupIndexes: anIntegerCollection [

	groupIndexes addAll: anIntegerCollection.
	self listElement unselectableSelecter deselectAll.
	self listElement unselectableSelecter selectIndexes: groupIndexes asArray
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
	self requestNewSkin
]

{ #category : #accessing }
ToSelectElement >> windowManager [

	^ windowManager 
]
