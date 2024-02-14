Class {
	#name : #ToInfiniteObservableCollectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'infinite'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'data events handling' }
ToInfiniteObservableCollectionEventHandler >> collectionEmptinessEvent: anEvent [

	infinite dispatchEvent: ToDataSourceEmptinessEvent new
]

{ #category : #'api - accessing' }
ToInfiniteObservableCollectionEventHandler >> eventsToHandle [

	^ { ToCollectionEmptinessEvent }
]

{ #category : #accessing }
ToInfiniteObservableCollectionEventHandler >> infinite: anInfiniteElement [

	infinite := anInfiniteElement
]
