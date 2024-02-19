Class {
	#name : #ToObservableCollectionInfiniteElement,
	#superclass : #ToInfiniteElement,
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #accessing }
ToObservableCollectionInfiniteElement >> dataAccessor [

	^ self dataSource
]

{ #category : #initialization }
ToObservableCollectionInfiniteElement >> defaultDataSource [

	^ ToObservableCollectionInfiniteDataSource new
]
