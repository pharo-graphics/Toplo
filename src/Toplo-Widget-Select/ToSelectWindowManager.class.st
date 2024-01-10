Class {
	#name : #ToSelectWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'maxHeight',
		'dataFilter',
		'filterResult'
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
			 do: [ :event | self filterTextFieldUpdated: event ]).
	anElement textField addEventHandler: (BlEventHandler
			 on: AlbTextReplacedEvent
			 do: [ :event | self filterTextFieldUpdated: event ])
]

{ #category : #accessing }
ToSelectWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
]

{ #category : #accessing }
ToSelectWindowManager >> filterResult: aFilterResultEvent [

	filterResult := ToSelectFilterResult new.
	filterResult indexes: aFilterResultEvent indexes.
	filterResult selectedData: aFilterResultEvent data.
	filterResult buildListFor: self.
	self fitListHeightToContent: filterResult listElement.
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
			dataFilter resetDataFilterPattern.
			filterResult := nil ]
		ifNotEmpty: [ :filter | dataFilter dataFilterPattern: filter ]
]

{ #category : #'window handling' }
ToSelectWindowManager >> fitListHeightToContent: aListElement [

	aListElement height < self maxHeight ifFalse: [ ^ self ].
	aListElement vFitContent.
	aListElement infinite vFitContent.
	aListElement maxHeight: self maxHeight.
	self flag:
		'Have to use this workaround. Else, selection in the listElement don''t work correctly'.
	aListElement hasParent ifFalse: [ ^ self ].
	self currentWindowDo: [ :win |
		win root removeChild: aListElement.
		win root addChild: aListElement ]
]

{ #category : #initialization }
ToSelectWindowManager >> initialize [

	super initialize.
	maxHeight := self defaultMaxHeight.
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

{ #category : #initialization }
ToSelectWindowManager >> newListElement [

	| newListElement |
	newListElement := ToListElement new.
	newListElement vFitContent.
	newListElement hMatchParent.
	newListElement selection: ToCherryPickListSelectionStrategy new.
	newListElement requestFocusOnMouseDown: false.
	newListElement infinite maxHeight: self maxHeight.
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
	dataFilter resetDataFilterPattern.
	filterResult := nil
]

{ #category : #'window handling' }
ToSelectWindowManager >> reset [

	self fitListHeightToContent: self listElement
]
