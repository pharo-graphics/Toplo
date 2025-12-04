Class {
	#name : #ToItemsQueryResultEvent,
	#superclass : #BlEvent,
	#instVars : [
		'queryRunner'
	],
	#category : #'Toplo-Unused-QueryRunner'
}

{ #category : #accessing }
ToItemsQueryResultEvent >> items [

	^ self queryRunner items
]

{ #category : #accessing }
ToItemsQueryResultEvent >> queryRunner [

	^ queryRunner
]

{ #category : #accessing }
ToItemsQueryResultEvent >> queryRunner: aQueryRunner [

	queryRunner := aQueryRunner
]

{ #category : #sending }
ToItemsQueryResultEvent >> sendTo: anObject [

	anObject itemsQueryResultEvent: self
]
