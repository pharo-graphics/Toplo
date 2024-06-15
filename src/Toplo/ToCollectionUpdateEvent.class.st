Class {
	#name : #ToCollectionUpdateEvent,
	#superclass : #ToCollectionChangedEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionUpdateEvent >> sendTo: anObject [

	anObject collectionUpdateEvent: self
]
