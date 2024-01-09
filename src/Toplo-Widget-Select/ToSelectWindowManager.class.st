Class {
	#name : #ToSelectWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'filteredListElement',
		'maxHeight',
		'dataFilter'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #accessing }
ToSelectWindowManager >> currentListElement [

	^ filteredListElement ifNil: [ listElement  ]
]

{ #category : #accessing }
ToSelectWindowManager >> data [

	^ self listElement data
]

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
	anElement textField 
		addEventHandler: (BlEventHandler
				 on: AlbTextEditedEvent
				 do: [ self textUpdated ]).
	anElement textField 
		addEventHandler: (BlEventHandler
				 on: AlbTextReplacedEvent
				 do: [ self textUpdated ])
]

{ #category : #accessing }
ToSelectWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
]

{ #category : #'window handling' }
ToSelectWindowManager >> fitListHeightToContent [

	| l |
	l := self currentListElement.
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
	listElement selection: ToCherryPickListSelectionStrategy new.
	listElement requestFocusOnMouseDown: false.
	listElement infinite maxHeight: self maxHeight.
	listElement infinite vFitContent.

	self builder: [ :selectWin :request |
		selectWin root hMatchParent.
		selectWin root vFitContent.
		selectWin root addChild: self currentListElement ]
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

	filteredListElement ifNotNil: [
		self currentWindowDo: [ :win |
			win root removeChild: filteredListElement.
			win root addChild: self listElement ].
		filteredListElement := nil.
		dataFilter := nil ].
	self fitListHeightToContent.
	'reset' traceCr
]

{ #category : #'window handling' }
ToSelectWindowManager >> textUpdated [

	(self element textField text isNotEmpty and: [ dataFilter isNil ])
		ifTrue: [
			filteredListElement := ToListElement new
				                       vFitContent;
				                       hMatchParent.
			filteredListElement data addAll: self data.
			filteredListElement selection:
				ToCherryPickListSelectionStrategy new.
			filteredListElement requestFocusOnMouseDown: false.
			dataFilter := ToListElementFilter new.
			dataFilter originalDataProvider: [ self data ].
			filteredListElement addEventHandler:
				(ToListElementFilterEventHandler new
					 dataFilter: dataFilter;
					 yourself).
			filteredListElement addEventHandler: (BlEventHandler
					 on: ToDataFilterResultEvent
					 do: [ :event |
					 filteredListElement data filterResult: event data ]).
			filteredListElement
				vFitContent;
				in: [ :e | e infinite vFitContent ];
				maxHeight: self maxHeight.
			filteredListElement addEventHandler: (BlEventHandler
					 on: ToListSelectionChangedEvent
					 do: [ :event |
						 | choice idx origIdx |
						 idx := event currentIndexes anyOne.
						 choice := event currentTarget data at: idx.
						 origIdx := self listElement data indexOf: choice.
						 self listElement selection selectIndex: origIdx.
						 self element textField text: '' ]).
			self currentWindow ifNil: [ self popupEvent: nil ].
			"
			self currentWindowDo: [ :win |
				win root hMatchParent.
				win root vFitContent.
				win root removeChild: self listElement.
				win root addChild: filteredListElement ]" ].

	self element textField text ifNotEmpty: [
		dataFilter dataFilterPattern: self element textField text asString ].
	self fitListHeightToContent
]
