Class {
	#name : #ToCollectionChangeRequest,
	#superclass : #ToCollectionChangedEvent,
	#instVars : [
		'accepted'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToCollectionChangeRequest >> accepted [

	^ accepted ifNil: [ accepted := true ]
]

{ #category : #accessing }
ToCollectionChangeRequest >> accepted: anObject [

	accepted := anObject
]
