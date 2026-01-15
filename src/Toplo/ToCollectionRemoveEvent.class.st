Class {
	#name : #ToCollectionRemoveEvent,
	#superclass : #ToCollectionChangedEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionRemoveEvent >> sendTo: anObject [

	anObject collectionRemoveEvent: self
]
