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

{ #category : #'api - accessing' }
ToObservableCollectionInfiniteEventHandler >> eventsToHandle [

	^ { ToCollectionEmptinessEvent }
]

{ #category : #accessing }
ToObservableCollectionInfiniteEventHandler >> infinite: anInfiniteElement [

	infinite := anInfiniteElement
]
