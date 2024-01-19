Class {
	#name : #ToSelect,
	#superclass : #ToElement,
	#instVars : [
		'windowManager',
		'fakeData',
		'data',
		'selectionModel',
		'strategy',
		'mode',
		'placeholderText'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing list' }
ToSelect >> addData: aData [

	self data add: aData.
	self listElement selection selectIndex: data size
]

{ #category : #'accessing window' }
ToSelect >> closeWindow [

	^ self windowManager closeWindow
]

{ #category : #'accessing window' }
ToSelect >> currentWindow [ 

	^ self windowManager currentWindow
]

{ #category : #accessing }
ToSelect >> data [

	^ data ifNil: [ data := ToObservableCollection new ]
]

{ #category : #accessing }
ToSelect >> data: anObservableCollection [

	data := anObservableCollection
]

{ #category : #accessing }
ToSelect >> dataFilter: aValuable [

	self mode dataFilter: aValuable
]

{ #category : #initialization }
ToSelect >> defaultFiltrable [

	^ false
]

{ #category : #initialization }
ToSelect >> defaultMode [

	^ ToSelectFiltrableMode new
]

{ #category : #initialization }
ToSelect >> defaultMultiSelection [

	^ false
]

{ #category : #initialization }
ToSelect >> defaultStrategy [

	^ ToMonoSelectStrategy new
]

{ #category : #'accessing selection' }
ToSelect >> deselectIndex: anIndex [

	self mode deselectIndex: anIndex
]

{ #category : #private }
ToSelect >> fakeData [

	^ fakeData ifNil: [ fakeData := '' ]
]

{ #category : #private }
ToSelect >> fakeData: aData [

	fakeData := aData.
	self strategy initializeFakeNode
]

{ #category : #private }
ToSelect >> fakeNode [

	^ self childWithId: #fakeNode ifNone: [  ]
]

{ #category : #accessing }
ToSelect >> filtrable: aBoolean [

	self mode ifNotNil: [ self mode onUninstalledIn: self ].
	mode := aBoolean
		        ifTrue: [ ToSelectFiltrableMode new ]
		        ifFalse: [ ToSelectReadOnlyMode new ].
	mode onInstalledIn: self
]

{ #category : #accessing }
ToSelect >> headerElement [

	^ self childWithId: #headerElement 
]

{ #category : #accessing }
ToSelect >> headerNodeBuilder: aValuable [

	self strategy headerNodeBuilder: aValuable
]

{ #category : #accessing }
ToSelect >> headerNodeContainer [

	^ self childWithId: #headerNodeContainer
]

{ #category : #accessing }
ToSelect >> icon [

	^ self childWithId: #icon ifNone: [  ]
]

{ #category : #accessing }
ToSelect >> icon: anElement [

	anElement = self icon ifTrue: [ ^ self ].
	self icon ifNotNil: [ :s | self icon removeFromParent ].
	anElement ifNil: [ ^ self ].
	anElement id: #icon.
	self iconContainer addChild: anElement
]

{ #category : #accessing }
ToSelect >> iconContainer [

	^ self childWithId: #iconContainer ifNone: [  ]
]

{ #category : #initialization }
ToSelect >> initialize [

	| sharedEventsDistributor headerElement |
	super initialize.
	" for the popup "
	windowManager := self newWindowManager.

	" the element that holds the node container"
	headerElement := self newHeaderElement.
	self addChild: headerElement.
	self addChild: self newIconContainer.
	
	" initialize the mode *** before *** the strategy (the strategy need an installed mode) "
	self mode: self defaultMode.
	" initialize the default strategy "
	self strategy: self defaultStrategy.
	
	self layout: BlLinearLayout horizontal.
	self fitContent.

	sharedEventsDistributor := BlSharedEventDistributor new.
	sharedEventsDistributor
		adjustMousePosition: false;
		shareEvents: {
				ToCollectionFilteredEvent.
				ToListUniqueIndexEvent }.

	self listElement data addEventHandler: sharedEventsDistributor.
	self addEventHandler: sharedEventsDistributor.
	self listElement addEventHandler: sharedEventsDistributor.

]

{ #category : #accessing }
ToSelect >> inputTextField [

	^ self childWithId: #inputTextField ifNone: [  ]
]

{ #category : #testing }
ToSelect >> isFiltrable [

	^ self mode isFiltrableMode 
]

{ #category : #testing }
ToSelect >> isMultiSelection [ 

	^ self strategy isMultiSelection 
]

{ #category : #accessing }
ToSelect >> listElement [

	^ self windowManager listElement
]

{ #category : #'accessing list' }
ToSelect >> listNodeBuilder: aValuable [

	self listElement nodeBuilder: aValuable
]

{ #category : #accessing }
ToSelect >> mode [

	^ mode
]

{ #category : #accessing }
ToSelect >> mode: aToSelectMode [ 

	self mode ifNotNil: [ self mode onUninstalledIn: self ].
	mode := aToSelectMode.
	mode onInstalledIn: self.
	self strategy ifNotNil: [self strategy reInstall ]
]

{ #category : #accessing }
ToSelect >> multiSelection: aBoolean [

	strategy ifNotNil: [ self strategy onUninstalledIn: self ].
	strategy := aBoolean
		        ifTrue: [ ToMultiSelectStrategy new ]
		        ifFalse: [ ToMonoSelectStrategy new ].
	strategy onInstalledIn: self
]

{ #category : #initialization }
ToSelect >> newHeaderElement [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #headerElement;
		  layout: BlFrameLayout new;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : #initialization }
ToSelect >> newIconContainer [

	^ ToElement new
		  fitContent;
		  id: #iconContainer;
		  layout: BlFrameLayout new;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : #skin }
ToSelect >> newRawSkin [ 

	^ ToSelectSkin new
]

{ #category : #initialization }
ToSelect >> newWindowManager [

	| wm |
	wm := ToSelectWindowManager new.
	wm onInstalledIn: self.
	^ wm
]

{ #category : #'t - element with placeholder' }
ToSelect >> placeholderText [
	"The text to be shown when no data is selected "

	^ placeholderText ifNil: [ placeholderText := '' asRopedText ]
]

{ #category : #'t - element with placeholder' }
ToSelect >> placeholderText: aText [
	"The text to be shown when no data is selected "

	placeholderText := aText.
	self strategy onSelectPlaceholderTextChanged
]

{ #category : #'accessing window' }
ToSelect >> popupEvent: anEvent [ 

	^ self windowManager popupWindowEvent: anEvent 
]

{ #category : #'accessing list' }
ToSelect >> popupMaxHeight [

	^ self windowManager maxHeight
]

{ #category : #'accessing list' }
ToSelect >> popupMaxHeight: aNumber [

	self windowManager maxHeight: aNumber
]

{ #category : #'accessing list' }
ToSelect >> popupMinHeight [

	^ self windowManager minHeight
]

{ #category : #'accessing list' }
ToSelect >> popupMinHeight: aNumber [

	self windowManager minHeight: aNumber
]

{ #category : #'accessing list' }
ToSelect >> popupPositionHook: aValuable [

	self windowManager positionHook: aValuable
]

{ #category : #'accessing list' }
ToSelect >> popupSizeHook: aValuable [

	self windowManager sizeHook: aValuable
]

{ #category : #'accessing selection' }
ToSelect >> selectIndex: anIndex [

	self mode selectIndex: anIndex
]

{ #category : #'accessing selection' }
ToSelect >> selectedData [

	^ self selectedIndexes collect: [ :idx | self data at: idx ]
]

{ #category : #'accessing selection' }
ToSelect >> selectedIndexes [

	^ selectionModel indices
]

{ #category : #accessing }
ToSelect >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSelect >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToSelect >> strategy [ 

	^ strategy
]

{ #category : #accessing }
ToSelect >> strategy: aToSelectStrategy [

	self strategy ifNotNil: [ self strategy onUninstalledIn: self ].
	strategy := aToSelectStrategy.
	strategy onInstalledIn: self
]

{ #category : #accessing }
ToSelect >> textInput [

	^ self childWithId: #textInput ifNone: [  ]
]

{ #category : #accessing }
ToSelect >> windowManager [

	^ windowManager 
]
