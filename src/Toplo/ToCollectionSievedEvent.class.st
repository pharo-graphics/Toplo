Class {
	#name : #ToCollectionSievedEvent,
	#superclass : #ToCollectionAfterChangeEvent,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #sending }
ToCollectionSievedEvent >> sendTo: anObject [

	anObject collectionSievedEvent: self
]

{ #category : #accessing }
ToCollectionSievedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToCollectionSievedEvent >> sieve: aSieve [

	sieve := aSieve
]
