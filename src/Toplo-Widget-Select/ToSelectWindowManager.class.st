Class {
	#name : #ToSelectWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'maxHeight',
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

	self listElement addEventHandler:
		(ToFilteredListElementEventHandler new
			 taskQueueHolder: anElement;
			 originalData: anElement data;
			 selection: anElement selection;
			 yourself).
	self listElement addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | anElement refreshNodes ]).
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

{ #category : #initialization }
ToSelectWindowManager >> filterString [

	^ self element textField text asString
]

{ #category : #'window handling' }
ToSelectWindowManager >> filterTextFieldUpdated: anEvent [

	self currentWindow ifNil: [ self popupEvent: anEvent ].
	self listElement dispatchEvent: (ToListFilterRequest new pattern: self filterString)
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
