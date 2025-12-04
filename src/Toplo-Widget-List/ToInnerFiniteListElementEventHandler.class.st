Class {
	#name : #ToInnerFiniteListElementEventHandler,
	#superclass : #ToListInnerElementEventHandler,
	#category : #'Toplo-Widget-List-InnerFiniteList'
}

{ #category : #'element events handling' }
ToInnerFiniteListElementEventHandler >> barVisibleNodeContainerListChangedEvent: anEvent [

	| innerBar |
	innerBar := anEvent currentTarget.
	innerBar
		onInvisibleNodeContainers: anEvent invisibleNodeContainers
		visibleNodeContainers: anEvent visibleNodeContainers.
	innerBar listElement dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToInnerFiniteListElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToFiniteListVisibleNodeContainerListChangedEvent }
]
