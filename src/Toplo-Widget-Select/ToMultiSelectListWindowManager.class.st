Class {
	#name : #ToMultiSelectListWindowManager,
	#superclass : #ToSelectListWindowManager,
	#instVars : [
		'listGroupNodeBuilder'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #accessing }
ToMultiSelectListWindowManager >> dataNodeBuilder [

	^ listDataNodeBuilder
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultAutoCloseOnMouseUpDelay [

	^ nil
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultAutoClosePickOutsideEventClass [

	^ BlMouseDownOutsideEvent
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultDataNodeBuilder [

	^ [ :node :holder |
	  node addChild:
		  (ToLabel text: holder dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultGroupNodeBuilder [

	^ [ :node :holder |
	  node addChild: (ToAttributedLabel text: holder dataItem asString) hMatchParent ]
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultMaxHeight [

	^ 300
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultMinHeight [

	^ 0
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultNodeBuilder [

	^ [ :node :holder | | nodebuilder |
		nodebuilder := holder isGroup
		  ifTrue: [  listGroupNodeBuilder]
		  ifFalse: [ listDataNodeBuilder].
	  nodebuilder value: node value: holder ] 
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultNodeFactory [

	^ [ :theHolder |
	  theHolder isGroup
		  ifTrue: [ ToSelectGroupListNode new ]
		  ifFalse: [ ToSelectDataListNode new ] ]
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultPositionHook [

	^ [ :window :theElement :event |
	  window position: (theElement bounds inParent: self anchorRoot) bounds bottomLeft ]
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> defaultSizeHook [

	^ [ :theWindow :theElement :event |
	  theWindow width: theElement measuredWidth]
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> initialize [ 

	super initialize.
	listDataNodeBuilder := self defaultDataNodeBuilder.
	listGroupNodeBuilder := self defaultGroupNodeBuilder 
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> listDataNodeBuilder: aValuable [

	listDataNodeBuilder := aValuable
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> listElement [

	^ listElement 
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> listGroupNodeBuilder: aValuable [

	listGroupNodeBuilder := aValuable
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> maxHeight [

	^ listElement maxHeight
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> maxHeight: aNumber [

	listElement maxHeight: aNumber
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> minHeight [

	^ listElement minHeight
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> minHeight: aNumber [

	listElement minHeight: aNumber
]

{ #category : #initialization }
ToMultiSelectListWindowManager >> newListElement [

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
ToMultiSelectListWindowManager >> onInstalledIn: anElement [

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

	listElement nodeHolderClass: ToMultiSelectListNodeHolder
]

{ #category : #'api - hooks' }
ToMultiSelectListWindowManager >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	sieve onInstalledIn: listElement.
	sieve := nil.
	listElement := nil.

]

{ #category : #'window handling' }
ToMultiSelectListWindowManager >> onWindowClosed [

	super onWindowClosed.
	" if case one of my children has focus "
	self element onWindowClosed.


]

{ #category : #'window handling' }
ToMultiSelectListWindowManager >> onWindowOpened [

	super onWindowOpened.
	self element onWindowOpened
]

{ #category : #'window handling' }
ToMultiSelectListWindowManager >> popupWindowHiddenEvent: anEvent [

	(currentWindow notNil and: [ currentWindow isOpened ]) ifTrue: [
		^ self ].
	currentWindow ifNil: [ self newWindowEvent: anEvent ].
	currentWindow visibility: BlVisibility hidden.
	currentWindow popupEvent: anEvent
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> sieve [ 

	^ sieve
]

{ #category : #accessing }
ToMultiSelectListWindowManager >> windowClass [

	^ ToSelectListWindow 
]
