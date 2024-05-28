Class {
	#name : #ToMultiSelectBarEventHandler,
	#superclass : #ToListElementEventHandler,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'node bar event handling' }
ToMultiSelectBarEventHandler >> barNodeVisibilityEvent: anEvent [
]

{ #category : #'api - accessing' }
ToMultiSelectBarEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { ToBarNodeVisibilityEvent }
]
