Class {
	#name : #ToObservableCollectionQueryResultEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-CollectionQuery'
}

{ #category : #sending }
ToObservableCollectionQueryResultEvent >> sendTo: anObject [

	anObject observableCollectionQueryResultEvent: self
]
