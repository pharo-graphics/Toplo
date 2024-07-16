Class {
	#name : #ToSelectListWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'sieve',
		'listDataNodeBuilder'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #accessing }
ToSelectListWindowManager >> dataNodeBuilder [

	^ listDataNodeBuilder
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultAutoCloseOnMouseUpDelay [

	^ nil
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultAutoClosePickOutsideEventClass [

	^ BlMouseDownOutsideEvent
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultDataNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: (ToLabel text: dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultMaxHeight [

	^ 300
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultMinHeight [

	^ 0
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder | listDataNodeBuilder value: node value: holder ]
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultNodeFactory [

	^ [ :theHolder | ToSelectDataListNode new ]
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultPositionHook [

	^ [ :window :theElement :event |
	  window position: (theElement bounds inParent: self anchorRoot) bounds bottomLeft ]
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultSizeHook [

	^ [ :theWindow :theElement :event |
	  theWindow width: theElement measuredWidth]
]

{ #category : #accessing }
ToSelectListWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
]

{ #category : #initialization }
ToSelectListWindowManager >> initialize [ 

	super initialize.
	listDataNodeBuilder := self defaultDataNodeBuilder
]

{ #category : #accessing }
ToSelectListWindowManager >> listDataNodeBuilder: aValuable [

	listDataNodeBuilder := aValuable
]

{ #category : #accessing }
ToSelectListWindowManager >> listElement [

	^ listElement 
]

{ #category : #initialization }
ToSelectListWindowManager >> listElementClass [

	^ ToSelectListElement
]

{ #category : #accessing }
ToSelectListWindowManager >> maxHeight [

	^ listElement maxHeight
]

{ #category : #accessing }
ToSelectListWindowManager >> maxHeight: aNumber [

	listElement maxHeight: aNumber
]

{ #category : #accessing }
ToSelectListWindowManager >> minHeight [

	^ listElement minHeight
]

{ #category : #accessing }
ToSelectListWindowManager >> minHeight: aNumber [

	listElement minHeight: aNumber
]

{ #category : #initialization }
ToSelectListWindowManager >> newListElement [

	| newListElement |
	newListElement := self listElementClass new.
	newListElement selectionMode multiple: false.
	newListElement nodeFactory: self defaultNodeFactory.
	newListElement nodeBuilder: self defaultNodeBuilder.
	newListElement innerContainer maxHeight: self defaultMaxHeight.
	newListElement innerContainer minHeight: self defaultMinHeight.
	newListElement innerContainer vFitContent.
	newListElement vFitContent.
	newListElement hMatchParent.
	^ newListElement
]

{ #category : #'api - hooks' }
ToSelectListWindowManager >> nodeHolderClass [

	^ ToSelectListNodeHolder
]

{ #category : #'api - hooks' }
ToSelectListWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	listElement := self newListElement.
	listElement selectElement: self element.

	listElement addEventHandler: (ToSelectListElementEventHandler new
			 select: self element;
			 yourself).

	self builder: [ :selectWin :request |
		selectWin root hMatchParent.
		selectWin root vFitContent.
		selectWin root addChild: self listElement.
		self listElement secondarySelectionModel ifEmpty: [
			self listElement secondarySelecter selectIndex: 1 ] ].

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement.

	listElement nodeHolderClass: self nodeHolderClass
]

{ #category : #'api - hooks' }
ToSelectListWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	sieve := nil.
	listElement := nil.

]

{ #category : #'window handling' }
ToSelectListWindowManager >> onWindowClosed [

	super onWindowClosed.
	" if case one of my children has focus "
	self element onWindowClosed.


]

{ #category : #'window handling' }
ToSelectListWindowManager >> onWindowOpened [

	super onWindowOpened.
	self element onWindowOpened
]

{ #category : #'window handling' }
ToSelectListWindowManager >> popupWindowHiddenEvent: anEvent [

	(currentWindow notNil and: [ currentWindow isOpened ]) ifTrue: [
		^ self ].
	currentWindow ifNil: [ self newWindowEvent: anEvent ].
	currentWindow visibility: BlVisibility hidden.
	currentWindow popupEvent: anEvent
]

{ #category : #accessing }
ToSelectListWindowManager >> sieve [ 

	^ sieve
]

{ #category : #accessing }
ToSelectListWindowManager >> windowClass [

	^ ToSelectListWindow 
]
