Class {
	#name : #ToBasicListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'infinite event handling' }
ToBasicListElementEventHandler >> collectionEmptinessEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target enqueueTask: (BlTaskAction new action: [self showHidePlaceholderIn: target ])
]

{ #category : #'mouse handlers' }
ToBasicListElementEventHandler >> doubleClickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	" first, inform the node that a double click is received "
	target infinite childrenDo: [ :node |
		node dispatchEvent: (ToListDoubleClickEvent new
				 listElement: target;
				 sourceEvent: anEvent;
				 yourself) ].
	target dispatchEvent: (ToListStrongSelectionEvent new
			 indexes: target selectionModel selectedIndexes;
			 yourself).
	anEvent consumed: true
]

{ #category : #'element events handling' }
ToBasicListElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'element handlers' }
ToBasicListElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent delta isZero ifTrue: [ ^ self ].
	anEvent currentTarget spaceDo: [ :sp | sp mouseProcessor handleLastMouseMove ]
]

{ #category : #'api - accessing' }
ToBasicListElementEventHandler >> eventsToHandle [

	^ {
		  ToListDataSourceItemsChangeEvent.
		  BlElementAddedToSceneGraphEvent.
		  BlElementScrolledEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.

		  BlMouseDownEvent.
		  BlDoubleClickEvent.

		  " data source "
		  ToCollectionEmptinessEvent.
		  BlInfiniteDataSourceItemRangeInserted.
		  BlInfiniteDataSourceItemRangeRemoved }
]

{ #category : #'infinite event handling' }
ToBasicListElementEventHandler >> infiniteDataSourceItemRangeInserted: anEvent [

	| target dataSourceChangeEvent |
	target := anEvent currentTarget.
	target selectionModel ifEmpty: [ ^ self ].
	dataSourceChangeEvent := ToListDataSourceItemsAddedEvent new
		                         itemCount: anEvent itemCount;
		                         position: anEvent position;
		                         yourself.
	target notifyDataSourceItemsChanged: dataSourceChangeEvent
]

{ #category : #'infinite event handling' }
ToBasicListElementEventHandler >> infiniteDataSourceItemRangeRemoved: anEvent [

	| target dataSourceChangeEvent |
	target := anEvent currentTarget.
	target selectionModel ifEmpty: [ ^ self ].
	dataSourceChangeEvent := ToListDataSourceItemsRemovedEvent new
		                         itemCount: anEvent itemCount;
		                         position: anEvent position;
		                         yourself.
	target notifyDataSourceItemsChanged: dataSourceChangeEvent
]

{ #category : #'infinite event handling' }
ToBasicListElementEventHandler >> infiniteElementAttachedEvent: anEvent [

	| listElement node |
	listElement := anEvent currentTarget.
	node := anEvent element.
	listElement selectionMode onAddedNode: anEvent element
]

{ #category : #'infinite event handling' }
ToBasicListElementEventHandler >> infiniteElementDetachedEvent: anEvent [

	| node listElement |
	node := anEvent element.
	listElement := anEvent currentTarget.
	listElement selectionMode onRemovedNode: node.
	listElement nodeReleaser cull: node cull: node holder.
]

{ #category : #'infinite event handling' }
ToBasicListElementEventHandler >> listDataSourceItemsAddedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target selecter
		shiftSelection: anEvent itemCount
		from: anEvent position
]

{ #category : #'infinite event handling' }
ToBasicListElementEventHandler >> listDataSourceItemsRemovedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target selecter
		shiftSelection: anEvent itemCount negated
		from: anEvent position
]

{ #category : #'infinite event handling' }
ToBasicListElementEventHandler >> listPrimarySelectionModeChangedEvent: anEvent [

	anEvent currentTarget selectionModel deselectAll 
]

{ #category : #'mouse handlers' }
ToBasicListElementEventHandler >> mouseDownEvent: anEvent [

	| target |
	anEvent isConsumed ifTrue: [ ^ self ].
	target := anEvent currentTarget.
	target stopScroll.
	target hasFocus ifTrue: [ ^ self ].
	target requestFocus.
	anEvent consumed: true
]

{ #category : #'list element handling' }
ToBasicListElementEventHandler >> showHidePlaceholderIn: aListElement [

	aListElement dataAccessor ifEmpty: [ ^ aListElement showPlaceholder ].
	aListElement hidePlaceholder
]
