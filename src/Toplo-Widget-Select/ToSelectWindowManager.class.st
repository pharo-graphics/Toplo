Class {
	#name : #ToSelectWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'sieve',
		'listDataSourceUpdater'
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

	^ 0
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

	^ listElement maxHeight
]

{ #category : #accessing }
ToSelectWindowManager >> maxHeight: aNumber [

	listElement maxHeight: aNumber
]

{ #category : #accessing }
ToSelectWindowManager >> minHeight [

	^ listElement minHeight
]

{ #category : #accessing }
ToSelectWindowManager >> minHeight: aNumber [

	listElement minHeight: aNumber
]

{ #category : #initialization }
ToSelectWindowManager >> newListElement [

	| newListElement |
	newListElement := ToListElement new.
	newListElement nodeClass: ToSelectListNode.
	newListElement maxHeight: self defaultMaxHeight .
	newListElement minHeight: self defaultMinHeight.
	newListElement infinite vFitContent.
	newListElement vFitContent.
	newListElement hMatchParent.

	^ newListElement
]

{ #category : #accessing }
ToSelectWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	listElement := self newListElement.
	listElement addEventHandler: (ToSelectListElementEventHandler new
			 select: self element;
			 yourself).

	listDataSourceUpdater := ToObservableCollectionMirrorUpdater new
		                         mirror: listElement dataAccessor.
	anElement dataAccessor addEventHandler: listDataSourceUpdater.

	self builder: [ :selectWin :request |
		selectWin root hMatchParent.
		selectWin root vFitContent.
		selectWin root addChild: self listElement ].

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement
]

{ #category : #accessing }
ToSelectWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	anElement dataAccessor removeEventHandler: listDataSourceUpdater.
	listDataSourceUpdater := nil.
	sieve := nil.
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
ToSelectWindowManager >> sieve [ 

	^ sieve
]

{ #category : #accessing }
ToSelectWindowManager >> windowClass [

	^ ToSelectWindow 
]
