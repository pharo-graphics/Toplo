Class {
	#name : #ToInnerBarElementEventHandler,
	#superclass : #ToListInnerElementEventHandler,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'element events handling' }
ToInnerBarElementEventHandler >> barVisibleNodeContainerListChangedEvent: anEvent [

	| innerBar |
	innerBar := anEvent currentTarget.
	innerBar
		onInvisibleNodeContainers: anEvent invisibleNodeContainers
		visibleNodeContainers: anEvent visibleNodeContainers.
	innerBar listElement dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToInnerBarElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToBarVisibleNodeContainerListChangedEvent }
]
