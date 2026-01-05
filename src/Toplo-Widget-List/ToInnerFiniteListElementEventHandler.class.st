Class {
	#name : #ToInnerFiniteListElementEventHandler,
	#superclass : #ToInfiniteListElementEventHandler,
	#instVars : [
		'previousVisibleNodeContainers'
	],
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #'element events handling' }
ToInnerFiniteListElementEventHandler >> checkFullyVisibleNodeContainersOnEvent: anEvent [

	| invisibles visibles innerListElement |
	innerListElement := anEvent currentTarget.
	innerListElement toConfigurationDo: [ :conf |
			(conf isFlowable or: [ conf autoDistribute ])
				ifTrue: [
						invisibles := #(  ).
						visibles := innerListElement nodeContainers asArray ]
				ifFalse: [
						invisibles := innerListElement nodeContainersReject:
							              #isFullyVisibleInListElement.
						visibles := innerListElement nodeContainers difference:
							            invisibles ] ].
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
	innerListElement listElement dispatchEvent: anEvent copy
]
