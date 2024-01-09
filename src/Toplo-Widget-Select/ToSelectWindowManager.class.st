Class {
	#name : #ToSelectWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'filterListElement',
		'maxHeight',
		'dataFilter',
		'filterIndexes'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #initialization }
ToSelectWindowManager >> defaultMaxHeight [

	^ 300
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
	dataFilter := ToListElementFilter new.
	dataFilter onInstalledIn: anElement.
	dataFilter originalDataProvider: [ anElement data ].
	self element data addEventHandler: (BlEventHandler
			 on: ToCollectionAfterChangeEvent
			 do: [ self listElement data updateAllWith: self element data ]).
	anElement textField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [ :event | self textUpdated: event ]).
	anElement textField addEventHandler: (BlEventHandler
			 on: AlbTextReplacedEvent
			 do: [ :event | self textUpdated: event ]).
	filterListElement addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event |
				 self listElement infinite dispatchSelectionChangedAfter: [
					 | filterIdx |
					 filterIdx := 0.
					 filterIndexes do: [ :idx |
						 filterIdx := filterIdx + 1.
						 (filterListElement selection includes: filterIdx)
							 ifTrue: [ listElement selection doSelectIndex: idx ]
							 ifFalse: [ listElement selection doDeselectIndex: idx ] ] ].
				 anElement textField text: '' ])
]

{ #category : #accessing }
ToSelectWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
]

{ #category : #accessing }
ToSelectWindowManager >> filterResult: aFilterResultEvent [

	| selected cpt |
	filterListElement data filterResult: aFilterResultEvent data.
	filterIndexes := aFilterResultEvent indexes.
	filterIndexes ifEmpty: [ ^ self ].
	selected := OrderedCollection new.
	cpt := 0.
	aFilterResultEvent data asArray
		with: aFilterResultEvent indexes
		do: [ :d :i |
			cpt := cpt + 1.
			(self listElement selection includes: i)
				ifTrue: [ filterListElement selection doSelectIndex: cpt ]
				ifFalse: [ filterListElement selection doDeselectIndex: cpt ] ].
	filterListElement hasParent ifTrue: [ ^ self ].
	self currentWindow root removeChild: self listElement.
	self currentWindow root addChild: filterListElement
]

{ #category : #'window handling' }
ToSelectWindowManager >> fitListHeightToContent [

	| l |
	l := self listElement.
	l height < self maxHeight ifFalse: [ ^ self ].
	l
		vFitContent;
		in: [ :e | e infinite vFitContent ];
		maxHeight: self maxHeight.
	self flag:
		'Have to use this workaround. Else, selection in the listElement don''t work correctly'.
	self currentWindowDo: [ :win |
		win root removeChild: l.
		win root addChild: l ]
]

{ #category : #initialization }
ToSelectWindowManager >> initialize [

	super initialize.
	maxHeight := self defaultMaxHeight.
	listElement := ToListElement new
		               vFitContent;
		               hMatchParent.
	filterListElement := ToListElement new
		               vFitContent;
		               hMatchParent.
	listElement selection: ToCherryPickListSelectionStrategy new.
	filterListElement selection: ToCherryPickListSelectionStrategy new.
	listElement requestFocusOnMouseDown: false.
	filterListElement requestFocusOnMouseDown: false.
	listElement infinite maxHeight: self maxHeight.
	filterListElement infinite maxHeight: self maxHeight.
	listElement infinite vFitContent.
	filterListElement infinite vFitContent.
	filterIndexes := #().
	self builder: [ :selectWin :request |
		selectWin root hMatchParent.
		selectWin root vFitContent.
		selectWin root addChild: self listElement ]
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

{ #category : #'window handling' }
ToSelectWindowManager >> onCloseRequest [

	super onCloseRequest.
	" if case one of my children has focus "
	self element onListCloseRequest.


]

{ #category : #'window handling' }
ToSelectWindowManager >> reset [

	self fitListHeightToContent
]

{ #category : #'window handling' }
ToSelectWindowManager >> textUpdated: anEvent [

	| filter |
	self currentWindow ifNil: [ self popupEvent: anEvent ].
	filter := self element textField text asString.
	filter
		ifEmpty: [
			self listElement hasParent ifFalse: [
				self currentWindow root removeChild: filterListElement.
				self currentWindow root addChild: self listElement ].
			dataFilter dataFilterPattern: filter ]
		ifNotEmpty: [ dataFilter dataFilterPattern: filter ]
]
