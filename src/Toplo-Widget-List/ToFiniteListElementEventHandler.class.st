Class {
	#name : #ToFiniteListElementEventHandler,
	#superclass : #ToInfiniteListElementEventHandler,
	#instVars : [
		'previousVisibleNodeContainers'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'element events handling' }
ToFiniteListElementEventHandler >> checkFullyVisibleNodeContainersOnEvent: anEvent [

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
		(ToFiniteListVisibleNodeContainersChangedEvent new
			 visibleNodeContainers: visibles;
			 invisibleNodeContainers: invisibles;
			 yourself)
]

{ #category : #'infinite event handling' }
ToFiniteListElementEventHandler >> elementScrolledEvent: anEvent [

	super elementScrolledEvent: anEvent.
	self checkFullyVisibleNodeContainersOnEvent: anEvent
]

{ #category : #'api - accessing' }
ToFiniteListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToFiniteListVisibleNodeContainersChangedEvent }
]

{ #category : #'element events handling' }
ToFiniteListElementEventHandler >> finiteListVisibleNodeContainersChangedEvent: anEvent [

	| innerListElement |
	innerListElement := anEvent currentTarget.
	innerListElement listElement dispatchEvent: anEvent copy
]
