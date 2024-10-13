Class {
	#name : #ToSelectPopupWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'sieve',
		'nodeBuilder'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultAutoCloseOnMouseUpDelay [

	^ nil
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultAutoClosePickOutsideEventClass [

	^ BlMouseDownOutsideEvent
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultDataNodeBuilder [

	^ [ :node :dataItem :holder |
	  node addChild: (ToLabel text: dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultMaxHeight [

	^ 300
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultMinHeight [

	^ 0
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultNodeBuilder [

	^ [ :node :dataItem :holder | nodeBuilder value: node value: dataItem value: holder ]
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultNodeFactory [

	^ [ :theHolder | ToSelectDataListNode new ]
]

{ #category : #initialization }
ToSelectPopupWindowManager >> defaultSizeHook [

	^ [ :theWindow :theElement :event |
	  theWindow width: theElement measuredWidth]
]

{ #category : #accessing }
ToSelectPopupWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
]

{ #category : #initialization }
ToSelectPopupWindowManager >> initialize [ 

	super initialize.
	nodeBuilder := self defaultDataNodeBuilder
]

{ #category : #accessing }
ToSelectPopupWindowManager >> listDataNodeBuilder: aValuable [

	self
		deprecated: 'Use #nodeBuilder:'
		transformWith: '`@rcvr listDataNodeBuilder: `@arg' -> '`@rcvr nodeBuilder: `@arg'.

	self nodeBuilder: aValuable
]

{ #category : #accessing }
ToSelectPopupWindowManager >> listElement [

	^ listElement 
]

{ #category : #initialization }
ToSelectPopupWindowManager >> listElementClass [

	^ ToSelectListElement
]

{ #category : #accessing }
ToSelectPopupWindowManager >> maxHeight [

	^ listElement maxHeight
]

{ #category : #accessing }
ToSelectPopupWindowManager >> maxHeight: aNumber [

	listElement maxHeight: aNumber
]

{ #category : #accessing }
ToSelectPopupWindowManager >> minHeight [

	^ listElement minHeight
]

{ #category : #accessing }
ToSelectPopupWindowManager >> minHeight: aNumber [

	listElement minHeight: aNumber
]

{ #category : #initialization }
ToSelectPopupWindowManager >> newListElement [

	| newListElement |
	newListElement := self listElementClass new.
	newListElement primarySelectionMode multiple: false.
	newListElement nodeFactory: self defaultNodeFactory.
	newListElement nodeBuilder: self defaultNodeBuilder.
	newListElement innerContainer maxHeight: self defaultMaxHeight.
	newListElement innerContainer minHeight: self defaultMinHeight.
	newListElement innerContainer vFitContent.
	newListElement vFitContent.
	newListElement hMatchParent.
	^ newListElement
]

{ #category : #accessing }
ToSelectPopupWindowManager >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	nodeBuilder := aValuable
]

{ #category : #'api - hooks' }
ToSelectPopupWindowManager >> nodeHolderClass [

	^ ToListNodeHolder
]

{ #category : #'api - hooks' }
ToSelectPopupWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	listElement := self newListElement.
	listElement selectElement: self element.
	listElement focusability: BlFocusability none.

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
ToSelectPopupWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	sieve := nil.
	listElement := nil.

]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> onWindowClosed [

	super onWindowClosed.
	" if case one of my children has focus "
	self element onPopupWindowClosed
]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> onWindowOpened [

	super onWindowOpened.
	self element onPopupWindowOpened
]

{ #category : #'window handling' }
ToSelectPopupWindowManager >> popupWindowHiddenEvent: anEvent [

	(currentWindow notNil and: [ currentWindow isOpened ]) ifTrue: [
		^ self ].
	currentWindow ifNil: [ self newWindowEvent: anEvent ].
	" currentWindow can be nil in case the element is disabled "
	currentWindow visibility: BlVisibility hidden.
	currentWindow popupEvent: anEvent
]

{ #category : #accessing }
ToSelectPopupWindowManager >> sieve [ 

	^ sieve
]

{ #category : #accessing }
ToSelectPopupWindowManager >> windowClass [

	^ ToSelectPopupWindow 
]
