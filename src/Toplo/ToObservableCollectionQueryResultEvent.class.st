Class {
	#name : #ToObservableCollectionQueryResultEvent,
	#superclass : #ToObservableCollectionQueryEvent,
	#category : #'Toplo-Core-CollectionQuery'
}

{ #category : #sending }
ToObservableCollectionQueryResultEvent >> sendTo: anObject [

	anObject observableCollectionQueryResultEvent: self
]
