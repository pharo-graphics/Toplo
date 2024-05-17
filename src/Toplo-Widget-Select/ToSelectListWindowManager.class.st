Class {
	#name : #ToSelectListWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'sieve',
		'listGroupNodeBuilder',
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

	^ [ :node :holder |
	  node addChild:
		  (ToLabel text: holder dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultGroupNodeBuilder [

	^ [ :node :holder |
	  node addChild: (ToAttributedLabel text: holder dataItem asString) hMatchParent ]
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

	^ [ :node :holder | | nodebuilder |
		nodebuilder := holder isGroup
		  ifTrue: [  listGroupNodeBuilder]
		  ifFalse: [ listDataNodeBuilder].
	  nodebuilder value: node value: holder ] 
]

{ #category : #initialization }
ToSelectListWindowManager >> defaultNodeFactory [

	^ [ :theHolder |
	  theHolder isGroup
		  ifTrue: [ ToSelectGroupListNode new ]
		  ifFalse: [ ToSelectDataListNode new ] ]
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
	listDataNodeBuilder := self defaultDataNodeBuilder.
	listGroupNodeBuilder := self defaultGroupNodeBuilder 
]

{ #category : #accessing }
ToSelectListWindowManager >> listDataNodeBuilder: aValuable [

	listDataNodeBuilder := aValuable
]

{ #category : #accessing }
ToSelectListWindowManager >> listElement [

	^ listElement 
]

{ #category : #accessing }
ToSelectListWindowManager >> listGroupNodeBuilder: aValuable [

	listGroupNodeBuilder := aValuable
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
	newListElement := ToSelectListElement new.
	newListElement nodeFactory: self defaultNodeFactory.
	newListElement nodeBuilder: self defaultNodeBuilder.
	newListElement nodeContainer maxHeight: self defaultMaxHeight.
	newListElement nodeContainer minHeight: self defaultMinHeight.
	newListElement nodeContainer vFitContent.
	newListElement vFitContent.
	newListElement hMatchParent.
	^ newListElement
]

{ #category : #'api - hooks' }
ToSelectListWindowManager >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	listElement := self newListElement.
	listElement select: self element.

	self element dataAccessor addEventHandler:
		(ToObservableCollectionMirrorUpdater new mirror:
			 listElement dataAccessor).

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

	listElement nodeHolderClass: ToSelectListNodeHolder
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
