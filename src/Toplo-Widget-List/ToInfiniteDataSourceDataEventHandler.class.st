Class {
	#name : #ToInfiniteDataSourceDataEventHandler,
	#superclass : #ToObservableCollectionEventHandler,
	#instVars : [
		'infinite'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionAddEvent: anEvent [

	infinite dataSource notifyItemsInserted: anEvent interval
	
]

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionFilterRequest: anEvent [

	infinite dataSource notifyItemsRemoved: anEvent interval
	
]

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionFilteredEvent: anEvent [

	infinite dataSource notifyItemsInserted: anEvent interval
]

{ #category : #'data events handling' }
ToInfiniteDataSourceDataEventHandler >> collectionRemoveEvent: anEvent [

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
