Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#traits : 'TToListElementEventHandler',
	#classTraits : 'TToListElementEventHandler classTrait',
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

	self flag: #ToBeChecked.
	anEvent currentTarget updateAllSelections
]

{ #category : #'event handling' }
ToListElementEventHandler >> clickEvent: anEvent [

	anEvent ifPrimary: [ self primaryClickEvent: anEvent ]
		  secondary: [ self secondaryClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self otherClickEvent: anEvent ]
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

	| listElement |
	listElement := anEvent currentTarget.
	listElement
		updateAllSelections;
		extentChanged.
	listElement spaceDo: [ :sp |
		sp enqueueTask:
			(BlTaskAction new action: [ sp mouseProcessor handleLastMouseMove ]) ].

]

{ #category : #'selection managing' }
ToListElementEventHandler >> elementScrolledEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	listElement updateAllSelections.
	listElement spaceDo: [ :sp |
		sp enqueueTask:
			(BlTaskAction new action: [ sp mouseProcessor handleLastMouseMove ]) ].

]

{ #category : #'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

	^ {
		  BlFocusEvent.
		  BlBlurEvent.
		  ToAddedToSpaceEvent.

		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  BlClickEvent.
		  BlDoubleClickEvent.

		  ToListNodeAddedEvent.
		  ToListNodeRemovedEvent.

		  BlBoundsHasChangedDuringScrollingEvent.
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.

		  " data source "
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

	anEvent touchedIntervals do: [ :int |
		anEvent currentTarget dataSource notifyItemsChanged: int ]
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

	| listElement |
	listElement := anEvent currentTarget.
	listElement stopScroll
]

{ #category : #'mouse handlers' }
ToListElementEventHandler >> mouseUpEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	listElement stopScroll
]

{ #category : #'event handling' }
ToListElementEventHandler >> otherClickEvent: anEvent [
]

{ #category : #'event handling' }
ToListElementEventHandler >> primaryClickEvent: anEvent [

	anEvent currentTarget hasFocus ifTrue: [ ^ self ].
	anEvent currentTarget requestFocus
]

{ #category : #'event handling' }
ToListElementEventHandler >> secondaryClickEvent: anEvent [
]

{ #category : #'list element handling' }
ToListElementEventHandler >> showHidePlaceholderIn: aListElement [

	aListElement dataAccessor ifEmpty: [ 
		aListElement selectionModel deselectAll.
		aListElement updateAllSelections.
		^ aListElement showPlaceholder ].
	aListElement hidePlaceholder
]

{ #category : #'list element handling' }
ToListElementEventHandler >> syncNodesSelectionIn: aListElement [

	| option |
	option := aListElement selectionOption.
	option notifyNodesSelectedIn: aListElement
]
