Class {
	#name : #ToSelect,
	#superclass : #ToElement,
	#instVars : [
		'windowManager',
		'fakeData',
		'data',
		'selectionModel',
		'strategy',
		'mode'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing list' }
ToSelect >> addData: aData [

	self data add: aData.
	self listElement selection selectIndex: data size
]

{ #category : #accessing }
ToSelect >> contentElement [

	^ self childWithId: #contentElement 
]

{ #category : #'accessing window' }
ToSelect >> currentWindow [ 

	^ self windowManager currentWindow
]

{ #category : #accessing }
ToSelect >> data [

	^ data
]

{ #category : #accessing }
ToSelect >> data: anObservableCollection [

	data := anObservableCollection
]

{ #category : #accessing }
ToSelect >> dataFilter: aValuable [

	self windowManager dataFilter: aValuable
]

{ #category : #initialization }
ToSelect >> defaultFiltrable [

	^ true
]

{ #category : #initialization }
ToSelect >> defaultMultiSelection [

	^ true
]

{ #category : #initialization }
ToSelect >> defaultStrategy [

	^ ToMultiSelectStrategy new
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

	(self mode notNil and: [ aBoolean = self isFiltrable ]) ifTrue: [
		^ self ].
	self mode ifNotNil: [ self mode onUninstalledIn: self ].
	mode := aBoolean
		        ifTrue: [ ToSelectFiltrableMode new ]
		        ifFalse: [ ToSelectReadOnlyMode new ].
	mode onInstalledIn: self
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

	| sharedEventsDistributor contentElement |
	super initialize.
	data := ToObservableCollection new.
	" for the popup "
	windowManager := self newWindowManager.

	" the element that holds the node container"
	contentElement := self newContentElement.
	self addChild: contentElement.
	self addChild: self newIconContainer.
	
	" initialize the mode *** before *** the strategy (the strategy need an installed mode) "
	self filtrable: self defaultFiltrable.
	" initialize the default strategy "
	self multiSelection: self defaultMultiSelection.
	
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

{ #category : #'t - infinite accessing' }
ToSelect >> listNodeBuilder: aValuable [

	self listElement nodeBuilder: aValuable
]

{ #category : #accessing }
ToSelect >> mode [

	^ mode
]

{ #category : #accessing }
ToSelect >> multiSelection: aBoolean [

	(strategy notNil and: [ aBoolean = self isMultiSelection ]) ifTrue: [
		^ self ].
	strategy ifNotNil: [ self strategy onUninstalledIn: self ].
	strategy := aBoolean
		        ifTrue: [ ToMultiSelectStrategy new ]
		        ifFalse: [ ToMonoSelectStrategy new ].
	strategy onInstalledIn: self
]

{ #category : #initialization }
ToSelect >> newContentElement [

	^ ToElement new
		  vFitContent;
		  hMatchParent;
		  id: #contentElement;
		  layout: BlLinearLayout horizontal;
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
ToSelect >> newTextField [

	| textField |
	textField := ToSelectTextField new
		             select: self;
		             id: #textField;
		             yourself.
	textField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [ :event | self mode filterTextFieldUpdated: event ]).
	textField addEventHandler: (BlEventHandler
			 on: AlbTextReplacedEvent
			 do: [ :event | self mode filterTextFieldUpdated: event ]).
	^ textField
]

{ #category : #initialization }
ToSelect >> newWindowManager [

	| wm |
	wm := ToSelectWindowManager new.
	wm onInstalledIn: self.
	^ wm
]

{ #category : #accessing }
ToSelect >> nodeBuilder: aValuable [

	self strategy nodeBuilder: aValuable
]

{ #category : #accessing }
ToSelect >> nodeContainer [

	^ self childWithId: #nodeContainer
]

{ #category : #'accessing list' }
ToSelect >> onListCloseRequest [

	self isFiltrable ifFalse: [ ^ self ].
	self textField requestFocus
]

{ #category : #'accessing window' }
ToSelect >> popupEvent: anEvent [ 

	^ self windowManager popupEvent: anEvent 
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
ToSelect >> selectIndexes: aCollection [

	self mode selectIndexes: aCollection
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
ToSelect >> textField [

	^ self childWithId: #textField 
]

{ #category : #accessing }
ToSelect >> windowManager [

	^ windowManager 
]
