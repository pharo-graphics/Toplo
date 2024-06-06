Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'infinite event handling' }
ToListElementEventHandler >> collectionUpdateAllRequest: anEvent [

	anEvent currentTarget selectionModel resetAll
]

{ #category : #'mouse handlers' }
ToListElementEventHandler >> doubleClickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	" first, inform the node that a double click is received "
	target innerContainer childrenDo: [ :node |
		node dispatchEvent: (ToListDoubleClickEvent new
				 sourceEvent: anEvent;
				 yourself) ].
	target dispatchEvent: (ToListStrongSelectionEvent new
			 indexes: target selectionModel selectedIndexes;
			 yourself).
	anEvent consume
]

{ #category : #'element events handling' }
ToListElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'element handlers' }
ToListElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent delta isZero ifTrue: [ ^ self ].
	anEvent currentTarget spaceDo: [ :sp | sp mouseProcessor handleLastMouseMove ]
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  BlElementScrolledEvent.

		  BlMouseDownEvent.
		  BlDoubleClickEvent.

		  ToListNodeAddedEvent.
		  ToListNodeRemovedEvent.

		  " data source "
		  ToListDataSourceItemsChangeEvent.
		  ToCollectionUpdateAllRequest.
		  ToInfiniteDataSourceEmptinessChangedEvent.
		  BlInfiniteDataSourceItemRangeInserted.
		  BlInfiniteDataSourceItemRangeRemoved.

		  ToListHiddenSelectionChangedEvent.
		  ToListUnselectableSelectionChangedEvent.
		  ToListDisabledSelectionChangedEvent }
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> infiniteDataSourceEmptinessChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> infiniteDataSourceItemRangeInserted: anEvent [

	| target dataSourceChangeEvent |
	target := anEvent currentTarget.
	dataSourceChangeEvent := ToListDataSourceItemsAddedEvent new
		                         itemCount: anEvent itemCount;
		                         position: anEvent position;
		                         yourself.
	target notifyDataSourceItemChanged: dataSourceChangeEvent
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> infiniteDataSourceItemRangeRemoved: anEvent [

	| target dataSourceChangeEvent |
	target := anEvent currentTarget.
	dataSourceChangeEvent := ToListDataSourceItemsRemovedEvent new
		                         itemCount: anEvent itemCount;
		                         position: anEvent position;
		                         yourself.
	target notifyDataSourceItemChanged: dataSourceChangeEvent
]

{ #category : #'list element handling' }
ToListElementEventHandler >> infiniteDataSourceItemsFiltered: anEvent [
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listDataSourceItemsAddedEvent: anEvent [

	| target |

	target := anEvent currentTarget.
	target selecter
		shiftSelection: anEvent itemCount
		from: anEvent position
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listDataSourceItemsRemovedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target selecter
		shiftSelection: anEvent itemCount negated
		from: anEvent position
]

{ #category : #'list element handling' }
ToListElementEventHandler >> listDisabledSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	listElement isAttachedToSceneGraph ifFalse: [ ^ self ].

	anEvent selectionModel ifEmpty: [
		listElement dataSource notifyChanged.
		^ self ].
	anEvent selectionModel selectedIndexesIntervalsDo: [ :interval |
		listElement dataSource notifyItemsChanged:
			(interval first to: interval last) ]
]

{ #category : #'list element handling' }
ToListElementEventHandler >> listHiddenSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	listElement isAttachedToSceneGraph ifFalse: [ ^ self ].

	anEvent selectionModel ifEmpty: [
		listElement dataSource notifyChanged.
		^ self ].
	anEvent selectionModel selectedIndexesIntervalsDo: [ :interval |
		listElement dataSource notifyItemsChanged:
			(interval first to: interval last) ]
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listNodeAddedEvent: anEvent [

	| listElement node |
	listElement := anEvent currentTarget.
	node := anEvent node.
	listElement selectionMode onAddedNode: anEvent node
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listNodeRemovedEvent: anEvent [

	| node listElement |
	node := anEvent node.
	listElement := anEvent currentTarget.
	listElement selectionMode onRemovedNode: node.
	node holder unbindDataItem
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listPrimarySelectionModeChangedEvent: anEvent [

	anEvent currentTarget selectionModel deselectAll 
]

{ #category : #'list element handling' }
ToListElementEventHandler >> listUnselectableSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	listElement isAttachedToSceneGraph ifFalse: [ ^ self ].
	listElement innerContainer hasChildren ifFalse: [ ^ self ].
	anEvent selectionModel ifEmpty: [
		listElement dataSource notifyChanged.
		^ self ].

	listElement selectionModel unselectableSelectionModelDo: [ :sm |
		| firstPos lastPos |
		firstPos := listElement innerContainer firstChild holder position.
		lastPos := listElement innerContainer lastChild holder position.
		firstPos to: lastPos do: [ :idx |
			((listElement selectionModel containsIndex: idx) and: [
				 sm containsIndex: idx ]) ifTrue: [
				listElement selecter deselectIndex: idx ] ] ].

	anEvent selectionModel selectedIndexesIntervalsDo: [ :interval |
		listElement dataSource notifyItemsChanged:
			(interval first to: interval last) ]
]

{ #category : #'mouse handlers' }
ToListElementEventHandler >> mouseDownEvent: anEvent [

	| target |
	anEvent isConsumed ifTrue: [ ^ self ].
	target := anEvent currentTarget.
	target stopScroll.
	target hasFocus ifTrue: [ ^ self ].
	target requestFocus.
	anEvent consume
]

{ #category : #'list element handling' }
ToListElementEventHandler >> showHidePlaceholderIn: aListElement [

	aListElement dataAccessor ifEmpty: [ ^ aListElement showPlaceholder ].
	aListElement hidePlaceholder
]
