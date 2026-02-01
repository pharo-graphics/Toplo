Class {
	#name : #ToScrollableFiniteListElementEventHandler,
	#superclass : #ToListInnerElementEventHandler,
	#instVars : [
		'previousVisibleNodeContainers'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'infinite event handling' }
ToScrollableFiniteListElementEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget listElement.
	listElement forceUpdateAllSelectionsNow.
	listElement requestMouseMoveReplay
]

{ #category : #'element events handling' }
ToScrollableFiniteListElementEventHandler >> checkFullyVisibleNodeContainersOnEvent: anEvent [

	| invisibles visibles innerListElement listElement |
	innerListElement := anEvent currentTarget.
	listElement := innerListElement listElement.
	invisibles := #(  ).
	visibles := listElement nodeContainers asArray.
	listElement toConfigurationDo: [ :conf |
			(conf isFlowable or: [ conf autoDistribute ])
				ifFalse: [
						invisibles := listElement nodeContainersReject:
							              #isFullyVisibleInListElement.
						visibles := listElement nodeContainers difference:
							            invisibles ] ].
	previousVisibleNodeContainers = visibles ifTrue: [ ^ self ].
	previousVisibleNodeContainers := visibles.

	innerListElement dispatchEvent:
		(ToListVisibleNodeContainersChangedEvent new
			 visibleNodeContainers: visibles;
			 invisibleNodeContainers: invisibles;
			 yourself)
]

{ #category : #'infinite event handling' }
ToScrollableFiniteListElementEventHandler >> elementScrolledEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget listElement.
	self checkFullyVisibleNodeContainersOnEvent: anEvent.
	listElement forceUpdateAllSelectionsNow.
]

{ #category : #'api - accessing' }
ToScrollableFiniteListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlElementScrolledEvent.
		  BlBoundsHasChangedDuringScrollingEvent.
		  ToListVisibleNodeContainersChangedEvent }
]

{ #category : #'element events handling' }
ToScrollableFiniteListElementEventHandler >> listVisibleNodeContainersChangedEvent: anEvent [

	| innerListElement |
	innerListElement := anEvent currentTarget.
	innerListElement listElement dispatchEvent: anEvent copy
]
