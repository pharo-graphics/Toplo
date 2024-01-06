Class {
	#name : #ToCollectionUpdateAllEvent,
	#superclass : #ToCollectionAfterChangeEvent,
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionUpdateAllEvent >> sendTo: anObject [

	anObject collectionUpdateAllEvent: self
]
