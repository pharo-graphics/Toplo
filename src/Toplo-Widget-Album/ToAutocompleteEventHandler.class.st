Class {
	#name : #ToAutocompleteEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'windowManager',
		'windowPosition',
		'queryRunner',
		'listElement',
		'currentPattern',
		'moveCount'
	],
	#category : #'Toplo-Widget-Album-Autocompletion'
}

{ #category : #'event handling' }
ToAutocompleteEventHandler >> closeWindow [

	windowManager closeWindow
]

{ #category : #accessing }
ToAutocompleteEventHandler >> currentPattern [

	^ currentPattern 
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> cursorElementMovedEvent: anEvent [

	| cursorElement bnds album |
	album := anEvent currentTarget.
	cursorElement := anEvent currentTarget cursorElement.
	bnds := cursorElement bounds inSpace bounds.
	bnds height isZero ifTrue: [ ^ self ].
	moveCount := moveCount + 1.
	moveCount > 2 ifTrue: [ self closeWindow ].
	windowPosition := bnds bottomRight.
	self refreshWindowFromEvent: anEvent.
	self queryFromIndex: album cursor position in: album
]

{ #category : #accessing }
ToAutocompleteEventHandler >> dataAccessor [ 

	^ self listElement dataAccessor 
]

{ #category : #initialization }
ToAutocompleteEventHandler >> defaultFontSize [

	^ 13
]

{ #category : #initialization }
ToAutocompleteEventHandler >> defaultMaxHeight [

	^ 200
]

{ #category : #initialization }
ToAutocompleteEventHandler >> defaultMinHeight [

	^ 0
]

{ #category : #initialization }
ToAutocompleteEventHandler >> defaultNodeBuilder [

	^ [ :node :holder |
	  | text |
	  text := holder dataItem asString asRopedText.
	  text fontName: holder listElement fontName.
	  text fontSize: holder listElement fontSize.
	(text from: 1 to: (currentPattern size min: text size)) bold.
	  node addChild: ((ToLabel text: text)
			   withNullSkin;
			   yourself) hMatchParent ]
]

{ #category : #initialization }
ToAutocompleteEventHandler >> defaultNodeFactory [

	^ [ :holder | ToNode new ]
]

{ #category : #initialization }
ToAutocompleteEventHandler >> defaultNodeHolderBuilder [

	^ [ :holder :boundDataItem | holder dataItem: boundDataItem ]
]

{ #category : #initialization }
ToAutocompleteEventHandler >> defaultNodeHolderFactory [

	^ [ :dataSource | ToNodeHolder new ]
]

{ #category : #'api - accessing' }
ToAutocompleteEventHandler >> eventsToHandle [

	^ {
		  AlbCursorElementMovedEvent.
		  ToItemsQueryResultEvent }
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> itemsQueryResultEvent: anItemsQueryResultEvent [

	moveCount := 0.

	" if not for right pattern "
	anItemsQueryResultEvent queryRunner pattern = currentPattern
		ifFalse: [
			self closeWindow.
			^ self ].
	" if a result size > 0 "
	anItemsQueryResultEvent items ifNotEmpty: [
		self listElement currentPattern: currentPattern ].	
	
	anItemsQueryResultEvent items ifEmpty: [
		self closeWindow.
		^ self ].

	" update the list and popup "
	self dataAccessor filterResult: anItemsQueryResultEvent items.
	self openWindowFromEvent: anItemsQueryResultEvent
]

{ #category : #accessing }
ToAutocompleteEventHandler >> listElement [ 

	^ listElement 
]

{ #category : #initialization }
ToAutocompleteEventHandler >> newListElement [
 
	| newListElement |
	newListElement := ToAlbumAutocompleteListElement new.
	"newListElement withDecoration: ToAutocompleteListSideBackgroundDecoration."
	newListElement nodeHolderFactory: self defaultNodeHolderFactory.
	newListElement nodeHolderBuilder: self defaultNodeHolderBuilder.
	newListElement nodeFactory: self defaultNodeFactory.
	newListElement nodeBuilder: self defaultNodeBuilder.
	newListElement fontSize: self defaultFontSize.
	newListElement infinite maxHeight: self defaultMaxHeight.
	newListElement infinite minHeight: self defaultMinHeight.
	newListElement infinite vFitContent.
	newListElement vFitContent.
	newListElement hMatchParent.
	^ newListElement
]

{ #category : #'api - hooks' }
ToAutocompleteEventHandler >> onInstalledIn: anElement [

	| selectors |
	super onInstalledIn: anElement.
	selectors := (SystemNavigation default allMethods collect: [ :m |
		              m selector ]) asSet asArray sort.
	moveCount := 0.
	listElement := self newListElement.

	queryRunner := ToItemsQueryRunner new.
	queryRunner onInstalledIn: anElement.
	queryRunner fetcher: [ :theTextField :thePattern |
		selectors select: [ :m |
			m beginsWith: thePattern caseSensitive: true ] ].

	windowManager := ToAnchoredWindowManager new.
	windowManager onInstalledIn: anElement.
	windowManager builder: [ :anchWin :element |
		anchWin root hMatchParent.
		anchWin root vFitContent.
		anchWin root addChild: self listElement ].

	windowManager sizeHook: [ :theWindow :theElement :event |
		theWindow width: 200 ].
	windowManager positionHook: [ :theWindow :theElement :event |
		theWindow position: self windowPosition ]
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> openWindowFromEvent: anEvent [

	windowManager currentWindow ifNil: [
		windowManager popupWindowEvent: anEvent ]
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> queryFromIndex: anIndex in: anAlbum [

	| selecter wordStart sub |
	selecter := anAlbum selecter.
	wordStart := selecter findWordStartBefore: anIndex.
	sub := anAlbum text copyFrom: wordStart to: anIndex.
	currentPattern := sub asString.
	currentPattern
		ifEmpty: [self closeWindow ]
		ifNotEmpty: [ :pat | queryRunner processPattern: pat for: anAlbum ]
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> refreshWindowFromEvent: anEvent [

	windowManager currentWindow ifNotNil: [
		windowManager applyPositionAnsSizeHooksFromEvent: anEvent ].

]

{ #category : #accessing }
ToAutocompleteEventHandler >> windowPosition [ 

	^ windowPosition 
]
