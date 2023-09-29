Class {
	#name : #ToCollectionFilterEvent,
	#superclass : #ToCollectionAfterChangeEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionFilterEvent >> sendTo: anObject [

	anObject collectionFilterEvent: self
]
