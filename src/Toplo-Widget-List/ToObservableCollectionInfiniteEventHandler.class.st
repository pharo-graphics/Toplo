Class {
	#name : #ToObservableCollectionInfiniteEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'infinite'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'data events handling' }
ToObservableCollectionInfiniteEventHandler >> collectionEmptinessEvent: anEvent [

	infinite dispatchEvent: ToDataSourceEmptinessEvent new
]

{ #category : #'data events handling' }
ToObservableCollectionInfiniteEventHandler >> collectionFilteredEvent: anEvent [

	infinite dispatchEvent: ToDataSourceFilteredEvent new
]

{ #category : #'api - accessing' }
ToObservableCollectionInfiniteEventHandler >> eventsToHandle [

	^ { ToCollectionEmptinessEvent. ToCollectionFilteredEvent  }
]

{ #category : #accessing }
ToObservableCollectionInfiniteEventHandler >> infinite: anInfiniteElement [

	infinite := anInfiniteElement
]
