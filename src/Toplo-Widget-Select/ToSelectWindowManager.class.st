Class {
	#name : #ToSelectWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'maxHeight',
		'minHeight',
		'filter'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectWindowManager >> defaultMaxHeight [

	^ 200
]

{ #category : #initialization }
ToSelectWindowManager >> defaultMinHeight [

	^ 50
]

{ #category : #initialization }
ToSelectWindowManager >> defaultPositionHook [

	^ [ :window :theElement :event |
	  window position: (theElement bounds inParent: self anchorRoot) bounds bottomLeft + (4 @ 1) ]
]

{ #category : #initialization }
ToSelectWindowManager >> defaultSizeHook [

	^ [ :theWindow :theElement :event |
	  theWindow width: theElement measuredWidth - 8 ]
]

{ #category : #accessing }
ToSelectWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
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
	newListElement selectionStrategy:
		ToCherryPickListSelectionStrategy new.
	newListElement requestFocusOnMouseDown: false.
	newListElement maxHeight: self maxHeight.
	newListElement minHeight: self minHeight.
	newListElement infinite vFitContent.
	newListElement vFitContent.
	newListElement hMatchParent.

	^ newListElement
]

{ #category : #'window handling' }
ToSelectWindowManager >> onCloseRequest [

	super onCloseRequest.
	" if case one of my children has focus "
	self element onListCloseRequest.


]

{ #category : #accessing }
ToSelectWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.

	self listElement addEventHandler: (ToSelectListEventHandler new
			 select: anElement;
			 yourself).
	self listElement addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | anElement strategy refreshNodeContainer ]).

	anElement isEditable ifFalse: [
		anElement data: self listElement data.
		anElement selectionModel: self listElement selectionStrategy selectionModel.
		^ self ].

	anElement data addEventHandler: (BlEventHandler
				 on: ToCollectionAfterChangeEvent
				 do: [ self listElement data updateAllWith: anElement data ]).

	filter := ToListElementFilter new.
	filter taskQueueHolder: anElement.
	filter originalData: anElement data.
	filter selectionModel: anElement selectionModel.
	filter onInstalledIn: self listElement
]

{ #category : #accessing }
ToSelectWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	filter onUninstalledIn: self listElement.
	listElement := nil.

]
