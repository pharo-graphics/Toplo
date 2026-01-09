Class {
	#name : #ToListInnerElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #'api - accessing' }
ToListInnerElementEventHandler >> eventsToHandle [

	^ {
		  ToListDataSourceEmptinessChangedEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent }
]

{ #category : #'infinite event handling' }
ToListInnerElementEventHandler >> infiniteElementAttachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeAddedEvent new
			 node: anEvent element node;
			 yourself)
]

{ #category : #'infinite event handling' }
ToListInnerElementEventHandler >> infiniteElementDetachedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent:
		(ToListNodeRemovedEvent new
			 node: anEvent element node;
			 yourself)
]

{ #category : #'infinite event handling' }
ToListInnerElementEventHandler >> listDataSourceEmptinessChangedEvent: anEvent [

	anEvent currentTarget listElement dispatchEvent: anEvent copy
]
