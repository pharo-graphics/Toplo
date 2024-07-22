Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#traits : 'TToListElementEventHandler',
	#classTraits : 'TToListElementEventHandler classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToListElementEventHandler >> blurEvent: anEvent [

	self syncNodesSelectionIn: anEvent currentTarget 
]

{ #category : #'selection managing' }
ToListElementEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

	self refreshSelectionFromEvent: anEvent
]

{ #category : #'event handling' }
ToListElementEventHandler >> clickEvent: anEvent [

	anEvent isConsumed ifTrue: [ ^ self ].
	anEvent ifPrimary: [ self primaryClickEvent: anEvent ]
		  secondary: [ self secondaryClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self otherClickEvent: anEvent ]
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> collectionUpdateAllRequest: anEvent [

	anEvent currentTarget selectionModel resetAll
]

{ #category : #'mouse handlers' }
ToListElementEventHandler >> doubleClickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	" first, inform the node that a double click is received "
	target innerContainer nodesDo: [ :node |
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

{ #category : #'selection managing' }
ToListElementEventHandler >> elementExtentChangedEvent: anEvent [

	self refreshSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | 
		sp mouseProcessor handleLastMouseMove ].
	self refreshSelectionFromEvent: anEvent.
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

	^ {
		  BlFocusEvent.
		  BlBlurEvent.
		  BlElementAddedToSceneGraphEvent.

		  BlMouseDownEvent.
		  BlClickEvent.
		  BlDoubleClickEvent.

		  ToListNodeAddedEvent.
		  ToListNodeRemovedEvent.

		  BlBoundsHasChangedDuringScrollingEvent.
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.

		  " data source "
		  ToListDataSourceItemsChangeEvent.
		  ToCollectionUpdateAllRequest.
		  ToInfiniteDataSourceEmptinessChangedEvent.
		  BlInfiniteDataSourceItemRangeInserted.
		  BlInfiniteDataSourceItemRangeRemoved.

		  BlLayoutResizerChangedEvent.
		  ToLayoutOrientationChangedEvent.
		  ToLayoutDirectionChangedEvent.

		  ToListPrimarySelectionModeChangedEvent.
		  ToListSecondarySelectionModeChangedEvent.
		  ToListHiddenSelectionChangedEvent.
		  ToSelecterChangedEvent }
]

{ #category : #'event handling' }
ToListElementEventHandler >> focusEvent: anEvent [

	self syncNodesSelectionIn: anEvent currentTarget 
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> infiniteDataSourceEmptinessChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> infiniteDataSourceItemRangeInserted: anEvent [
	" when data source elements are added (before the layout). 
	Pay attention that a sieve will handle also this event ** before ** the list element 
	is actually layouted (and visually up-to-date)."

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
	" when data source elements are removed (before the layout). 
	Pay attention that a sieve will handle also this event ** before ** the list element 
	is actually layouted (and visually up-to-date)."

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

{ #category : #'element events handling' }
ToListElementEventHandler >> layoutDirectionChangedEvent: anEvent [

	anEvent currentTarget dispatchMainLayoutDirectionChanged
]

{ #category : #'element events handling' }
ToListElementEventHandler >> layoutOrientationChangedEvent: anEvent [

	anEvent currentTarget dispatchMainLayoutOrientationChanged 
]

{ #category : #'element events handling' }
ToListElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget dispatchMainResizerChanged 
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

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listHiddenSelectionChangedEvent: anEvent [

	anEvent currentTarget notifyDataSourceChanged 
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listNodeAddedEvent: anEvent [

	| listElement node |
	listElement := anEvent currentTarget.
	node := anEvent node.
	listElement primarySelectionMode onAddedNode: anEvent node
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listNodeRemovedEvent: anEvent [

	| node listElement |
	node := anEvent node.
	listElement := anEvent currentTarget.
	listElement primarySelectionMode onRemovedNode: node.
	node holder unbindDataItem
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listPrimarySelectionModeChangedEvent: anEvent [

	anEvent currentTarget selecter deselectAll 
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listSecondarySelectionModeChangedEvent: anEvent [

	anEvent currentTarget secondarySelecter deselectAll 
]

{ #category : #'event handling' }
ToListElementEventHandler >> middleClickEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToListElementEventHandler >> mouseDownEvent: anEvent [

	| target |
	anEvent isConsumed ifTrue: [ ^ self ].
	target := anEvent currentTarget.
	target isDisabled ifTrue: [ ^ self ].
	target stopScroll.
	target hasFocus ifTrue: [
		anEvent consume.
		^ self ].
	target requestFocus.
	self withTargetNodeFromEvent: anEvent do: [ :node |
		node dispatchEvent: anEvent.
		anEvent consume ].
	anEvent consume
]

{ #category : #'event handling' }
ToListElementEventHandler >> otherClickEvent: anEvent [
]

{ #category : #'event handling' }
ToListElementEventHandler >> primaryClickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self
		withTargetNodeFromEvent: anEvent
		do: [ :node | node dispatchEvent: anEvent copy ]
]

{ #category : #'selection managing' }
ToListElementEventHandler >> refreshSelectionFromEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target selectionModes do: [ :mode |
		mode optionDo: [ :option |
			option groupHolder refreshSelectionIn: target ] ]
]

{ #category : #'event handling' }
ToListElementEventHandler >> secondaryClickEvent: anEvent [
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> selecterChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	" don't use the selecter because it can be disabled "
	target selectionModel deselectAll.
	target notifyPrimarySelectionDirty 
]

{ #category : #'list element handling' }
ToListElementEventHandler >> showHidePlaceholderIn: aListElement [

	aListElement dataAccessor ifEmpty: [ ^ aListElement showPlaceholder ].
	aListElement hidePlaceholder
]

{ #category : #'list element handling' }
ToListElementEventHandler >> syncNodesSelectionIn: aListElement [

	| option |
	option := aListElement primarySelectionMode option.
	option masked ifTrue: [ ^ self ].
	option groupHolder notifyNodesSelectedIn: aListElement
]
