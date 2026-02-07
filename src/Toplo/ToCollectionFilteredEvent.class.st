Class {
	#name : #ToCollectionFilteredEvent,
	#superclass : #ToObservableCollectionEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionFilteredEvent >> sendTo: anObject [

	anObject collectionFilteredEvent: self
]
