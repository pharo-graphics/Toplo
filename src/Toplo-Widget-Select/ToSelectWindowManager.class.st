Class {
	#name : #ToSelectWindowManager,
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
ToSelectWindowManager >> dataNodeBuilder [

	^ dataNodeBuilder
]

{ #category : #accessing }
ToSelectWindowManager >> dataNodeBuilder: aValuable [

	dataNodeBuilder := aValuable
]

{ #category : #initialization }
ToSelectWindowManager >> defaultAutoCloseOnMouseUpDelay [

	^ nil
]

{ #category : #initialization }
ToSelectWindowManager >> defaultAutoClosePickOutsideEventClass [

	^ BlMouseDownOutsideEvent
]

{ #category : #initialization }
ToSelectWindowManager >> defaultDataNodeBuilder [

	^ [ :node :holder |
	  node addChild:
		  (ToLabel text: holder dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToSelectWindowManager >> defaultGroupNodeBuilder [

	^ [ :node :holder |
	  node addChild: (ToAttributedLabel text: holder dataItem asString) hMatchParent ]
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
ToSelectWindowManager >> defaultNodeBuilder [

	^ [ :node :holder | | nodebuilder |
		nodebuilder := holder isGroup
		  ifTrue: [ self groupNodeBuilder]
		  ifFalse: [ self dataNodeBuilder].
	  nodebuilder value: node value: holder ] 
]

{ #category : #initialization }
ToSelectWindowManager >> defaultNodeFactory [

	^ [ :theHolder |
	  theHolder isGroup
		  ifTrue: [ ToSelectGroupListNode new ]
		  ifFalse: [ ToSelectDataListNode new ] ]
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
ToSelectWindowManager >> groupNodeBuilder [

	^ groupNodeBuilder
]

{ #category : #accessing }
ToSelectWindowManager >> groupNodeBuilder: aValuable [

	groupNodeBuilder := aValuable
]

{ #category : #initialization }
ToSelectWindowManager >> initialize [ 

	super initialize.
	dataNodeBuilder := self defaultDataNodeBuilder.
	groupNodeBuilder := self defaultGroupNodeBuilder 
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
		selectWin root addChild: self listElement.
		self listElement secondarySelectionModel ifEmpty: [
			self listElement secondarySelecter selectIndex: 1 ] ].

	sieve := ToListElementSieve new.
	sieve onInstalledIn: listElement
]

{ #category : #'api - hook' }
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
	self element onWindowClosed.


]

{ #category : #'window handling' }
ToSelectWindowManager >> onWindowOpened [

	super onWindowOpened.
	self element onWindowOpened
]

{ #category : #accessing }
ToSelectWindowManager >> sieve [ 

	^ sieve
]

{ #category : #accessing }
ToSelectWindowManager >> windowClass [

	^ ToSelectWindow 
]
