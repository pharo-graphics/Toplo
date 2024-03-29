Class {
	#name : #ToCollectionAllUpdatedEvent,
	#superclass : #ToCollectionAfterChangeEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionAllUpdatedEvent >> sendTo: anObject [

	anObject collectionAllUpdatedEvent: self
]
