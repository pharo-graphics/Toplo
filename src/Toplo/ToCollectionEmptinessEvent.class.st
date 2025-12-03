Class {
	#name : #ToCollectionEmptinessEvent,
	#superclass : #BlEvent,
	#instVars : [
		'isEmpty'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #accessing }
ToCollectionEmptinessEvent >> isEmpty [

	^ isEmpty
]

{ #category : #accessing }
ToCollectionEmptinessEvent >> isEmpty: aBoolean [

	isEmpty := aBoolean
]

{ #category : #sending }
ToCollectionEmptinessEvent >> sendTo: anObject [

	anObject collectionEmptinessEvent: self
]
