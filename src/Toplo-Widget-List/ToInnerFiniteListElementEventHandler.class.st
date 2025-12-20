Class {
	#name : #ToInnerFiniteListElementEventHandler,
	#superclass : #ToListInnerElementEventHandler,
	#instVars : [
		'previousVisibleNodeContainers'
	],
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #'element events handling' }
ToInnerFiniteListElementEventHandler >> checkFullyVisibleNodeContainersOnEvent: anEvent [

	| invisibles visibles innerListElement listElement |
	innerListElement := anEvent currentTarget.
	listElement := innerListElement listElement.
	(listElement toConfiguration isFlowable or: [ listElement toConfiguration autoDistribute ])
		ifTrue: [
				invisibles := #(  ).
				visibles := listElement nodeContainers asArray ]
		ifFalse: [
				invisibles := listElement nodeContainersReject:
					              #isFullyVisibleInListElement.
				visibles := listElement nodeContainers difference: invisibles ].
	previousVisibleNodeContainers = visibles ifTrue: [ ^ self ].
	previousVisibleNodeContainers := visibles.
	innerListElement dispatchEvent:
		(ToFiniteListVisibleNodeContainerListChangedEvent new
			 visibleNodeContainers: visibles;
			 invisibleNodeContainers: invisibles;
			 yourself)
]

{ #category : #'infinite event handling' }
ToInnerFiniteListElementEventHandler >> elementScrolledEvent: anEvent [

	super elementScrolledEvent: anEvent.
	self checkFullyVisibleNodeContainersOnEvent: anEvent
]

{ #category : #'api - accessing' }
ToInnerFiniteListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToFiniteListVisibleNodeContainerListChangedEvent }
]

{ #category : #'element events handling' }
ToInnerFiniteListElementEventHandler >> finiteListVisibleNodeContainerListChangedEvent: anEvent [

	| innerListElement |
	innerListElement := anEvent currentTarget.
	innerListElement
		onInvisibleNodeContainers: anEvent invisibleNodeContainers
		visibleNodeContainers: anEvent visibleNodeContainers.
	innerListElement listElement dispatchEvent: anEvent copy
]
