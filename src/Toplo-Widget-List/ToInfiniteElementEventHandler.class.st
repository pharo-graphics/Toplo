Class {
	#name : #ToInfiniteElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]

{ #category : #'api - accessing' }
ToInfiniteElementEventHandler >> eventsToHandle [

	^ {
		  ToInfiniteScrollFinishedEvent.
		  ToInfiniteDataSourceEmptinessChangedEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  BlElementScrolledEvent }
]

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> infiniteDataSourceEmptinessChangedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> infiniteElementAttachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeAddedEvent new
			 node: anEvent element;
			 yourself)
]

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> infiniteElementDetachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeRemovedEvent new
			 node: anEvent element;
			 yourself)
]

{ #category : #'infinite event handling' }
ToInfiniteElementEventHandler >> infiniteScrollFinishedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]
