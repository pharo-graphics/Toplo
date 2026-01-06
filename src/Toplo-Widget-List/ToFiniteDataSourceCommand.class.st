Class {
	#name : #ToFiniteDataSourceCommand,
	#superclass : #Object,
	#instVars : [
		'positionStart',
		'itemCount'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #accessing }
ToFiniteDataSourceCommand >> itemCount [

	^ itemCount
]

{ #category : #accessing }
ToFiniteDataSourceCommand >> itemCount: anObject [

	itemCount := anObject
]

{ #category : #accessing }
ToFiniteDataSourceCommand >> positionStart [

	^ positionStart
]

{ #category : #accessing }
ToFiniteDataSourceCommand >> positionStart: anObject [

	positionStart := anObject
]
