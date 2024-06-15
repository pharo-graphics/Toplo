Class {
	#name : #ToCollectionAllUpdatedEvent,
	#superclass : #ToCollectionChangedEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionAllUpdatedEvent >> sendTo: anObject [

	anObject collectionAllUpdatedEvent: self
]
