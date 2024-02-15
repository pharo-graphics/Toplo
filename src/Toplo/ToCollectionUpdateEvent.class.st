Class {
	#name : #ToCollectionUpdateEvent,
	#superclass : #ToCollectionAfterChangeEvent,
	#category : 'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionUpdateEvent >> sendTo: anObject [

	anObject collectionUpdateEvent: self
]
