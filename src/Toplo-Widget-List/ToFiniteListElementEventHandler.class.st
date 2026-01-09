Class {
	#name : #ToFiniteListElementEventHandler,
	#superclass : #ToListInnerElementEventHandler,
	#instVars : [
		'previousVisibleNodeContainers'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'infinite event handling' }
ToFiniteListElementEventHandler >> boundsHasChangedDuringScrollingEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget listElement.
	listElement forceUpdateAllSelectionsNow.
	listElement requestMouseMoveReplay
]

{ #category : #'element events handling' }
ToFiniteListElementEventHandler >> checkFullyVisibleNodeContainersOnEvent: anEvent [

	| invisibles visibles innerListElement listElement |
	innerListElement := anEvent currentTarget.
	listElement := innerListElement listElement.
	listElement toConfigurationDo: [ :conf |
			(conf isFlowable or: [ conf autoDistribute ])
				ifTrue: [
						invisibles := #(  ).
						visibles := listElement nodeContainers asArray ]
				ifFalse: [
						invisibles := listElement nodeContainersReject:
							              #isFullyVisibleInListElement.
						visibles := listElement nodeContainers difference:
							            invisibles ] ].
	previousVisibleNodeContainers = visibles ifTrue: [ ^ self ].
	previousVisibleNodeContainers := visibles.
	innerListElement dispatchEvent:
		(ToFiniteListVisibleNodeContainersChangedEvent new
			 visibleNodeContainers: visibles;
			 invisibleNodeContainers: invisibles;
			 yourself)
]

{ #category : #'infinite event handling' }
ToFiniteListElementEventHandler >> elementScrolledEvent: anEvent [

	self checkFullyVisibleNodeContainersOnEvent: anEvent
]

{ #category : #'api - accessing' }
ToFiniteListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlElementScrolledEvent.
		  BlBoundsHasChangedDuringScrollingEvent.
		  ToFiniteListVisibleNodeContainersChangedEvent }
]

{ #category : #'element events handling' }
ToFiniteListElementEventHandler >> finiteListVisibleNodeContainersChangedEvent: anEvent [

	| innerListElement |
	innerListElement := anEvent currentTarget.
	innerListElement listElement dispatchEvent: anEvent copy
]
