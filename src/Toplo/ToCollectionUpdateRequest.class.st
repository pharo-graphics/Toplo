Class {
	#name : #ToCollectionUpdateRequest,
	#superclass : #ToCollectionChangeRequest,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionUpdateRequest >> sendTo: anObject [

	anObject collectionUpdateRequest: self
]
