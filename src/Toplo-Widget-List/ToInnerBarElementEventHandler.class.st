Class {
	#name : #ToInnerBarElementEventHandler,
	#superclass : #ToListInnerElementEventHandler,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'element events handling' }
ToInnerBarElementEventHandler >> barVisibleNodeListChangedEvent: anEvent [

	| innerBar |
	innerBar := anEvent currentTarget.
	innerBar
		onInvisibleNodes: anEvent invisibleNodes
		visibleNodes: anEvent visibleNodes
]

{ #category : #'api - accessing' }
ToInnerBarElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToBarVisibleNodeListChangedEvent }
]
