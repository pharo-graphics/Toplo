Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#traits : 'TToListElementEventHandler',
	#classTraits : 'TToListElementEventHandler classTrait',
	#instVars : [
		'target',
		'selectionRefreshTask'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'event handling' }
ToListElementEventHandler >> blurEvent: anEvent [

	anEvent currentTarget selectionElementsDo: [ :se |se dispatchEvent: anEvent copy].
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
	target innerElement nodesDo: [ :node |
		node dispatchEvent: anEvent copy ].
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

	self refreshSelectionFromEvent: anEvent.
	anEvent currentTarget extentChanged.

]

{ #category : #'selection managing' }
ToListElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | 
		sp mouseProcessor handleLastMouseMove ].
	self refreshSelectionIn: anEvent currentTarget
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
		  ToListHiddenSelectionChangedEvent }
]

{ #category : #'event handling' }
ToListElementEventHandler >> focusEvent: anEvent [

	anEvent currentTarget selectionElementsDo: [ :se |se dispatchEvent: anEvent copy].
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

	| currTarget |

	currTarget := anEvent currentTarget.
	currTarget selecter
		shiftSelection: anEvent itemCount
		from: anEvent position
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> listDataSourceItemsRemovedEvent: anEvent [

	| currTarget |
	currTarget := anEvent currentTarget.
	" update the secondary selection because it can be on the removed nodes "
	currTarget secondarySelecter
		deselectIndex: anEvent position
		to: anEvent position + anEvent itemCount - 1.
	"Have to update directly the selection model here (not from the selecter).
	If done by the selecter, the model update is postponed, the consequence
	can be that the skin can be updated whereas the selection model 
	is not up-to-date leading to a baddly SelectedSkinEvent sent"
	currTarget selectionModel withAllSubModelsDo: [ :sm |
		sm
			deselectIndex: anEvent position
			to: anEvent position + anEvent itemCount - 1 ].
	" since the delection model as been updated, one have to force the renewal 
	of selection elements "
	currTarget selecter
		shiftSelection: anEvent itemCount negated
		from: anEvent position.

	currTarget updateAllSelections
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

	| currTarget |
	currTarget := anEvent currentTarget.
	currTarget stopScroll.
	self withTargetNodeFromEvent: anEvent do: [ :node |
		node dispatchEvent: anEvent copy.
		anEvent consume ].
	(currTarget isFocusable not or: [ currTarget isFocused ]) ifTrue: [ ^ self ].
	currTarget requestFocus.
	anEvent consume
]

{ #category : #'event handling' }
ToListElementEventHandler >> otherClickEvent: anEvent [
]

{ #category : #'event handling' }
ToListElementEventHandler >> primaryClickEvent: anEvent [
	"Request the focus only if a node is not focused after it received the click event
	This can be the case if nodes include a textr field as an example "

	self
		withTargetNodeFromEvent: anEvent
		do: [ :node | node hasFocus ifTrue: [ ^ self ] ].
	"no focused node, then I take the focus"
	target requestFocus
]

{ #category : #'selection managing' }
ToListElementEventHandler >> refreshSelectionFromEvent: anEvent [

	| currTarget |
	currTarget := anEvent currentTarget.
	selectionRefreshTask ifNotNil: [ ^ self ].
	selectionRefreshTask := BlTaskAction new.
	selectionRefreshTask action: [ self refreshSelectionIn: currTarget ].
	currTarget enqueueTask: selectionRefreshTask
]

{ #category : #'selection managing' }
ToListElementEventHandler >> refreshSelectionIn: aTarget [

	aTarget selectionModes do: [ :mode |
		mode selectionOptionDo: [ :option |
			option
				refreshSelectionIn: aTarget
				withSelectionModel: mode selectionModel ] ].
	selectionRefreshTask := nil
]

{ #category : #'event handling' }
ToListElementEventHandler >> secondaryClickEvent: anEvent [
]

{ #category : #'list element handling' }
ToListElementEventHandler >> showHidePlaceholderIn: aListElement [

	aListElement dataAccessor ifEmpty: [ 
		aListElement selectionModel deselectAll.
		self refreshSelectionIn: aListElement.
		^ aListElement showPlaceholder ].
	aListElement hidePlaceholder
]

{ #category : #'list element handling' }
ToListElementEventHandler >> syncNodesSelectionIn: aListElement [

	| option |
	option := aListElement selectionOption.
	option notifyNodesSelectedIn: aListElement
]

{ #category : #accessing }
ToListElementEventHandler >> target [

	^ target
]

{ #category : #accessing }
ToListElementEventHandler >> target: aListElement [

	target := aListElement
]
