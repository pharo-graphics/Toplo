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

{ #category : #initialization }
ToSelect >> defaultEditable [

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

{ #category : #accessing }
ToSelect >> editable: aBoolean [

	(self mode notNil and: [ aBoolean = self isEditable ]) ifTrue: [
		^ self ].
	self mode ifNotNil: [ self mode onUninstalledIn: self ].
	mode := aBoolean
		        ifTrue: [ ToSelectEditableMode new ]
		        ifFalse: [ ToSelectReadOnlyMode new ].
	mode onInstalledIn: self
]

{ #category : #private }
ToSelect >> fakeData [

	^ fakeData ifNil: [ fakeData := '' ]
]

{ #category : #private }
ToSelect >> fakeData: aData [

	fakeData := aData.
	self initializeFakeNode
]

{ #category : #private }
ToSelect >> fakeNode [

	^ self childWithId: #fakeNode ifNone: [  ]
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

	| sharedEventsDistributor contentElement nodeContainer |
	super initialize.
	windowManager := ToSelectWindowManager new.

	self editable: self defaultEditable.
	strategy := self defaultStrategy.
	strategy onInstalledIn: self.
	selectionModel := BlCompositeSelection new.
	self fitContent.
	self layout: BlLinearLayout horizontal.

	" the element that holds the flow"
	contentElement := self newContentElement.
	" the flow element taht contains nodes + the text field "
	nodeContainer := self strategy newNodeContainer.
	contentElement addChild: nodeContainer.
	self addChild: contentElement.
	data := ToObservableCollection new.

	windowManager onInstalledIn: self.

	sharedEventsDistributor := BlSharedEventDistributor new.
	sharedEventsDistributor
		adjustMousePosition: false;
		shareEvents: {
				ToCollectionFilteredEvent.
				ToListUniqueIndexEvent }.

	self listElement data addEventHandler: sharedEventsDistributor.
	self addEventHandler: sharedEventsDistributor.
	self listElement addEventHandler: sharedEventsDistributor.

	self addChild: self newIconContainer.
	self strategy initializeFakeNode
]

{ #category : #testing }
ToSelect >> isEditable [ 

	^ self mode isEditableMode 
]

{ #category : #accessing }
ToSelect >> listElement [

	^ self windowManager listElement
]

{ #category : #accessing }
ToSelect >> mode [

	^ mode
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

{ #category : #accessing }
ToSelect >> nodeContainer [

	^ self childWithId: #nodeContainer
]

{ #category : #'accessing list' }
ToSelect >> onListCloseRequest [

	self isEditable ifFalse: [ ^ self ].
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
