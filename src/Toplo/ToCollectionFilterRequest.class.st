Class {
	#name : #ToCollectionFilterRequest,
	#superclass : #ToCollectionChangeRequest,
	#category : 'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionFilterRequest >> sendTo: anObject [

	anObject collectionFilterRequest: self
]
