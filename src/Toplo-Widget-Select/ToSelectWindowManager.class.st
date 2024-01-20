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
ToSelectWindowManager >> defaultAutoCloseOnMouseUpDelay [

	^ nil
]

{ #category : #initialization }
ToSelectWindowManager >> defaultAutoClosePickOutsideEventClass [

	^ BlMouseDownOutsideEvent
]

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
	  window position: (theElement bounds inParent: self anchorRoot) bounds bottomLeft ]
]

{ #category : #initialization }
ToSelectWindowManager >> defaultSizeHook [

	^ [ :theWindow :theElement :event |
	  theWindow width: theElement measuredWidth]
]

{ #category : #accessing }
ToSelectWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
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
	newListElement nodeClass: ToSelectListNode.
	newListElement selectionStrategy: ToSelectListSelectionStrategy new.
	" the list must be multiple even with mono select "
	newListElement selectionStrategy beMultipleSelection.
	newListElement requestFocusOnMouseDown: false.
	newListElement maxHeight: self maxHeight.
	newListElement minHeight: self minHeight.
	newListElement infinite vFitContent.
	newListElement vFitContent.
	newListElement hMatchParent.

	^ newListElement
]

{ #category : #accessing }
ToSelectWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	maxHeight := self defaultMaxHeight.
	minHeight := self defaultMinHeight.
	listElement := self newListElement.
	self builder: [ :selectWin :request |
		selectWin root hMatchParent.
		selectWin root vFitContent.
		selectWin root addChild: self listElement ]
]

{ #category : #accessing }
ToSelectWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	listElement := nil.

]

{ #category : #'window handling' }
ToSelectWindowManager >> onWindowClosed [

	super onWindowClosed.
	" if case one of my children has focus "
	self element strategy onWindowClosed.


]

{ #category : #'window handling' }
ToSelectWindowManager >> onWindowOpened [

	super onWindowOpened.
	self element strategy onWindowOpened


]

{ #category : #accessing }
ToSelectWindowManager >> windowClass [

	^ ToSelectWindow 
]
