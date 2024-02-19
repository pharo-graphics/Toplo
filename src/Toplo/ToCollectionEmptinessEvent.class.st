Class {
	#name : #ToCollectionEmptinessEvent,
	#superclass : #ToObservableCollectionEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionEmptinessEvent >> sendTo: anObject [

	anObject collectionEmptinessEvent: self
]
