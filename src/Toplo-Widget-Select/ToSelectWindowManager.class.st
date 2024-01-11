Class {
	#name : #ToSelectWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'maxHeight',
		'dataFilter',
		'filterResult',
		'minHeight'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectWindowManager >> defaultMaxHeight [

	^ 300
]

{ #category : #initialization }
ToSelectWindowManager >> defaultMinHeight [

	^ 50
]

{ #category : #initialization }
ToSelectWindowManager >> defaultPositionHook [

	^ [ :window :theElement :event |
	  window position: (theElement bounds inParent: self anchorRoot) bounds bottomLeft + (4 @ 2) ]
]

{ #category : #initialization }
ToSelectWindowManager >> defaultSizeHook [

	^ [ :theWindow :theElement :event |
	  theWindow width: theElement measuredWidth - 8 ]
]

{ #category : #accessing }
ToSelectWindowManager >> element: anElement [

	super element: anElement.
	self listElement addEventHandler: (ToSelectListEventHandler new
			 select: anElement;
			 yourself).
	dataFilter := ToListElementFilter new.
	dataFilter onInstalledIn: anElement.
	dataFilter originalDataProvider: [ anElement data ].
	self element data addEventHandler: (BlEventHandler
			 on: ToCollectionAfterChangeEvent
			 do: [ self listElement data updateAllWith: self element data ]).
	anElement textField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [ :event | self filterTextFieldUpdated: event ]).
	anElement textField addEventHandler: (BlEventHandler
			 on: AlbTextReplacedEvent
			 do: [ :event | self filterTextFieldUpdated: event ])
]

{ #category : #accessing }
ToSelectWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
]

{ #category : #enumerating }
ToSelectWindowManager >> filterResultDo: aBlock [

	filterResult ifNil: [ ^ self ].
	aBlock value: filterResult 
]

{ #category : #accessing }
ToSelectWindowManager >> filterResultEvent: aFilterResultEvent [

	aFilterResultEvent pattern = self filterString ifFalse: [ ^ self ].
	filterResult := ToSelectFilterResult new.
	filterResult indexes: aFilterResultEvent indexes.
	filterResult selectedData: aFilterResultEvent data.
	filterResult applyOn: self.
	
	" now setup what to do when an item is chosen in the filter result list "
	filterResult listElement addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event |
				 | le |
				 le := self listElement.
				 le dispatchSelectionChangedAfter: [
					 | filterIdx |
					 filterIdx := 0.
					 filterResult indexes do: [ :idx |
						 filterIdx := filterIdx + 1.
						 (filterResult listElement selection includes: filterIdx)
							 ifTrue: [ le selection doSelectIndex: idx ]
							 ifFalse: [ le selection doDeselectIndex: idx ] ] ].
				 self onFilterListRemoved ]).
			
	self currentWindow ifNil: [ self popupEvent: aFilterResultEvent ].
	self currentWindow root removeChildren.
	self currentWindow root addChild: filterResult listElement
]

{ #category : #initialization }
ToSelectWindowManager >> filterString [

	^ self element textField text asString
]

{ #category : #'window handling' }
ToSelectWindowManager >> filterTextFieldUpdated: anEvent [

	self filterString
		ifEmpty: [
			self currentWindow ifNil: [ self popupEvent: anEvent ].
			self listElement hasParent ifFalse: [
				self currentWindow root removeChildren.
				self currentWindow root addChild: self listElement ].
			filterResult := nil ]
		ifNotEmpty: [ :filter | dataFilter dataFilterPattern: filter ]
]

{ #category : #initialization }
ToSelectWindowManager >> initialize [

	super initialize.
	maxHeight := self defaultMaxHeight.
	minHeight := self defaultMinHeight.
	listElement := self newListElement.
	self builder: [ :selectWin :request |
		selectWin root hMatchParent.
		selectWin root vFitContent.
		filterResult
			ifNil: [ selectWin root addChild: self listElement ]
			ifNotNil: [ selectWin root addChild: filterResult listElement ] ]
]

{ #category : #accessing }
ToSelectWindowManager >> listElement [

	^ listElement 
]

{ #category : #accessing }
ToSelectWindowManager >> maxHeight [

	^ maxHeight
]

{ #category : #accessing }
ToSelectWindowManager >> maxHeight: anInteger [

	maxHeight := anInteger
]

{ #category : #accessing }
ToSelectWindowManager >> minHeight [

	^ minHeight
]

{ #category : #accessing }
ToSelectWindowManager >> minHeight: anInteger [

	minHeight := anInteger
]

{ #category : #initialization }
ToSelectWindowManager >> newListElement [

	| newListElement |
	newListElement := ToListElement new.
	newListElement vFitContent.
	newListElement hMatchParent.
	newListElement selection: ToCherryPickListSelectionStrategy new.
	newListElement requestFocusOnMouseDown: false.
	newListElement infinite maxHeight: self maxHeight.
	newListElement infinite minHeight: self minHeight.
	newListElement infinite vFitContent.

	^ newListElement
]

{ #category : #'window handling' }
ToSelectWindowManager >> onCloseRequest [

	super onCloseRequest.
	" if case one of my children has focus "
	self element onListCloseRequest.


]

{ #category : #'window handling' }
ToSelectWindowManager >> onFilterListRemoved [

	self element textField text: ''.
	filterResult := nil
]
