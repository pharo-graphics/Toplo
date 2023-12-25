Class {
	#name : #ToCollectionRemoveRequest,
	#superclass : #ToCollectionChangeRequest,
	#category : 'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionRemoveRequest >> sendTo: anObject [

	anObject collectionRemoveRequest: self
]
