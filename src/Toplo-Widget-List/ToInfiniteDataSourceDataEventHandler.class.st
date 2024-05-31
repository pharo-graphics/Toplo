Class {
	#name : #ToInfiniteDataSourceDataEventHandler,
	#superclass : #ToObservableCollectionEventHandler,
	#instVars : [
		'infinite'
	],
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionAddEvent: anEvent [

	infinite dataSource notifyItemsInserted: anEvent interval
	
]

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionAllUpdatedEvent: anEvent [

	infinite dataSource notifyItemsInserted: anEvent interval
	
]

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionEmptinessEvent: anEvent [

	infinite dispatchEvent: (ToInfiniteDataSourceEmptinessChangedEvent new)
]

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionFilteredEvent: anEvent [

	infinite dataSource notifyItemsFiltered
]

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionRemoveEvent: anEvent [

	infinite dataSource notifyItemsRemoved: anEvent interval
	
]

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionSievedEvent: anEvent [

	infinite dataSource notifyItemsSievedWith: anEvent sieve
]

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionUpdateAllRequest: anEvent [

	infinite dataSource notifyItemsRemoved: anEvent interval
]

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionUpdateEvent: anEvent [

	infinite dataSource notifyItemsChanged: anEvent interval
	
]

{ #category : #accessing }
ToInfiniteDataSourceDataEventHandler >> infinite: anInfiniteElement [

	infinite := anInfiniteElement
]
