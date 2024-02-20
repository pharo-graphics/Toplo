Class {
	#name : #ToSelect,
	#superclass : #ToElement,
	#instVars : [
		'windowManager',
		'fakeData',
		'strategy',
		'mode',
		'placeholderText',
		'selection',
		'filtrable',
		'data'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'accessing window' }
ToSelect >> closeWindow [

	^ self windowManager closeWindow
]

{ #category : #'accessing window' }
ToSelect >> currentWindow [ 

	^ self windowManager currentWindow
]

{ #category : #accessing }
ToSelect >> dataAccessor [ 

	^ data
]

{ #category : #accessing }
ToSelect >> dataFilter: aValuable [

	self mode dataFilter: aValuable
]

{ #category : #initialization }
ToSelect >> defaultMode [

	^ ToSelectFiltrableMode new
]

{ #category : #initialization }
ToSelect >> defaultStrategy [

	^ ToSingleSelectStrategy new
]

{ #category : #'accessing selection' }
ToSelect >> deselectIndex: anIndex [

	self inputTextField text: ''.
	self mode deselectIndex: anIndex
]

{ #category : #private }
ToSelect >> fakeDataItem [

	^ fakeData ifNil: [ fakeData := '' ]
]

{ #category : #private }
ToSelect >> fakeDataItem: aDataItem [

	fakeData := aDataItem.
	self strategy initializeFakeNode
]

{ #category : #private }
ToSelect >> fakeNode [

	^ self childWithId: #fakeNode ifNone: [  ]
]

{ #category : #accessing }
ToSelect >> filtrable [

	^ filtrable 
]

{ #category : #accessing }
ToSelect >> filtrable: aBoolean [

	filtrable := aBoolean
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
	filtrable := true.

	data := ToObservableCollection new.

	selection := BlCompositeSelection new.
	" for the popup "
	windowManager := self newWindowManager.

	" the element that holds the node container"
	headerElement := self newHeaderElement.
	self addChild: headerElement.
	self addChild: self newIconContainer.
	
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
ToSelect >> inputTextField [ 

	^ self strategy textInputElement inputTextField
]

{ #category : #testing }
ToSelect >> isFiltrable [

	^ self filtrable
]

{ #category : #testing }
ToSelect >> isMultipleSelection [ 

	^ self strategy isMultipleSelection 
]

{ #category : #testing }
ToSelect >> isSingleSelection [ 

	^ self isMultipleSelection not
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
		        ifTrue: [ ToMultipleSelectStrategy new ]
		        ifFalse: [ ToSingleSelectStrategy new ].
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

{ #category : #accessing }
ToSelect >> pattern [

	^ self sieve pattern
]

{ #category : #accessing }
ToSelect >> pattern: aPattern [

	self sieve pattern: aPattern
]

{ #category : #'t - element with placeholder' }
ToSelect >> placeholderText [
	"The text to be shown when no data is selected "

	^ placeholderText ifNil: [ placeholderText := '' asRopedText ]
]

{ #category : #'t - element with placeholder' }
ToSelect >> placeholderText: aText [
	"The text to be shown when no data is selected "

	placeholderText := aText
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

{ #category : #'accessing window' }
ToSelect >> popupWindowEvent: anEvent [ 

	^ self windowManager popupWindowEvent: anEvent 
]

{ #category : #'accessing selection' }
ToSelect >> selectIndex: anIndex [

	self inputTextField text: ''.
	self mode selectIndex: anIndex
]

{ #category : #'accessing selection' }
ToSelect >> selectedData [

	^ self selectedIndexes collect: [ :idx | self dataAccessor at: idx ]
]

{ #category : #'accessing selection' }
ToSelect >> selectedIndexes [

	^ self selection indices
]

{ #category : #accessing }
ToSelect >> selection [ 

	^ selection
]

{ #category : #accessing }
ToSelect >> sieve [ 

	^ self windowManager sieve
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
ToSelect >> windowManager [

	^ windowManager 
]
