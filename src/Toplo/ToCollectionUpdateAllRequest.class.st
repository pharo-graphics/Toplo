Class {
	#name : #ToCollectionUpdateAllRequest,
	#superclass : #ToCollectionChangeRequest,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionUpdateAllRequest >> sendTo: anObject [

	anObject collectionUpdateAllRequest: self
]
