Class {
	#name : #ToCollectionEmptinessEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionEmptinessEvent >> sendTo: anObject [

	anObject collectionEmptinessEvent: self
]
