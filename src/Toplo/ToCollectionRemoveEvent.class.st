Class {
	#name : #ToCollectionRemoveEvent,
	#superclass : #ToCollectionChangedEvent,
	#instVars : [
		'removed'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToCollectionRemoveEvent >> removed [

	^ removed
]

{ #category : #accessing }
ToCollectionRemoveEvent >> removed: aCollection [

	removed := aCollection
]

{ #category : #sending }
ToCollectionRemoveEvent >> sendTo: anObject [

	anObject collectionRemoveEvent: self
]
