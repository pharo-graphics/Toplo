Class {
	#name : #ToCollectionChangeRequest,
	#superclass : #ToAuthorisationRequestEvent,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToCollectionChangeRequest >> interval [

	^ interval
]

{ #category : #accessing }
ToCollectionChangeRequest >> interval: anObject [

	interval := anObject
]
