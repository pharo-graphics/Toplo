Class {
	#name : #ToCollectionFilteredEvent,
	#superclass : #ToAbstractCollectionChangedEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionFilteredEvent >> sendTo: anObject [

	anObject collectionFilteredEvent: self
]
