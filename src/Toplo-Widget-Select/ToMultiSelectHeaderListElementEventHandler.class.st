Class {
	#name : #ToMultiSelectHeaderListElementEventHandler,
	#superclass : #ToListElementEventHandler,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'api - accessing' }
ToMultiSelectHeaderListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle
	  , { ToFiniteListVisibleNodeContainerListChangedEvent }
]

{ #category : #'event handling' }
ToMultiSelectHeaderListElementEventHandler >> finiteListVisibleNodeContainerListChangedEvent: anEvent [

	| nbInvisible first last listElement |
	listElement := anEvent currentTarget.

	listElement toConfiguration isFlowable ifTrue: [ ^ self ].
	listElement toConfiguration isScrollable ifTrue: [ ^ self ].
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
