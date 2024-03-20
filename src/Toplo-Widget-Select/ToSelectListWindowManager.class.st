Class {
	#name : #ToSelectListWindowManager,
	#superclass : #ToPopupWindowManager,
	#instVars : [
		'listElement',
		'sieve',
		'listDataSourceUpdater',
		'dataNodeBuilder',
		'groupNodeBuilder'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectListWindowManager >> dataNodeBuilder [

	^ dataNodeBuilder
]

{ #category : #accessing }
ToSelectListWindowManager >> dataNodeBuilder: aValuable [

	dataNodeBuilder := aValuable
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
		  ifTrue: [ self groupNodeBuilder]
		  ifFalse: [ self dataNodeBuilder].
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

{ #category : #accessing }
ToSelectListWindowManager >> groupNodeBuilder [

	^ groupNodeBuilder
]

{ #category : #accessing }
ToSelectListWindowManager >> groupNodeBuilder: aValuable [

	groupNodeBuilder := aValuable
]

{ #category : #initialization }
ToSelectListWindowManager >> initialize [ 

	super initialize.
	dataNodeBuilder := self defaultDataNodeBuilder.
	groupNodeBuilder := self defaultGroupNodeBuilder 
]

{ #category : #accessing }
ToSelectListWindowManager >> listElement [

	^ listElement 
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
	newListElement nodeHolderFactory: [ ToSelectListNodeHolder new ].
	newListElement nodeFactory: self defaultNodeFactory.
	newListElement nodeBuilder: self defaultNodeBuilder.
	newListElement infinite maxHeight: self defaultMaxHeight.
	newListElement infinite minHeight: self defaultMinHeight.
	newListElement infinite vFitContent.
	newListElement vFitContent.
	newListElement hMatchParent.
	^ newListElement
]

{ #category : #'api - hook' }
ToSelectListWindowManager >> onInstalledIn: anElement [

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
		selectWin root addChild: self listElement.
		self listElement secondarySelectionModel ifEmpty: [
			self listElement secondarySelecter selectIndex: 1 ] ].

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement
]

{ #category : #'api - hook' }
ToSelectListWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	anElement dataAccessor removeEventHandler: listDataSourceUpdater.
	listDataSourceUpdater := nil.
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

{ #category : #accessing }
ToSelectListWindowManager >> sieve [ 

	^ sieve
]

{ #category : #accessing }
ToSelectListWindowManager >> windowClass [

	^ ToSelectListWindow 
]
