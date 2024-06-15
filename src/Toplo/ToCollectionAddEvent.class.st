Class {
	#name : #ToCollectionAddEvent,
	#superclass : #ToCollectionChangedEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionAddEvent >> sendTo: anObject [

	anObject collectionAddEvent: self
]
