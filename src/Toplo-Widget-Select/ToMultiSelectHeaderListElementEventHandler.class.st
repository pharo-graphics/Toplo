Class {
	#name : #ToMultiSelectHeaderListElementEventHandler,
	#superclass : #ToListElementEventHandler,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'element events handling' }
ToMultiSelectHeaderListElementEventHandler >> elementExtentChangedEvent: anEvent [

	super elementExtentChangedEvent: anEvent.
	anEvent currentTarget updateFromPopupListSelection
]

{ #category : #'api - accessing' }
ToMultiSelectHeaderListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle
	  , { ToFiniteListVisibleNodeContainersChangedEvent }
]

{ #category : #'event handling' }
ToMultiSelectHeaderListElementEventHandler >> finiteListVisibleNodeContainersChangedEvent: anEvent [

	| nbInvisible first last listElement |
	listElement := anEvent currentTarget.

	listElement innerElement toConfiguration isFlowable ifTrue: [ ^ self ].
	listElement innerElement toConfiguration isScrollable ifTrue: [
		^ self ].
	" it is important to check if some datasource command are pending 
	to avoid bad interaction between command "
	listElement innerElement hasPendingCommands ifTrue: [ ^ self ].
	nbInvisible := listElement selectedDataItems size
	               - anEvent visibleNodeContainers size.
	nbInvisible isZero ifTrue: [
			listElement invisibleNodesCommentElement invisibleCount: 0.
			^ self ].
	listElement nodeContainers size = 1 ifTrue: [ ^ self ].
	anEvent invisibleNodeContainers ifEmpty: [ ^ self ].
	first := anEvent invisibleNodeContainers first holder position.
	last := anEvent invisibleNodeContainers last holder position.

	listElement dataAccessor removeFrom: first to: last.
	listElement invisibleNodesCommentElement invisibleCount: nbInvisible
]
