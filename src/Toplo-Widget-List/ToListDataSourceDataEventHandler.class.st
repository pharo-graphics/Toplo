Class {
	#name : #ToListDataSourceDataEventHandler,
	#superclass : #ToObservableCollectionEventHandler,
	#instVars : [
		'infinite'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #'data events handling' }
ToListDataSourceDataEventHandler >> collectionAddEvent: anEvent [

	infinite dataSource notifyItemsInserted: anEvent interval
	
]

{ #category : #'data events handling' }
ToListDataSourceDataEventHandler >> collectionEmptinessEvent: anEvent [

	infinite dispatchEvent:
		(ToListDataSourceEmptinessChangedEvent new
			 isEmpty: anEvent isEmpty;
			 yourself)
]

{ #category : #'data events handling' }
ToListDataSourceDataEventHandler >> collectionFilteredEvent: anEvent [

	infinite dataSource notifyItemsFiltered
]

{ #category : #'data events handling' }
ToListDataSourceDataEventHandler >> collectionRemoveEvent: anEvent [

	infinite dataSource notifyItemsRemoved: anEvent interval
	
]

{ #category : #'data events handling' }
ToListDataSourceDataEventHandler >> collectionSievedEvent: anEvent [

	infinite dataSource notifyItemsSievedWith: anEvent sieve
]

{ #category : #'data events handling' }
ToListDataSourceDataEventHandler >> collectionUpdateEvent: anEvent [

	infinite dataSource notifyItemsChanged: anEvent interval
	
]

{ #category : #accessing }
ToListDataSourceDataEventHandler >> infinite: anInfiniteElement [

	infinite := anInfiniteElement
]
