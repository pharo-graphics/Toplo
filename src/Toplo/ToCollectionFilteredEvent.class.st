Class {
	#name : #ToCollectionFilteredEvent,
	#superclass : #ToCollectionChangedEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionFilteredEvent >> sendTo: anObject [

	anObject collectionFilteredEvent: self
]
