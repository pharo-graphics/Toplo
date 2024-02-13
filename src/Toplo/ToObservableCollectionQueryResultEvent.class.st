Class {
	#name : #ToObservableCollectionQueryResultEvent,
	#superclass : #BlEvent,
	#instVars : [
		'queryRunner'
	],
	#category : #'Toplo-Core-CollectionQuery'
}

{ #category : #accessing }
ToObservableCollectionQueryResultEvent >> queryRunner [

	^ queryRunner
]

{ #category : #accessing }
ToObservableCollectionQueryResultEvent >> queryRunner: aQueryRunner [

	queryRunner := aQueryRunner
]

{ #category : #sending }
ToObservableCollectionQueryResultEvent >> sendTo: anObject [

	anObject observableCollectionQueryResultEvent: self
]
