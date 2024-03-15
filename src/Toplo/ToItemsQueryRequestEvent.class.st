Class {
	#name : #ToItemsQueryRequestEvent,
	#superclass : #BlEvent,
	#instVars : [
		'pattern'
	],
	#category : #'Toplo-Core-QueryRunner'
}

{ #category : #accessing }
ToItemsQueryRequestEvent >> pattern [

	^ pattern
]

{ #category : #accessing }
ToItemsQueryRequestEvent >> pattern: anObject [

	pattern := anObject
]

{ #category : #sending }
ToItemsQueryRequestEvent >> sendTo: anObject [

	anObject itemsQueryRequestEvent: self
]
