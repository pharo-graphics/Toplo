Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#traits : 'TToListElementEventHandler',
	#classTraits : 'TToListElementEventHandler classTrait',
	#instVars : [
		'selectionRefreshTask'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'element events handling' }
ToListElementEventHandler >> addedToSpaceEvent: anEvent [

	self showHidePlaceholderIn: anEvent currentTarget
]

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
		  ToAddedToSpaceEvent.

		  BlMouseDownEvent.
		  BlClickEvent.
		  BlDoubleClickEvent.

		  ToListNodeAddedEvent.
		  ToListNodeRemovedEvent.

		  BlBoundsHasChangedDuringScrollingEvent.
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.

		  " data source "
		  ToCollectionUpdateAllRequest.
		  ToInfiniteDataSourceEmptinessChangedEvent.

		  BlLayoutResizerChangedEvent.

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

	self showHidePlaceholderIn: anEvent currentTarget
]

{ #category : #'list element handling' }
ToListElementEventHandler >> infiniteDataSourceItemsFiltered: anEvent [
]

{ #category : #'element events handling' }
ToListElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestNewConfiguration
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
		"node dispatchEvent: anEvent copy."
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
	anEvent currentTarget requestFocus
]

{ #category : #'selection managing' }
ToListElementEventHandler >> refreshSelectionFromEvent: anEvent [

	| currTarget |
	currTarget := anEvent currentTarget.
	self refreshSelectionIn: currTarget.
	"selectionRefreshTask ifNotNil: [ ^ self ].
	selectionRefreshTask := BlTaskAction new.
	selectionRefreshTask action: [
		self refreshSelectionIn: currTarget.
		selectionRefreshTask := nil ].
	currTarget enqueueTask: selectionRefreshTask"
]

{ #category : #'selection managing' }
ToListElementEventHandler >> refreshSelectionIn: aTarget [

	aTarget selectionModes do: [ :mode |
		mode selectionOptionDo: [ :option |
			option
				forceRefreshSelectionIn: aTarget
				withSelectionModel: mode selectionModel ] ]
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
